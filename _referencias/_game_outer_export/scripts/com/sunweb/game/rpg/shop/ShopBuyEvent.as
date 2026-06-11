package com.sunweb.game.rpg.shop
{
   import flash.events.Event;
   
   public class ShopBuyEvent extends Event
   {
      
      public static const SHOP_BUY:String = "shop_buy";
      
      public var buyType:int;
      
      public var itemCode:String;
      
      public var toPlayerId:String;
      
      public var itemType:int = 0;
      
      public var leadPrice:int = 0;
      
      public var itemCount:int = 0;
      
      public function ShopBuyEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

