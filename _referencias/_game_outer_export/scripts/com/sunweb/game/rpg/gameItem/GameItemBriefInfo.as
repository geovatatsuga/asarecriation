package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class GameItemBriefInfo extends obf_2_M_853
   {
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int = 1;
      
      public function GameItemBriefInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","itemCode:string","itemCount:ubyte"];
      }
   }
}

