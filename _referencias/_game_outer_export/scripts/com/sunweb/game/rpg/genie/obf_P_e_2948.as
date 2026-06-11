package com.sunweb.game.rpg.genie
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.genie.CommandCodePlayerGenie;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerGenieExpCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerGenieItemCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerGenieUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerGenieUpgradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerGenieUpgradeRequest;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerSetUsingGenieRequest;
   import com.sunweb.game.rpg.worldZone.command.genie.PlayerUsingGenieCheckNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_P_e_2948
   {
      
      public function obf_P_e_2948()
      {
         super();
      }
      
      public static function getGenieBaseApt(param1:String) : Object
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         return {
            "physicsAttack":JSONUtil.getInt(_loc2_,["properties","physicsAttackApt"]),
            "physicsDef":JSONUtil.getInt(_loc2_,["properties","physicsDefenseApt"]),
            "magicAttack":JSONUtil.getInt(_loc2_,["properties","magicAttackApt"]),
            "magicDef":JSONUtil.getInt(_loc2_,["properties","magicDefenseApt"]),
            "life":JSONUtil.getInt(_loc2_,["properties","lifeApt"]),
            "cure":JSONUtil.getInt(_loc2_,["properties","cureApt"])
         };
      }
      
      public static function getGenieFinalApt(param1:ItemPlayerGenieInfo, param2:String) : Object
      {
         var _loc3_:Object = getGenieBaseApt(param2);
         var _loc4_:int = getGenieLevelAptAdded(param1.level);
         _loc3_.physicsAttack += param1.physicsAttackAptAdded + _loc4_;
         _loc3_.physicsDef += param1.physicsDefenseAptAdded + _loc4_;
         _loc3_.magicAttack += param1.magicAttackAptAdded + _loc4_;
         _loc3_.magicDef += param1.magicDefenseAptAdded + _loc4_;
         _loc3_.life += param1.lifeAptAdded + _loc4_;
         _loc3_.cure += param1.cureAptAdded + _loc4_;
         return _loc3_;
      }
      
      public static function getGenieAptExcludeLv(param1:ItemPlayerGenieInfo, param2:String) : Object
      {
         var _loc3_:Object = getGenieBaseApt(param2);
         _loc3_.physicsAttack += param1.physicsAttackAptAdded;
         _loc3_.physicsDef += param1.physicsDefenseAptAdded;
         _loc3_.magicAttack += param1.magicAttackAptAdded;
         _loc3_.magicDef += param1.magicDefenseAptAdded;
         _loc3_.life += param1.lifeAptAdded;
         _loc3_.cure += param1.cureAptAdded;
         return _loc3_;
      }
      
      public static function getGenieAptBuffRate(param1:int) : Number
      {
         return Number(param1 / 1000);
      }
      
      public static function getGenieLevelAptAdded(param1:int) : int
      {
         return param1 * WorldConfig.getValue("genieConfig","addAptPoint");
      }
      
      public static function getGenieLevelUpExp(param1:int) : int
      {
         return WorldConfig.getValue("genieConfig","genieLevelArray",param1 - 1,"levelUpExp");
      }
      
      public static function getGenieLevelUpSp(param1:int) : int
      {
         return WorldConfig.getValue("genieConfig","genieLevelArray",param1 - 1,"levelUpSp");
      }
      
      public static function itemFullInfoToGenieFullInfo(param1:GameItemFullInfo) : GenieFullInfo
      {
         var _loc5_:String = null;
         var _loc2_:GenieFullInfo = new GenieFullInfo();
         var _loc3_:String = com.adobe.serialization.json.JSON.encode(param1.genieInfo);
         var _loc4_:Object = com.adobe.serialization.json.JSON.decode(_loc3_);
         if(!_loc4_)
         {
            return null;
         }
         for(_loc5_ in _loc4_)
         {
            _loc2_[_loc5_] = _loc4_[_loc5_];
         }
         _loc2_.genieCode = param1.itemCode;
         _loc2_.genieId = param1.itemId;
         return _loc2_;
      }
      
      public static function sendSetUsingGenie(param1:String) : void
      {
         var _loc2_:PlayerSetUsingGenieRequest = new PlayerSetUsingGenieRequest();
         _loc2_.genieId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendGenieLevelUp(param1:String) : void
      {
         var _loc2_:PlayerGenieUpLevelRequest = new PlayerGenieUpLevelRequest();
         _loc2_.genieId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendGenieUnseal(param1:String) : void
      {
         var _loc2_:PlayerGenieUpgradeRequest = new PlayerGenieUpgradeRequest();
         _loc2_.genieId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerGenie.PLAYER_GENIE_ITEM_CHECK_NOTIFY)
         {
            obf_0___s_170(param1 as PlayerGenieItemCheckNotify);
         }
         else if(param1.code == CommandCodePlayerGenie.PLAYER_USING_GENIE_CHECK_NOTIFY)
         {
            obf_2_K_3558(param1 as PlayerUsingGenieCheckNotify);
         }
         else if(param1.code == CommandCodePlayerGenie.PLAYER_GENIE_EXP_CHECK_NOTIFY)
         {
            obf_J_L_3416(param1 as PlayerGenieExpCheckNotify);
         }
         else if(param1.code == CommandCodePlayerGenie.PLAYER_GENIE_UPGRADE_ANSWER)
         {
            obf_q_7_2835(param1 as PlayerGenieUpgradeAnswer);
         }
      }
      
      private static function obf_0___s_170(param1:PlayerGenieItemCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(Boolean(obf_K_e_3075.genieBoxUI.obf_7_e_2722) && obf_K_e_3075.genieBoxUI.obf_7_e_2722.genieId == param1.genie.genieId)
         {
            obf_K_e_3075.genieBoxUI.showGenieInfo(param1.genie);
         }
      }
      
      private static function obf_2_K_3558(param1:PlayerUsingGenieCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         GameContext.localPlayer.genieFullInfo = param1.usingGenie;
         if(param1.usingGenie)
         {
            GameContext.localPlayer.setGenie(param1.usingGenie.genieCode,param1.usingGenie.genieId);
         }
         else
         {
            GameContext.localPlayer.removeGenie();
         }
      }
      
      private static function obf_J_L_3416(param1:PlayerGenieExpCheckNotify) : void
      {
         if(Boolean(obf_K_e_3075.genieBoxUI.obf_7_e_2722) && obf_K_e_3075.genieBoxUI.obf_7_e_2722.genieId == param1.genieId)
         {
            obf_K_e_3075.genieBoxUI.obf_7_e_2722.exp = param1.exp;
            obf_K_e_3075.genieBoxUI.obf_0_8_d_92();
         }
         if(param1.addExp > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("GenieBoxUI","prompt_GenieAddExp",[param1.addExp]));
         }
      }
      
      private static function obf_q_7_2835(param1:PlayerGenieUpgradeAnswer) : void
      {
         if(Boolean(obf_K_e_3075.genieBoxUI.obf_7_e_2722) && obf_K_e_3075.genieBoxUI.obf_7_e_2722.genieId == param1.genieId)
         {
            obf_K_e_3075.genieBoxUI.obf_7_e_2722.upgradeRate = param1.upgradeRate;
            obf_K_e_3075.genieBoxUI.obf_B_F_3224();
         }
      }
   }
}

