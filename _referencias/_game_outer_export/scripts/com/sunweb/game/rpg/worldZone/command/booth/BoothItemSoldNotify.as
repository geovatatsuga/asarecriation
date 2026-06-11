package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.booth.BoothItemSellInfo;
   
   public class BoothItemSoldNotify extends obf_O_8_1034
   {
      
      public var soldItemInfo:BoothItemSellInfo;
      
      public function BoothItemSoldNotify()
      {
         super(CommandCodePlayerBooth.BOOTH_ITEM_SOLD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["soldItemInfo:com.sunweb.game.rpg.booth.BoothItemSellInfo"];
      }
   }
}

