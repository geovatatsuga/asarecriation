package obf_0_2_o_501
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarChangeAnswer;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarChangeRequest;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarKillMonsterNotify;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.BloodyWarUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.bloodyWar.CommandCodeBloodyWar;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_g_4_2381
   {
      
      public static var _bloodyWarConfig:Object;
      
      public function obf_g_4_2381()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _bloodyWarConfig = new Object();
         _bloodyWarConfig = param1;
      }
      
      public static function get openCondition() : Object
      {
         return JSONUtil.getObject(_bloodyWarConfig,["openCondition"]);
      }
      
      public static function get attackList() : Array
      {
         return JSONUtil.getValue(_bloodyWarConfig,["attackList"]) as Array;
      }
      
      public static function get changeAttack() : Array
      {
         return JSONUtil.getValue(_bloodyWarConfig,["changeAttack"]) as Array;
      }
      
      public static function get defenseList() : Array
      {
         return JSONUtil.getValue(_bloodyWarConfig,["defenseList"]) as Array;
      }
      
      public static function get changeDefense() : Array
      {
         return JSONUtil.getValue(_bloodyWarConfig,["changeDefense"]) as Array;
      }
      
      public static function get upItemCode() : String
      {
         return JSONUtil.getStr(_bloodyWarConfig,["upItemCode"]);
      }
      
      public static function get itemCode() : String
      {
         return JSONUtil.getStr(_bloodyWarConfig,["itemCode"]);
      }
      
      public static function get tempMax() : int
      {
         return JSONUtil.getInt(_bloodyWarConfig,["tempMax"]);
      }
      
      public static function get baseMax() : int
      {
         return JSONUtil.getInt(_bloodyWarConfig,["baseMax"]);
      }
      
      public static function sendChange(param1:int, param2:int) : void
      {
         var _loc3_:BloodyWarChangeRequest = new BloodyWarChangeRequest();
         _loc3_.type = param1;
         _loc3_.value = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendUpLevel(param1:int) : void
      {
         var _loc2_:BloodyWarUpLevelRequest = new BloodyWarUpLevelRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeBloodyWar.BLOODY_WAR_INFO_NOTIFY)
         {
            obf_6_9_1221(param1 as BloodyWarInfoNotify);
         }
         else if(param1.code == CommandCodeBloodyWar.BLOODY_WAR_KILL_MONSTER_NOTIFY)
         {
            obf_0_t_2667(param1 as BloodyWarKillMonsterNotify);
         }
         else if(param1.code == CommandCodeBloodyWar.BLOODY_WAR_UP_LEVEL_ANSWER)
         {
            obf_8_c_1356(param1 as BloodyWarUpLevelAnswer);
         }
         else if(param1.code == CommandCodeBloodyWar.BLOODY_WAR_CHANGE_ANSWER)
         {
            obf_3_x_1782(param1 as BloodyWarChangeAnswer);
         }
      }
      
      public static function obf_6_9_1221(param1:BloodyWarInfoNotify) : void
      {
         obf_K_e_3075.bloodyWarUI.attackLevel = param1.attackLevel;
         obf_K_e_3075.bloodyWarUI.attackExp = param1.attackExp;
         obf_K_e_3075.bloodyWarUI.defenseLevel = param1.defenseLevel;
         obf_K_e_3075.bloodyWarUI.defenseExp = param1.defenseExp;
         obf_K_e_3075.bloodyWarUI.attack = param1.attack;
         obf_K_e_3075.bloodyWarUI.defense = param1.defense;
         obf_K_e_3075.bloodyWarUI.attackTemp = param1.attackTemp;
         obf_K_e_3075.bloodyWarUI.defenseTemp = param1.defenseTemp;
         obf_K_e_3075.bloodyWarUI.refresh();
      }
      
      public static function obf_0_t_2667(param1:BloodyWarKillMonsterNotify) : void
      {
         obf_K_e_3075.bloodyWarUI.attackTemp = param1.attackTemp;
         obf_K_e_3075.bloodyWarUI.defenseTemp = param1.defenseTemp;
         obf_K_e_3075.bloodyWarUI.refreshTemp();
      }
      
      public static function obf_8_c_1356(param1:BloodyWarUpLevelAnswer) : void
      {
         obf_K_e_3075.bloodyWarUI.attackLevel = param1.attackLevel;
         obf_K_e_3075.bloodyWarUI.attackExp = param1.attackExp;
         obf_K_e_3075.bloodyWarUI.defenseLevel = param1.defenseLevel;
         obf_K_e_3075.bloodyWarUI.defenseExp = param1.defenseExp;
         obf_K_e_3075.bloodyWarUI.refresh();
      }
      
      public static function obf_3_x_1782(param1:BloodyWarChangeAnswer) : void
      {
         obf_K_e_3075.bloodyWarUI.attackTemp = param1.attackTemp;
         obf_K_e_3075.bloodyWarUI.defenseTemp = param1.defenseTemp;
         obf_K_e_3075.bloodyWarUI.attack = param1.attack;
         obf_K_e_3075.bloodyWarUI.defense = param1.defense;
         obf_K_e_3075.bloodyWarUI.refresh();
      }
   }
}

