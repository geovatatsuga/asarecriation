package com.sunweb.game.rpg.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   
   public class ArmoryItemInfo extends obf_2_M_853
   {
      
      public var gridToMCName:String;
      
      public var gridKind:int;
      
      public var equipment:GameItemBriefInfo;
      
      public function ArmoryItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["gridToMCName:string","gridKind:ubyte","equipment:com.sunweb.game.rpg.gameItem.GameItemBriefInfo"];
      }
   }
}

