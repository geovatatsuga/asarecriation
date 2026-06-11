package com.sunweb.game.rpg.petDepot
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.petDepot.CommandCodePlayerPetDepot;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotAddRequest;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotItemsNotify;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotRemoveRequest;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotUpLevelRequest;
   
   public class obf_0_1_a_376
   {
      
      public function obf_0_1_a_376()
      {
         super();
      }
      
      public static function getPetDepotConfig() : Object
      {
         return WorldConfig.getValue("petDepot");
      }
      
      public static function sendPetDepotUpLevelRequest() : void
      {
         var _loc1_:PetDepotUpLevelRequest = new PetDepotUpLevelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPetDepotAddRequest(param1:String) : void
      {
         var _loc2_:PetDepotAddRequest = new PetDepotAddRequest();
         _loc2_.itemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPetDepotRemoveRequest(param1:int, param2:String) : void
      {
         var _loc3_:PetDepotRemoveRequest = new PetDepotRemoveRequest();
         _loc3_.index = param1;
         _loc3_.itemId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerPetDepot.PETDEPOT_ITEMS_NOYIFY)
         {
            obf_K_e_3075.petDepotUI.onBagCheck((param1 as PetDepotItemsNotify).items);
            obf_K_e_3075.petDepotUI.obf_R_2_4129((param1 as PetDepotItemsNotify).attrs);
         }
         else if(param1.code == CommandCodePlayerPetDepot.PETDEPOT_UPLEVEL_ANSWER)
         {
            obf_K_e_3075.petDepotUI.obf_J_5_1993((param1 as PetDepotUpLevelAnswer).currentCount);
            obf_K_e_3075.petDepotUI.obf_k_T_4034(param1 as PetDepotUpLevelAnswer);
         }
      }
   }
}

