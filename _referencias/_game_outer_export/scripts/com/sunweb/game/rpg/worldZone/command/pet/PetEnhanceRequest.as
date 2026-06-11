package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetEnhanceRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var currentEnhanceLevel:int;
      
      public function PetEnhanceRequest()
      {
         super(CommandCodePlayerPet.PET_ENHANCE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","currentEnhanceLevel:byte"];
      }
   }
}

