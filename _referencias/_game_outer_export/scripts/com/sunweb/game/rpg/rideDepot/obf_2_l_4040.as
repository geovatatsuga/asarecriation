package com.sunweb.game.rpg.rideDepot
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.CommandCodePlayerRideDepot;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.RideDepotAddRequest;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.RideDepotItemsNotify;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.RideDepotRemoveRequest;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.RideDepotUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.rideDepot.RideDepotUpLevelRequest;
   
   public class obf_2_l_4040
   {
      
      public function obf_2_l_4040()
      {
         super();
      }
      
      public static function getRideDepotConfig() : Object
      {
         return WorldConfig.getValue("rideDepot");
      }
      
      public static function sendRideDepotUpLevelRequest() : void
      {
         var _loc1_:RideDepotUpLevelRequest = new RideDepotUpLevelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendRideDepotAddRequest(param1:String) : void
      {
         var _loc2_:RideDepotAddRequest = new RideDepotAddRequest();
         _loc2_.itemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendRideDepotRemoveRequest(param1:int, param2:String) : void
      {
         var _loc3_:RideDepotRemoveRequest = new RideDepotRemoveRequest();
         _loc3_.index = param1;
         _loc3_.itemId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerRideDepot.RIDEDEPOT_ITEMS_NOYIFY)
         {
            obf_K_e_3075.rideDepotUI.onBagCheck((param1 as RideDepotItemsNotify).items);
            obf_K_e_3075.rideDepotUI.obf_R_2_4129((param1 as RideDepotItemsNotify).attrs);
         }
         else if(param1.code == CommandCodePlayerRideDepot.RIDEDEPOT_UPLEVEL_ANSWER)
         {
            obf_K_e_3075.rideDepotUI.obf_J_5_1993((param1 as RideDepotUpLevelAnswer).currentCount);
            obf_K_e_3075.rideDepotUI.obf_k_T_4034(param1 as RideDepotUpLevelAnswer);
         }
      }
   }
}

