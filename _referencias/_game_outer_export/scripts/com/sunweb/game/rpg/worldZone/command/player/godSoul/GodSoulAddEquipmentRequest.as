package com.sunweb.game.rpg.worldZone.command.player.godSoul
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodSoulAddEquipmentRequest extends obf_O_8_1034
   {
      
      public var itemIndex:int;
      
      public var soulType:int;
      
      public function GodSoulAddEquipmentRequest()
      {
         super(CommandPlayerGodSoul.GOD_SOUL_ADD_EQUIPMENT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemIndex:ubyte","soulType:ubyte"];
      }
   }
}

