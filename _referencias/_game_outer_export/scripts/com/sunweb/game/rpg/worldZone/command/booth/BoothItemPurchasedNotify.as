package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   
   public class BoothItemPurchasedNotify extends obf_O_8_1034
   {
      
      public var purchaseItemInfo:BoothItemPurchaseInfo;
      
      public function BoothItemPurchasedNotify()
      {
         super(CommandCodePlayerBooth.BOOTH_ITEM_PURCHASED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["purchaseItemInfo:com.sunweb.game.rpg.booth.BoothItemPurchaseInfo"];
      }
   }
}

