package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetAnimalActionModeRequest extends obf_O_8_1034
   {
      
      public var animalActionMode:int;
      
      public function PlayerSetAnimalActionModeRequest()
      {
         super(CommandCodePlayerAnimal.ANIMAL_SET_ACTION_MODE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["animalActionMode:ubyte"];
      }
   }
}

