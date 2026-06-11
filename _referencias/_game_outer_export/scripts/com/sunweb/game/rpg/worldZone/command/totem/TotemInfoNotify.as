package com.sunweb.game.rpg.worldZone.command.totem
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TotemInfoNotify extends obf_O_8_1034
   {
      
      public var infoMap:Object;
      
      public function TotemInfoNotify()
      {
         super(CommandCodePlayerTotem.TOTEM_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["infoMap:map(ubyte,com.sunweb.game.rpg.totem.TotemInfo)"];
      }
   }
}

