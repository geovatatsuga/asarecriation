package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetEnhanceAnswer extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var petCode:String;
      
      public var enhanceLevel:int;
      
      public var isSucceeded:Boolean;
      
      public function PetEnhanceAnswer()
      {
         super(CommandCodePlayerPet.PET_ENHANCE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","petCode:string","enhanceLevel:byte","isSucceeded:boolean"];
      }
   }
}

