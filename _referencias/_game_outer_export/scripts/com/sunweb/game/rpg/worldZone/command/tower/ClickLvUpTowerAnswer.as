package com.sunweb.game.rpg.worldZone.command.tower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ClickLvUpTowerAnswer extends obf_O_8_1034
   {
      
      public var changeValue:int;
      
      public var currValue:int;
      
      public var characterIndex:int;
      
      public var num:int;
      
      public function ClickLvUpTowerAnswer()
      {
         super(CommandCodePlayerTower.CLICK_LVUP_TOWER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["changeValue:int","currValue:int","characterIndex:ubyte","num:ushort"];
      }
   }
}

