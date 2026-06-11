package com.sunweb.game.rpg.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class TeamRollItemInfo extends obf_2_M_853
   {
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int = 1;
      
      public var rollTimeMSLeft:int = 0;
      
      public function TeamRollItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","itemCode:string","itemCount:ubyte","rollTimeMSLeft:int"];
      }
   }
}

