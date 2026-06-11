package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRemoveEquipmentRequest extends obf_O_8_1034
   {
      
      public var equipmentKind:int;
      
      public var toBagItemIndex:int;
      
      public function PlayerRemoveEquipmentRequest()
      {
         super(CommandCodePlayerEquip.PLAYER_REMOVE_EQUIPMENT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentKind:byte","toBagItemIndex:byte"];
      }
   }
}

