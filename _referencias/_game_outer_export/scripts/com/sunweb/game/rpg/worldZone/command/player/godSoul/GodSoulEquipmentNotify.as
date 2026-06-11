package com.sunweb.game.rpg.worldZone.command.player.godSoul
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodSoulEquipmentNotify extends obf_O_8_1034
   {
      
      public var changedSkySoulEquipments:Array;
      
      public var changedTerraSoulEquipments:Array;
      
      public var changedDeitySoulEquipments:Array;
      
      public var changedAncientSoulEquipments:Array;
      
      public var changedChaosSoulEquipments:Array;
      
      public var changedFirstSoulEquipments:Array;
      
      public var soulType:int;
      
      public function GodSoulEquipmentNotify()
      {
         super(CommandPlayerGodSoul.GOD_SOUL_EQUIPMENT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["changedSkySoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","changedTerraSoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","changedDeitySoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","changedAncientSoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","changedChaosSoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","changedFirstSoulEquipments:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","soulType:ubyte"];
      }
   }
}

