package com.sunweb.game.rpg.worldZone.command.tower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class EnterTowerRequest extends obf_O_8_1034
   {
      
      public function EnterTowerRequest()
      {
         super(CommandCodePlayerTower.ENTER_TOWER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

