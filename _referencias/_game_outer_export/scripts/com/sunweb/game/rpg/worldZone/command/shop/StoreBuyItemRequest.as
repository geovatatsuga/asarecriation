package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StoreBuyItemRequest extends obf_O_8_1034
   {
      
      public var buyItemList:Array;
      
      public var giveToPlayerId:String;
      
      public var ssKey:int = Math.random() * 10000;
      
      public function StoreBuyItemRequest()
      {
         super(CommandCodeShop.STORE_BUY_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["buyItemList:array(com.sunweb.game.rpg.shop.BuyItemInfo)","giveToPlayerId:string","ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 41222;
      }
   }
}

