package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetRemoveEquipmentRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var equipmentKind:int;
      
      public var toBagItemIndex:int;
      
      public function PetRemoveEquipmentRequest()
      {
         super(CommandCodePlayerPet.PET_REMOVE_EQUIPMENT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","equipmentKind:ushort","toBagItemIndex:byte"];
      }
   }
}

