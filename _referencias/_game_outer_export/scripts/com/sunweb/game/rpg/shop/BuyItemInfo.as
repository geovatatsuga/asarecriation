package com.sunweb.game.rpg.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class BuyItemInfo extends obf_2_M_853
   {
      
      public var itemCode:String;
      
      public var itemCount:int = 1;
      
      public var buyMode:int = 0;
      
      public function BuyItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","itemCount:ubyte","buyMode:byte"];
      }
   }
}

