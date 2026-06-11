package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BreakChipAnswer extends obf_O_8_1034
   {
      
      public var chips:Object;
      
      public var chipSupers:Object;
      
      public function BreakChipAnswer()
      {
         super(CommandCodeMakeChip.BREAK_CHIP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["chips:map(string,int)","chipSupers:map(string,int)"];
      }
   }
}

