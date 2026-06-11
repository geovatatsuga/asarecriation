package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetFusionAnswer extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var petCode:String;
      
      public var generation:int;
      
      public var isSucceeded:Boolean;
      
      public function PetFusionAnswer()
      {
         super(CommandCodePlayerPet.PET_FUSION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","petCode:string","generation:byte","isSucceeded:boolean"];
      }
   }
}

