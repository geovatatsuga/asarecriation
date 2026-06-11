package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BreakChipRequest extends obf_O_8_1034
   {
      
      public var chips:Object;
      
      public function BreakChipRequest()
      {
         super(CommandCodeMakeChip.BREAK_CHIP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["chips:map(string,int)"];
      }
   }
}

