package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerPetActionModeChangeNotify extends obf_O_8_1034
   {
      
      public var petActionMode:int;
      
      public function PlayerPetActionModeChangeNotify()
      {
         super(CommandCodePlayerPet.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["petActionMode:byte"];
      }
   }
}

