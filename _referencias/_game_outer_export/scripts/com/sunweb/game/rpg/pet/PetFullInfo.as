package com.sunweb.game.rpg.pet
{
   public class PetFullInfo extends ItemPlayerPetInfo
   {
      
      public var petId:String;
      
      public var petCode:String;
      
      public function PetFullInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","petCode:string"].concat(super.getFieldList());
      }
   }
}

