package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetViewRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public function PetViewRequest()
      {
         super(CommandCodePlayerPet.PET_VIEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string"];
      }
   }
}

