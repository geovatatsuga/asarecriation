package com.sunweb.game.rpg.worldZone.command.tower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ClickLvUpTowerRequest extends obf_O_8_1034
   {
      
      public var characterIndex:int;
      
      public function ClickLvUpTowerRequest()
      {
         super(CommandCodePlayerTower.CLICK_LVUP_TOWER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["characterIndex:ubyte"];
      }
   }
}

