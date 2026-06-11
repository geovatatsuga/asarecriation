"""Structured, rotating diagnostics with deduplicated error reports."""

from collections import defaultdict, deque
from datetime import datetime
import hashlib
import json
import logging
from logging.handlers import RotatingFileHandler
import os
import threading
import time
import traceback

from config import LOG_DIR


class SmartLogger:
    def __init__(self):
        self.error_dir = os.path.join(LOG_DIR, "errors")
        self.combat_dir = os.path.join(LOG_DIR, "combat")
        self.metrics_dir = os.path.join(LOG_DIR, "metrics")
        for path in (LOG_DIR, self.error_dir, self.combat_dir, self.metrics_dir):
            os.makedirs(path, exist_ok=True)
        self._lock = threading.RLock()
        self._recent = defaultdict(lambda: deque(maxlen=40))
        self._errors = defaultdict(int)
        self._counters = defaultdict(int)
        self._started = time.time()
        self.run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
        self._totals = defaultdict(int)
        self._latest = logging.getLogger("asa.smart")
        self._latest.setLevel(logging.INFO)
        self._latest.propagate = False
        if not self._latest.handlers:
            handler = RotatingFileHandler(os.path.join(LOG_DIR, "latest.log"), maxBytes=5_000_000, backupCount=3, encoding="utf-8")
            handler.setFormatter(logging.Formatter("%(asctime)s %(message)s"))
            self._latest.addHandler(handler)

    def log(self, source, message, level=None, session=None, **context):
        level = level or self._level(message)
        event = {
            "time": datetime.now().isoformat(timespec="milliseconds"),
            "level": level,
            "source": source,
            "role": self._role(session),
            "message": str(message),
            **context,
        }
        line = json.dumps(event, ensure_ascii=False, default=str)
        with self._lock:
            self._latest.info(line)
            self._counters[f"log_{level.lower()}"] += 1
            if session:
                self._recent[id(session)].append(event)
            if self._combat(message):
                self._append(os.path.join(self.combat_dir, f"combat_{datetime.now():%Y-%m-%d}.log"), line)

    def exception(self, source, exc, session=None, **context):
        trace = "".join(traceback.format_exception(type(exc), exc, exc.__traceback__))
        signature = hashlib.sha1(f"{source}:{type(exc).__name__}:{exc}".encode("utf-8", "replace")).hexdigest()[:12]
        with self._lock:
            self._errors[signature] += 1
            count = self._errors[signature]
            self._counters["exceptions"] += 1
        self.log(source, f"{type(exc).__name__}: {exc}", "ERROR", session, error_id=signature, repeat=count, **context)
        if count != 1 and count % 25:
            return signature
        pd = getattr(session, "player_data", None) or {}
        report = {
            "error_id": signature,
            "occurrence": count,
            "time": datetime.now().isoformat(timespec="seconds"),
            "source": source,
            "role": self._role(session),
            "account_id": getattr(session, "account_id", None),
            "map_id": pd.get("mapId"),
            "position": [pd.get("posX"), pd.get("posY")],
            "hp": pd.get("hp"),
            "is_dead": pd.get("isDead"),
            "context": context,
            "recent_session_events": list(self._recent.get(id(session), ())) if session else [],
            "traceback": trace,
        }
        name = f"error_{datetime.now():%Y-%m-%d_%H-%M-%S}_{signature}.json"
        with open(os.path.join(self.error_dir, name), "w", encoding="utf-8") as file:
            json.dump(report, file, ensure_ascii=False, indent=2, default=str)
        return signature

    def count(self, name, amount=1):
        with self._lock:
            self._counters[name] += amount
            self._totals[name] += amount

    def write_metrics(self, **values):
        with self._lock:
            row = {
                "time": datetime.now().isoformat(timespec="milliseconds"),
                "run_id": self.run_id,
                "uptime_sec": round(time.time() - self._started, 3),
                **values,
                **self._counters,
            }
            self._counters.clear()
            totals = dict(self._totals)
        self._append(os.path.join(self.metrics_dir, f"performance_{datetime.now():%Y-%m-%d}.jsonl"), json.dumps(row, ensure_ascii=False))
        self._write_cache_summary(totals)

    def _write_cache_summary(self, totals):
        requests = totals.get("http_requests", 0)
        hits = totals.get("http_cache_hits", 0)
        summary = {
            "updated_at": datetime.now().isoformat(timespec="seconds"),
            "run_id": self.run_id,
            "uptime_sec": round(time.time() - self._started, 3),
            "requests": requests,
            "downloads_200": totals.get("http_status_200", 0),
            "cache_hits_304": hits,
            "not_found_404": totals.get("http_status_404", 0),
            "bytes_sent": totals.get("http_bytes_sent", 0),
            "repeat_downloads": totals.get("http_repeat_downloads", 0),
            "cache_hit_rate_percent": round((hits / requests) * 100, 2) if requests else 0,
        }
        path = os.path.join(self.metrics_dir, "cache_summary.json")
        temp_path = path + ".tmp"
        with open(temp_path, "w", encoding="utf-8") as file:
            json.dump(summary, file, ensure_ascii=False, indent=2)
        os.replace(temp_path, path)

    @staticmethod
    def _append(path, line):
        with open(path, "a", encoding="utf-8") as file:
            file.write(line + "\n")

    @staticmethod
    def _role(session):
        return getattr(session, "role_name", None) if session else None

    @staticmethod
    def _level(message):
        text = str(message).lower()
        if any(word in text for word in ("erro", "error", "exception", "falha", "failed")):
            return "ERROR"
        if any(word in text for word in ("warn", "desconhecido", "recusado")):
            return "WARNING"
        return "INFO"

    @staticmethod
    def _combat(message):
        text = str(message).lower()
        return any(word in text for word in ("useskill", "attack", "atac", "dano", "damage", "died", "morre", "rebirth", "hp:"))


smart_logger = SmartLogger()
