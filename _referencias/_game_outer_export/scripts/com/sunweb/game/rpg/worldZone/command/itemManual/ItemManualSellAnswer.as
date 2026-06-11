package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSellAnswer extends obf_O_8_1034
   {
      
      public var change:Object;
      
      public function ItemManualSellAnswer()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SELL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["change:map(string,ubyte)"];
      }
   }
}

