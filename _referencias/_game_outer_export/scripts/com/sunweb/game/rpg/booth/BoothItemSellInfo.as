package com.sunweb.game.rpg.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class BoothItemSellInfo extends obf_2_M_853
   {
      
      public var itemIndex:int;
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int;
      
      public var itemPrice:int;
      
      public function BoothItemSellInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemIndex:byte","itemId:string","itemCode:string","itemCount:ubyte","itemPrice:int"];
      }
   }
}

