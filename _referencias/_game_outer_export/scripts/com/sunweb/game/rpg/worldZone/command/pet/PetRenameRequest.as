package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetRenameRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var petName:String;
      
      public function PetRenameRequest()
      {
         super(CommandCodePlayerPet.PET_RENAME_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","petName:string"];
      }
   }
}

