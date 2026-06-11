package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MakeChipRequest extends obf_O_8_1034
   {
      
      public var makeChipId:String;
      
      public function MakeChipRequest()
      {
         super(CommandCodeMakeChip.MAKE_CHIP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["makeChipId:string"];
      }
   }
}

