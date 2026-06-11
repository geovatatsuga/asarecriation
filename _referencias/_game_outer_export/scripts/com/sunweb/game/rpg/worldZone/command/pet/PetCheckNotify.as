package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   
   public class PetCheckNotify extends obf_O_8_1034
   {
      
      public var isUsing:Boolean;
      
      public var pet:PetFullInfo;
      
      public function PetCheckNotify()
      {
         super(CommandCodePlayerPet.PET_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isUsing:boolean","pet:com.sunweb.game.rpg.pet.PetFullInfo"];
      }
   }
}

