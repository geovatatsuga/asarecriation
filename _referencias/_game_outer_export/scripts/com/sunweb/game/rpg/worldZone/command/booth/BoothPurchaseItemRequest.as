package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   
   public class BoothPurchaseItemRequest extends obf_O_8_1034
   {
      
      public var boothOwnerId:String;
      
      public var purchaseItemInfo:BoothItemPurchaseInfo;
      
      public function BoothPurchaseItemRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_PURCHASE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothOwnerId:string","purchaseItemInfo:com.sunweb.game.rpg.booth.BoothItemPurchaseInfo"];
      }
   }
}

