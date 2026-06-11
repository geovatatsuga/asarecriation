package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MakeChipInfoNotify extends obf_O_8_1034
   {
      
      public var chipBoxs:Object;
      
      public var chipBadKeys:Object;
      
      public var chipKeys:Object;
      
      public var chips:Object;
      
      public var chipSupers:Object;
      
      public var chipAttrs:Object;
      
      public function MakeChipInfoNotify()
      {
         super(CommandCodeMakeChip.MAKE_CHIP_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["chipBoxs:map(string,int)","chipBadKeys:map(string,int)","chipKeys:map(string,int)","chips:map(string,int)","chipSupers:map(string,int)","chipAttrs:map(string,ubyte)"];
      }
   }
}

