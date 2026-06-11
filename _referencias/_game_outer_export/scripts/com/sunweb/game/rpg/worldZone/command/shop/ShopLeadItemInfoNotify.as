package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ShopLeadItemInfoNotify extends obf_O_8_1034
   {
      
      public var nextRefreshTimes:int;
      
      public var leadItems:Array;
      
      public function ShopLeadItemInfoNotify()
      {
         super(CommandCodeShop.LEAD_ITEM_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["nextRefreshTimes:int","leadItems:array(com.sunweb.game.rpg.shop.LeadItemList)"];
      }
   }
}

