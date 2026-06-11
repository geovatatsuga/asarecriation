package com.sunweb.game.rpg.treasury
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.treasury.CommandCodeTreasury;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryAttrNotify;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryExpNotify;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryLevelNotify;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryUseItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.treasury.TreasuryUseItemRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_M_a_3122
   {
      
      private static var treasuryConfig:Object;
      
      public function obf_M_a_3122()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         treasuryConfig = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(treasuryConfig,["openCondition"]);
      }
      
      public static function get depot1() : Object
      {
         return JSONUtil.getObject(treasuryConfig,["depot1"]);
      }
      
      public static function get depot2() : Object
      {
         return JSONUtil.getObject(treasuryConfig,["depot2"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeTreasury.TREASURY_INFO_NOTIFY)
         {
            obf_e_K_1303(param1 as TreasuryInfoNotify);
         }
         else if(param1.code == CommandCodeTreasury.TREASURY_ATTR_NOTIFY)
         {
            obf_l_j_1515(param1 as TreasuryAttrNotify);
         }
         else if(param1.code == CommandCodeTreasury.TREASURY_LEVEL_NOTIFY)
         {
            obf_0___B_400(param1 as TreasuryLevelNotify);
         }
         else if(param1.code == CommandCodeTreasury.TREASURY_EXP_NOTIFY)
         {
            obf_J_4698(param1 as TreasuryExpNotify);
         }
         else if(param1.code == CommandCodeTreasury.TREASURY_USE_ITEM_ANSWER)
         {
            obf_2_j_2308(param1 as TreasuryUseItemAnswer);
         }
      }
      
      private static function obf_e_K_1303(param1:TreasuryInfoNotify) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.depot1)
         {
            obf_K_e_3075.obf_0___I_542.setInfo(param1.depot1);
         }
         if(param1.depot2)
         {
            obf_K_e_3075.obf_0___I_542.setInfo(param1.depot2);
         }
         obf_K_e_3075.obf_0___I_542.obf_0_4_8_274(1);
      }
      
      private static function obf_l_j_1515(param1:TreasuryAttrNotify) : void
      {
         if(!param1)
         {
            return;
         }
         obf_K_e_3075.obf_0___I_542.obf_x_j_3753(param1.attrMap,param1.type);
      }
      
      private static function obf_0___B_400(param1:TreasuryLevelNotify) : void
      {
         if(!param1)
         {
            return;
         }
         obf_K_e_3075.obf_0___I_542.obf_Z_5_3720(param1.level,param1.type);
      }
      
      private static function obf_J_4698(param1:TreasuryExpNotify) : void
      {
         if(!param1)
         {
            return;
         }
         obf_K_e_3075.obf_0___I_542.obf_X_X_1656(param1.exp,param1.type);
      }
      
      private static function obf_2_j_2308(param1:TreasuryUseItemAnswer) : void
      {
         if(!param1)
         {
            return;
         }
         if(obf_K_e_3075.obf_0___I_542.type == param1.type)
         {
            obf_K_e_3075.obf_0___I_542.showDice(param1.diceNum,param1.index);
         }
         else
         {
            obf_K_e_3075.obf_0___I_542.refreshPlayerIndex(param1.index,param1.type);
         }
      }
      
      public static function sendTreasuryUseItemRequest(param1:int) : void
      {
         var _loc2_:TreasuryUseItemRequest = new TreasuryUseItemRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
   }
}

