from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from typing import Dict

class SkillHandler(BaseHandler):
    PLAYER_LEARN_SKILL_REQUEST = 657
    PLAYER_SKILL_CD_CHECK_NOTIFY = 569

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_LEARN_SKILL_REQUEST: 'handle_learn_skill',
        }

    def handle_learn_skill(self, reader: PacketReader):
        try:
            skill_kind = reader.read_byte()
            skill_code = reader.read_string()
            ss_key = reader.read_short()
            self.log(f"PLAYER_LEARN_SKILL_REQUEST: kind={skill_kind}, skill={skill_code}, ss_key={ss_key}")
            
            if not self.player_data:
                return
            skill_config = self.server.resource_index.skill(skill_code)
            if not skill_config:
                self.log(f"Rejected unknown skill code: {skill_code}")
                return
            is_basic_attack = (
                self.server.resource_index.is_basic_attack(skill_code)
                if hasattr(self.server.resource_index, 'is_basic_attack')
                else str(skill_code) in {'basic', 'za0', 'hg1', 'xj1', 'xj2', 'xj3', 'xj4', 'xj5', 'xj6', 'xj7'}
            )
            if is_basic_attack:
                skills = self.player_data.setdefault('learnedSkills', {})
                if int(skills.get(skill_code, 0)) <= 0:
                    skills[skill_code] = 1
                notify = PacketBuilder()
                notify.write_byte(skill_kind)
                notify.write_string(skill_code)
                notify.write_byte(1)
                self.send_packet(notify.build(659))
                self.log(f"Basic attack {skill_code} acknowledged without consuming skill points")
                return
            job_skills = self.server.resource_index.skills_for_job_code(self.player_data.get('jobCode', 0))
            if skill_kind != 0 or skill_code not in job_skills:
                self.log(f"Rejected skill from wrong category/job: kind={skill_kind}, skill={skill_code}")
                return
            levels = skill_config.get('levelInfo') or skill_config.get('levels') or []
            max_level = len(levels) if isinstance(levels, list) and levels else int(skill_config.get('maxLevel', 1))
            skills = self.player_data.setdefault('learnedSkills', {})
            current_level = int(skills.get(skill_code, 0))
            if current_level >= max_level:
                self.log(f"Rejected skill upgrade beyond max level: {skill_code} {current_level}/{max_level}")
                return

            # Calculate total skill points available
            level = int(self.player_data.get('level', 1))
            reborn_times = int(self.player_data.get('rebornTimes', 0))
            
            reborn_time_array = [12, 26, 50, 60]
            reborn_skill_pts = 0
            if reborn_times > 0:
                idx = min(reborn_times, len(reborn_time_array)) - 1
                reborn_skill_pts = reborn_time_array[idx]
            
            # Match PlayerSkillManager.getTotalSkillPoint() in the Flash client.
            total_skill_points = max(0, level // 2 + reborn_skill_pts)
            
            # Calculate used skill points
            used_skill_points = 0
            for code, lvl in skills.items():
                if code == "basic":
                    continue
                if hasattr(self.server.resource_index, 'job_skill_codes') and code in self.server.resource_index.job_skill_codes:
                    skill_cfg = self.server.resource_index.skill(code)
                    if skill_cfg.get('maxLevel', 1) > 1:
                        used_skill_points += int(lvl)

            self.log(f"Skill upgrade validation: skill={skill_code}, level={level}, reborns={reborn_times}, total_pts={total_skill_points}, used_pts={used_skill_points}")
            
            if used_skill_points < total_skill_points:
                # Update player learned skills dict
                new_level = current_level + 1
                skills[skill_code] = new_level
                
                # Persist the learned skill in DB
                db = self.get_db()
                if db:
                    db.save_role_skill(self.role_name, skill_code, new_level)
                
                # Send PlayerLearnedSkillNotify (cmd 659)
                notify = PacketBuilder()
                notify.write_byte(skill_kind)
                notify.write_string(skill_code)
                notify.write_byte(new_level)
                self.send_packet(notify.build(659))
                
                # Send updated learned skills list (cmd 658) to update client state
                self.session._send_learned_skills()
                
                # Recalculate attributes if needed
                self.session._send_player_attributes()
                self.log(f"Skill {skill_code} learned successfully! Level: {new_level}, Total points: {total_skill_points}, Used: {used_skill_points + 1}")
            else:
                self.log(f"Rejected skill upgrade: insufficient skill points. {used_skill_points}/{total_skill_points}")
                
        except Exception as e:
            self.log(f"Error handling learn skill: {e}")
