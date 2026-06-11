import json
import os
import threading
import time
from datetime import datetime


class DebugRoleStore:
    def __init__(self, path):
        self.path = path
        self.lock = threading.Lock()
        self.roles = self._load()

    def _load(self):
        try:
            with open(self.path, "r", encoding="utf-8") as file:
                data = json.load(file)
                return data if isinstance(data, dict) else {}
        except (FileNotFoundError, json.JSONDecodeError, OSError):
            return {}

    def _save(self):
        temp_path = self.path + ".tmp"
        with open(temp_path, "w", encoding="utf-8") as file:
            json.dump(self.roles, file, ensure_ascii=False, indent=2)
        os.replace(temp_path, self.path)

    def list(self, account_id):
        with self.lock:
            return [dict(role) for role in self.roles.get(str(account_id), [])]

    def name_available(self, name):
        with self.lock:
            return not any(
                role.get("name", "").lower() == name.lower()
                for roles in self.roles.values()
                for role in roles
            )

    def create(self, account_id, data):
        key = str(account_id)
        with self.lock:
            if not self.name_available_unlocked(data.get("name", "")):
                return {"error": "Nome ja esta em uso"}
            now = datetime.now().isoformat(timespec="seconds")
            role = {
                "id": int(time.time() * 1000), "name": data.get("name", ""),
                "jobCode": max(1, int(data.get("jobCode") or 1)), "sex": data.get("sex", 0),
                "level": 1, "headIconIndex": data.get("headIconIndex", 0),
                "hairStyleIndex": data.get("hairStyleIndex", 0), "accountId": key,
                "createTime": now, "lastPlayTime": now, "deletedFlag": False,
                "willDeleteTime": "", "equipmentModels": {}, "hasRolePassword": False,
                "mapId": "a1", "posX": 1120, "posY": 2080,
            }
            self.roles.setdefault(key, []).append(role)
            self._save()
            return dict(role)

    def name_available_unlocked(self, name):
        return not any(role.get("name", "").lower() == name.lower()
                       for roles in self.roles.values() for role in roles)

    def select(self, account_id, name):
        with self.lock:
            for role in self.roles.get(str(account_id), []):
                if role.get("name") == name:
                    role["lastPlayTime"] = datetime.now().isoformat(timespec="seconds")
                    self._save()
                    return {"IsDone": 1, "FailureReason": ""}
        return {"IsDone": 0, "FailureReason": "Personagem nao encontrado"}

    def delete(self, account_id, name):
        key = str(account_id)
        with self.lock:
            roles = self.roles.get(key, [])
            remaining = [role for role in roles if role.get("name") != name]
            if len(remaining) == len(roles):
                return {"IsDone": 0, "FailureReason": "Personagem nao encontrado"}
            self.roles[key] = remaining
            self._save()
            return {"IsDone": 1, "FailureReason": ""}
