package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetDecomposeRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public function PetDecomposeRequest()
      {
         super(CommandCodePlayerPet.PET_DECOMPOSE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string"];
      }
   }
}

