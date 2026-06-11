package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.petDepot.CommandCodePlayerPetDepot;
   
   public class PetDepotEventType
   {
      
      public static const PETDEPOT_UPLEVEL_ANSWER:String = CommandCodePlayerPetDepot.PETDEPOT_UPLEVEL_ANSWER.toString(16);
      
      public static const PETDEPOT_ITEMS_NOYIFY:String = CommandCodePlayerPetDepot.PETDEPOT_ITEMS_NOYIFY.toString(16);
      
      public function PetDepotEventType()
      {
         super();
      }
   }
}

