package com.sunweb.game.rpg.dragon
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.dragon.CommandCodeDragon;
   import com.sunweb.game.rpg.worldZone.command.dragon.DragonBuyUpChanceNumAnswer;
   import com.sunweb.game.rpg.worldZone.command.dragon.DragonBuyUpChanceNumRequest;
   import com.sunweb.game.rpg.worldZone.command.dragon.DragonCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.dragon.DragonUpgradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.dragon.DragonUpgrageRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Y_1494
   {
      
      private static var dragonConfig:Object;
      
      public static var agoLv:int = 0;
      
      public function obf_Y_1494()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         dragonConfig = param1;
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(dragonConfig,rest);
      }
      
      public static function get obf_E_x_3442() : Boolean
      {
         return JSONUtil.getBoolean(dragonConfig,["isNeedItem"]);
      }
      
      public static function get oneItem() : Object
      {
         return getConfigValue("oneMulItem") as Object;
      }
      
      public static function get tenItem() : Object
      {
         return getConfigValue("tenMulItem") as Object;
      }
      
      public static function getDragonUpgrade() : Object
      {
         return getConfigValue("dragonLevels");
      }
      
      public static function getDragonSkills() : Object
      {
         return getConfigValue("dragonSkills");
      }
      
      public static function getDragonMony() : int
      {
         return getConfigValue("upMoney");
      }
      
      public static function getDragonChanceMoney() : int
      {
         return getConfigValue("upChanceMoney");
      }
      
      public static function getDragonChanceNum() : int
      {
         return getConfigValue("upChanceNum");
      }
      
      public static function getDragonChanceNumUpper() : int
      {
         return getConfigValue("upChanceNumUpper");
      }
      
      public static function get obf_U_n_2740() : int
      {
         if(GameContext.localPlayer)
         {
            return GameContext.localPlayer.fullInfo.dragonLevel;
         }
         return 0;
      }
      
      public static function get obf_0_6_N_262() : int
      {
         if(GameContext.localPlayer)
         {
            return GameContext.localPlayer.fullInfo.dragonExp;
         }
         return 0;
      }
      
      public static function get obf_X_R_4274() : int
      {
         if(GameContext.localPlayer)
         {
            return GameContext.localPlayer.fullInfo.dragonUpChanceNum;
         }
         return 0;
      }
      
      private static function get dragonObject() : Object
      {
         var _loc1_:Array = getDragonUpgrade() as Array;
         if(!_loc1_)
         {
            return null;
         }
         return _loc1_[obf_U_n_2740 - 1];
      }
      
      public static function dragonName(param1:int) : String
      {
         var _loc2_:Array = getDragonUpgrade() as Array;
         if(!_loc2_)
         {
            return "";
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return "";
         }
         return _loc3_.dragonName;
      }
      
      public static function get dragonMaxExp() : int
      {
         if(!dragonObject)
         {
            return 0;
         }
         return dragonObject.upLevelExp;
      }
      
      public static function get dragonSkills() : Array
      {
         if(!dragonObject)
         {
            return [];
         }
         var _loc1_:Array = dragonObject.skills as Array;
         if(!_loc1_)
         {
            return [];
         }
         return _loc1_;
      }
      
      public static function get dragonCondition() : Object
      {
         if(!dragonObject)
         {
            return null;
         }
         var _loc1_:Object = dragonObject.upCondition;
         if(!_loc1_)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function get obf_I_f_2441() : Object
      {
         if(!dragonObject)
         {
            return 0;
         }
         return dragonObject.addAttr;
      }
      
      public static function get obf_V_E_3715() : Number
      {
         return getConfigValue("forceChance");
      }
      
      public static function get obf_2_U_1276() : Number
      {
         return getConfigValue("luckChance");
      }
      
      public static function get obf_8_f_2451() : Number
      {
         return getConfigValue("upForceChance");
      }
      
      public static function get obf_F_I_2544() : Number
      {
         return getConfigValue("upLuckChance");
      }
      
      public static function obf_x_b_4157(param1:int) : String
      {
         var _loc2_:Array = getDragonUpgrade() as Array;
         if(!_loc2_)
         {
            return "";
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return "";
         }
         return _loc3_.modelCode;
      }
      
      public static function sendDragonUpgradeExp(param1:int = 1) : void
      {
         var _loc2_:DragonUpgrageRequest = new DragonUpgrageRequest();
         _loc2_.multiple = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendDragonBuyUp(param1:int) : void
      {
         var _loc2_:DragonBuyUpChanceNumRequest = new DragonBuyUpChanceNumRequest();
         _loc2_.nowNum = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         var _loc2_:DragonUpgradeAnswer = null;
         var _loc3_:DragonCheckNotify = null;
         var _loc4_:DragonBuyUpChanceNumAnswer = null;
         if(param1.code == CommandCodeDragon.PLAYER_DRAGON_UPGRADE_ANSWER)
         {
            _loc2_ = param1 as DragonUpgradeAnswer;
            GameContext.localPlayer.fullInfo.dragonExp = _loc2_.dragonExp;
            GameContext.localPlayer.fullInfo.dragonLevel = _loc2_.dragonLevel;
            GameContext.localPlayer.fullInfo.dragonUpChanceNum = _loc2_.dragonUpChanceNum;
            obf_K_e_3075.dragonBoxUI.showEfect(_loc2_.resultType,_loc2_.addExp);
            obf_K_e_3075.dragonBoxUI.expChange(_loc2_.dragonExp,dragonMaxExp);
            obf_K_e_3075.dragonBoxUI.upDataDragonBase(obf_I_f_2441);
            obf_K_e_3075.dragonBoxUI.upDataProbability();
            if(agoLv != _loc2_.dragonLevel && obf_x_b_4157(agoLv) != obf_x_b_4157(_loc2_.dragonLevel))
            {
               GameContext.localPlayer.obf_8_1_2164();
            }
            agoLv = _loc2_.dragonLevel;
         }
         else if(param1.code == CommandCodeDragon.PLAYER_DRAGON_CHECK_NOTIFY)
         {
            _loc3_ = param1 as DragonCheckNotify;
            GameContext.localPlayer.fullInfo.dragonExp = _loc3_.dragonExp;
            GameContext.localPlayer.fullInfo.dragonLevel = _loc3_.dragonLevel;
            obf_K_e_3075.dragonBoxUI.upDataDragonBase(obf_I_f_2441);
            obf_K_e_3075.dragonBoxUI.expChange(_loc3_.dragonExp,dragonMaxExp);
            obf_K_e_3075.dragonBoxUI.upDataProbability();
            GameContext.localPlayer.obf_8_1_2164();
            agoLv = _loc3_.dragonLevel;
         }
         else if(param1.code == CommandCodeDragon.PLAYER_BUY_UP_CHANCE_ANSWER)
         {
            _loc4_ = param1 as DragonBuyUpChanceNumAnswer;
            GameContext.localPlayer.fullInfo.dragonUpChanceNum = _loc4_.dragonUpChanceNum;
            obf_K_e_3075.dragonBoxUI.upDataProbability();
         }
      }
   }
}

