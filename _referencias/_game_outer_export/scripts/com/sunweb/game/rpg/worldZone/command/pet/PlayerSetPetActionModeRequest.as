package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetPetActionModeRequest extends obf_O_8_1034
   {
      
      public var petActionMode:int;
      
      public function PlayerSetPetActionModeRequest()
      {
         super(CommandCodePlayerPet.PLAYER_SET_PET_ACTION_MODE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petActionMode:byte"];
      }
   }
}

