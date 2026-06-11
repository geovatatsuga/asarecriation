package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualLotteryRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function ItemManualLotteryRequest()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_LOTTERY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

