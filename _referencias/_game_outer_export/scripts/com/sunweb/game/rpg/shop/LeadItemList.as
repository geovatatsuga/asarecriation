package com.sunweb.game.rpg.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class LeadItemList extends obf_2_M_853
   {
      
      public var itemCode:String;
      
      public var itemCount:int;
      
      public var itemPrice:int;
      
      public var itemWorth:int;
      
      public var itemGift:int;
      
      public function LeadItemList()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","itemCount:ubyte","itemPrice:int","itemWorth:int","itemGift:int"];
      }
   }
}

