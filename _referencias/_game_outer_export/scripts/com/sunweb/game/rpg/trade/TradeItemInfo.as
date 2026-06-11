package com.sunweb.game.rpg.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   
   public class TradeItemInfo extends obf_2_M_853
   {
      
      public var bagIndex:int;
      
      public var itemIndex:int;
      
      public var itemInfo:GameItemBriefInfo;
      
      public function TradeItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","itemIndex:ubyte","itemInfo:com.sunweb.game.rpg.gameItem.GameItemBriefInfo"];
      }
   }
}

