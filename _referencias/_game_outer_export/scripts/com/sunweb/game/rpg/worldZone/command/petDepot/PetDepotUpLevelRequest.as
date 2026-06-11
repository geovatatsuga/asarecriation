package com.sunweb.game.rpg.worldZone.command.petDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetDepotUpLevelRequest extends obf_O_8_1034
   {
      
      public function PetDepotUpLevelRequest()
      {
         super(CommandCodePlayerPetDepot.PETDEPOT_UPLEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

