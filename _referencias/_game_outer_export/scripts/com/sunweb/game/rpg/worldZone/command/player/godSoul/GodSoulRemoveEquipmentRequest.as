package com.sunweb.game.rpg.worldZone.command.player.godSoul
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodSoulRemoveEquipmentRequest extends obf_O_8_1034
   {
      
      public var equipmentKind:int;
      
      public var toBagItemIndex:int;
      
      public var soulType:int;
      
      public function GodSoulRemoveEquipmentRequest()
      {
         super(CommandPlayerGodSoul.GOD_SOUL_REMOVE_EQUIPMENT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentKind:byte","toBagItemIndex:byte","soulType:ubyte"];
      }
   }
}

