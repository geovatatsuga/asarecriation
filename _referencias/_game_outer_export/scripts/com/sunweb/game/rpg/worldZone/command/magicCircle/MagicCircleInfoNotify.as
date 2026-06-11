package com.sunweb.game.rpg.worldZone.command.magicCircle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MagicCircleInfoNotify extends obf_O_8_1034
   {
      
      public var hasMap:Object;
      
      public var useIndex:int;
      
      public function MagicCircleInfoNotify()
      {
         super(CommandCodeMagicCircle.MAGIC_CIRCLE_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["hasMap:map(ubyte,ubyte)","useIndex:byte"];
      }
   }
}

