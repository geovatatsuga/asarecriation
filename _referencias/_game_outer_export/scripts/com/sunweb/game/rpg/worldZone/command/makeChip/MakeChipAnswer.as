package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MakeChipAnswer extends obf_O_8_1034
   {
      
      public var chips:Object;
      
      public var chipSupers:Object;
      
      public var chipAttrs:Object;
      
      public function MakeChipAnswer()
      {
         super(CommandCodeMakeChip.MAKE_CHIP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["chips:map(string,int)","chipSupers:map(string,int)","chipAttrs:map(string,ubyte)"];
      }
   }
}

