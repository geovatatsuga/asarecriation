package com.sunweb.game.rpg.worldZone.command.petDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetDepotAddRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public function PetDepotAddRequest()
      {
         super(CommandCodePlayerPetDepot.PETDEPOT_ADD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string"];
      }
   }
}

