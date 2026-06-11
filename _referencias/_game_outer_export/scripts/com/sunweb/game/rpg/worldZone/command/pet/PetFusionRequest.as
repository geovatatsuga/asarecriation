package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetFusionRequest extends obf_O_8_1034
   {
      
      public var manPetId:String;
      
      public var womanPetId:String;
      
      public var fusionItems:Object;
      
      public var protectItem:String;
      
      public function PetFusionRequest()
      {
         super(CommandCodePlayerPet.PET_FUSION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["manPetId:string","womanPetId:string","fusionItems:map(string,short)","protectItem:string"];
      }
   }
}

