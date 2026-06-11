package com.sunweb.game.rpg.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   
   public class EquippedItemInfo extends obf_2_M_853
   {
      
      public var equipmentKind:int;
      
      public var equipment:GameItemBriefInfo;
      
      public function EquippedItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentKind:ushort","equipment:com.sunweb.game.rpg.gameItem.GameItemBriefInfo"];
      }
   }
}

