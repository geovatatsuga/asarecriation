package com.sunweb.game.rpg.playerDevil
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
   import com.sunweb.game.rpg.worldZone.command.playerDevil.CommandCodePlayerDevil;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerDevilExpCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerDevilItemCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerDevilUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerDevilUpgradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerDevilUpgradeRequest;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerSetUsingDevilRequest;
   import com.sunweb.game.rpg.worldZone.command.playerDevil.PlayerUsingDevilCheckNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_4_6_372
   {
      
      public function obf_0_4_6_372()
      {
         super();
      }
      
      public static function getDevilBaseApt(param1:String) : Object
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
      
      public static function getDevilFinalApt(param1:ItemPlayerDevilInfo, param2:String) : Object
      {
         var _loc3_:Object = getDevilBaseApt(param2);
         var _loc4_:int = getDevilLevelAptAdded(param1.level);
         _loc3_.physicsAttack += param1.physicsAttackAptAdded + _loc4_;
         _loc3_.physicsDef += param1.physicsDefenseAptAdded + _loc4_;
         _loc3_.magicAttack += param1.magicAttackAptAdded + _loc4_;
         _loc3_.magicDef += param1.magicDefenseAptAdded + _loc4_;
         _loc3_.life += param1.lifeAptAdded + _loc4_;
         _loc3_.cure += param1.cureAptAdded + _loc4_;
         return _loc3_;
      }
      
      public static function getDevilAptBuffRate(param1:int) : Number
      {
         return Number(param1 / 1000);
      }
      
      public static function getDevilLevelAptAdded(param1:int) : int
      {
         return param1 * WorldConfig.getValue("devilConfig","addAptPoint");
      }
      
      public static function getDevilLevelUpExp(param1:int) : int
      {
         return WorldConfig.getValue("devilConfig","devilLevelArray",param1 - 1,"levelUpExp");
      }
      
      public static function getDevilLevelUpSp(param1:int) : int
      {
         return WorldConfig.getValue("devilConfig","devilLevelArray",param1 - 1,"levelUpSp");
      }
      
      public static function itemFullInfoToDevilFullInfo(param1:GameItemFullInfo) : DevilFullInfo
      {
         var _loc5_:String = null;
         var _loc2_:DevilFullInfo = new DevilFullInfo();
         var _loc3_:String = com.adobe.serialization.json.JSON.encode(param1.devilInfo);
         var _loc4_:Object = com.adobe.serialization.json.JSON.decode(_loc3_);
         if(!_loc4_)
         {
            return null;
         }
         for(_loc5_ in _loc4_)
         {
            _loc2_[_loc5_] = _loc4_[_loc5_];
         }
         _loc2_.devilCode = param1.itemCode;
         _loc2_.devilId = param1.itemId;
         return _loc2_;
      }
      
      public static function sendPlayerSetUsingDevilReq(param1:String) : void
      {
         var _loc2_:PlayerSetUsingDevilRequest = new PlayerSetUsingDevilRequest();
         _loc2_.devilId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerDevilUpLevelReq(param1:String) : void
      {
         var _loc2_:PlayerDevilUpLevelRequest = new PlayerDevilUpLevelRequest();
         _loc2_.devilId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerDevilUpgradeReq(param1:String) : void
      {
         var _loc2_:PlayerDevilUpgradeRequest = new PlayerDevilUpgradeRequest();
         _loc2_.devilId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerDevil.PLAYER_DEVIL_EXP_CHECK_NOTIFY)
         {
            obf_u_c_1318(param1 as PlayerDevilExpCheckNotify);
         }
         else if(param1.code == CommandCodePlayerDevil.PLAYER_DEVIL_ITEM_CHECK_NOTIFY)
         {
            obf_u_S_2492(param1 as PlayerDevilItemCheckNotify);
         }
         else if(param1.code == CommandCodePlayerDevil.PLAYER_DEVIL_UPGRADE_ANSWER)
         {
            obf_w_J_2761(param1 as PlayerDevilUpgradeAnswer);
         }
         else if(param1.code == CommandCodePlayerDevil.PLAYER_USING_DEVIL_CHECK_NOTIFY)
         {
            obf_7_s_3607(param1 as PlayerUsingDevilCheckNotify);
         }
      }
      
      private static function obf_u_c_1318(param1:PlayerDevilExpCheckNotify) : void
      {
         if(Boolean(obf_K_e_3075.playerDevilUI.obf_X_h_2915) && obf_K_e_3075.playerDevilUI.obf_X_h_2915.devilId == param1.devilId)
         {
            obf_K_e_3075.playerDevilUI.obf_X_h_2915.exp = param1.exp;
            obf_K_e_3075.playerDevilUI.obf_4_i_3109();
         }
         if(param1.addExp > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("GenieBoxUI","prompt_GenieAddExp",[param1.addExp]));
         }
      }
      
      private static function obf_u_S_2492(param1:PlayerDevilItemCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(Boolean(obf_K_e_3075.playerDevilUI.obf_X_h_2915) && obf_K_e_3075.playerDevilUI.obf_X_h_2915.devilId == param1.devil.devilId)
         {
            obf_K_e_3075.playerDevilUI.showDevilInfo(param1.devil);
         }
      }
      
      private static function obf_w_J_2761(param1:PlayerDevilUpgradeAnswer) : void
      {
         if(Boolean(obf_K_e_3075.playerDevilUI.obf_X_h_2915) && obf_K_e_3075.playerDevilUI.obf_X_h_2915.devilId == param1.devilId)
         {
            obf_K_e_3075.playerDevilUI.obf_X_h_2915.upgradeRate = param1.upgradeRate;
            obf_K_e_3075.playerDevilUI.obf_d_4_1516();
         }
      }
      
      private static function obf_7_s_3607(param1:PlayerUsingDevilCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         GameContext.localPlayer.devilFullInfo = param1.usingDevil;
         if(param1.usingDevil)
         {
            GameContext.localPlayer.setDevil(param1.usingDevil.devilCode,param1.usingDevil.devilId);
         }
         else
         {
            GameContext.localPlayer.removeDevil();
         }
      }
   }
}

