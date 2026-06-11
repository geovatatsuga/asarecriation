package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ShopBuyItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var buyItemList:Array;
      
      public var ssKey:int = Math.random() * 10000;
      
      public function ShopBuyItemRequest()
      {
         super(CommandCodeShop.SHOP_BUY_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","buyItemList:array(com.sunweb.game.rpg.shop.BuyItemInfo)","ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 51209;
      }
   }
}

