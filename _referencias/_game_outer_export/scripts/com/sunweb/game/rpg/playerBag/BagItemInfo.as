package com.sunweb.game.rpg.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   
   public class BagItemInfo extends obf_2_M_853
   {
      
      public var itemIndex:int;
      
      public var gameItem:GameItemBriefInfo;
      
      public function BagItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemIndex:ubyte","gameItem:com.sunweb.game.rpg.gameItem.GameItemBriefInfo"];
      }
   }
}

