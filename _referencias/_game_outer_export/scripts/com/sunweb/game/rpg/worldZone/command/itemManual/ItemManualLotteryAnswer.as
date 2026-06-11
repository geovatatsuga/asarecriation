package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualLotteryAnswer extends obf_O_8_1034
   {
      
      public var getCodes:Array;
      
      public function ItemManualLotteryAnswer()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_LOTTERY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["getCodes:array(string)"];
      }
   }
}

