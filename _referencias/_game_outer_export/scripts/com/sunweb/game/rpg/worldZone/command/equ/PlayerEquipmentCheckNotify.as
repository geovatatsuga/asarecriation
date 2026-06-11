package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEquipmentCheckNotify extends obf_O_8_1034
   {
      
      public var changedEquipments:Array;
      
      public function PlayerEquipmentCheckNotify()
      {
         super(CommandCodePlayerEquip.PLAYER_EQUIPMENT_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["changedEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)"];
      }
   }
}

