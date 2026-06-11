package obf_0_7_V_532
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.GenieMagic.CommandCodePlayerGenieMagic;
   import com.sunweb.game.rpg.worldZone.command.GenieMagic.SkillLevelNotify;
   import com.sunweb.game.rpg.worldZone.command.GenieMagic.SkillUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.GenieMagic.SkillUseNotify;
   import com.sunweb.game.rpg.worldZone.command.GenieMagic.SkillUseRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_N_o_3647
   {
      
      public static var genieMagicConfig:Object;
      
      public static var usedSkill:Object;
      
      private static var obf_p_i_2477:Object;
      
      public static const obf_k_r_3706:int = 1;
      
      public static const obf_0_5_C_356:int = 2;
      
      public static const obf_n_i_3999:int = 3;
      
      private static var obf_H_0_859:Object = new Object();
      
      private static var obf_0_3_4052:int = 0;
      
      public function obf_N_o_3647()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         genieMagicConfig = param1;
      }
      
      public static function getGenieMagicBloodConfig() : Object
      {
         return JSONUtil.getValue(genieMagicConfig,["bloodConfig"]);
      }
      
      public static function getGenieMagicTalentConfig() : Object
      {
         return JSONUtil.getValue(genieMagicConfig,["talentConfig"]);
      }
      
      public static function getGenieMagicElementConfig() : Object
      {
         return JSONUtil.getValue(genieMagicConfig,["magicConfig"]);
      }
      
      public static function sendGenieMagicBloodUpSkill(param1:int, param2:int = 1) : void
      {
         var _loc3_:SkillUpLevelRequest = new SkillUpLevelRequest();
         _loc3_.type = param2;
         _loc3_.attrEnum = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendGenieMagictalentUpSkill(param1:int) : void
      {
         var _loc2_:SkillUpLevelRequest = new SkillUpLevelRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendGenieMagicUpSkill(param1:int, param2:String) : void
      {
         var _loc3_:SkillUpLevelRequest = new SkillUpLevelRequest();
         _loc3_.type = param1;
         _loc3_.skillId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendGenieMagicUseSkill(param1:String) : void
      {
         var _loc2_:SkillUseRequest = new SkillUseRequest();
         _loc2_.skillId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerGenieMagic.SKILL_USE_NOTIFY)
         {
            obf_F_u_3591(param1 as SkillUseNotify);
         }
         else if(param1.code == CommandCodePlayerGenieMagic.SKILL_LEVEL_NOTIFY)
         {
            obf_Y_g_3029(param1 as SkillLevelNotify);
         }
      }
      
      private static function obf_F_u_3591(param1:SkillUseNotify) : void
      {
         usedSkill = param1.usedSkill;
         obf_K_e_3075.genieMagicSkillUI.showUsedSkillItems(param1.usedSkill);
         obf_K_e_3075.genieMagicSkillUI.showDigItems(param1.items);
      }
      
      public static function get obf_v_4680() : Object
      {
         return obf_H_0_859;
      }
      
      public static function get talentLevel() : int
      {
         return obf_0_3_4052;
      }
      
      public static function get magicSkills() : Object
      {
         return obf_p_i_2477;
      }
      
      private static function obf_Y_g_3029(param1:SkillLevelNotify) : void
      {
         obf_H_0_859 = param1.bloodSkills;
         obf_0_3_4052 = param1.talentLevel;
         obf_p_i_2477 = param1.magicSkills;
         obf_K_e_3075.genieMagicBloodUI.obf_v_E_1606(param1.bloodSkills);
         obf_K_e_3075.genieMagicSkillUI.obf_j_j_1064(param1.magicSkills);
         obf_K_e_3075.genieMagicSkillUI.showGenieMagicRideSum(param1.magicSkills);
         obf_K_e_3075.genieMagicSkillUI.showGenieMagicBless(param1.magicSkills);
         obf_K_e_3075.genieMagicSkillUI.showGenieMagicGhost(param1.magicSkills);
         obf_K_e_3075.genieMagicSkillUI.showGenieMagicDig(param1.magicSkills);
      }
   }
}

