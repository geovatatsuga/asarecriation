import json
import os

from config import GAME_RESOURCES_DIR


class ResourceIndex:
    """Lazy index for skill and buff-like resource objects."""

    def __init__(self):
        self.by_code = {}
        self.buffs = {}
        self.job_skill_codes = set()
        self.job_skills = {}
        self.basic_attack_codes = set()
        self._load_selected()

    def _load_selected(self):
        decoded = os.path.join(GAME_RESOURCES_DIR, "decoded")
        for name in ("isc.json", "ibc.json", "iix.json"):
            path = os.path.join(decoded, name)
            if not os.path.exists(path):
                continue
            try:
                with open(path, "r", encoding="utf-8") as handle:
                    data = json.load(handle)
                    if name == "isc.json" and isinstance(data, dict):
                        job_skills = data.get("jobSkill", {})
                        if isinstance(job_skills, dict):
                            for job_name, skill_list in job_skills.items():
                                if isinstance(skill_list, list):
                                    self.job_skills[str(job_name)] = set()
                                    for sk in skill_list:
                                        code = sk.get("code") or sk.get("skillCode")
                                        if code:
                                            self.job_skill_codes.add(str(code))
                                            self.job_skills[str(job_name)].add(str(code))
                                            if str(code).startswith("xj"):
                                                self.basic_attack_codes.add(str(code))
                    self._walk(data)
            except Exception as exc:
                print(f"[ResourceIndex] skip {name}: {exc}")

    def _walk(self, value):
        if isinstance(value, list):
            for item in value:
                self._walk(item)
        elif isinstance(value, dict):
            code = value.get("code") or value.get("skillCode")
            if code:
                self.by_code[str(code)] = value
            if value.get("buffId") is not None:
                self.buffs[int(value["buffId"])] = value
            for child in value.values():
                self._walk(child)

    def skill(self, code):
        return self.by_code.get(str(code), {})

    def buff(self, buff_id):
        return self.buffs.get(int(buff_id), {})

    def skills_for_job_code(self, job_code):
        names = ["paladin", "elf", "killer", "fairy", "priest", "trainer", "druid"]
        index = int(job_code)
        return self.job_skills.get(names[index], set()) if 0 <= index < len(names) else set()

    def basic_attack_for_job_code(self, job_code):
        try:
            index = int(job_code)
        except (TypeError, ValueError):
            index = 0
        if 0 <= index <= 6:
            return f"xj{index + 1}"
        return "xj1"

    def is_basic_attack(self, code):
        code = str(code)
        return code in self.basic_attack_codes or code in {"basic", "za0", "hg1"}
