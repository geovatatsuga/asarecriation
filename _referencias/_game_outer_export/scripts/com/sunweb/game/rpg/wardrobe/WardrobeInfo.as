package com.sunweb.game.rpg.wardrobe
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   
   public class WardrobeInfo extends obf_2_M_853
   {
      
      public var index:int;
      
      public var item:GameItemBriefInfo;
      
      public function WardrobeInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["index:ushort","item:com.sunweb.game.rpg.gameItem.GameItemBriefInfo"];
      }
   }
}

