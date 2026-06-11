package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.tower.CommandCodePlayerTower;
   
   public class TowerEventType
   {
      
      public static const CLICK_LVUP_TOWER_ANSWER:String = CommandCodePlayerTower.CLICK_LVUP_TOWER_ANSWER.toString(16);
      
      public function TowerEventType()
      {
         super();
      }
   }
}

