package com.sunweb.game.rpg.worldZone.command.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LockTowerAddFloorRequest extends obf_O_8_1034
   {
      
      public function LockTowerAddFloorRequest()
      {
         super(CommandCodeLockTower.LOCK_TOWER_ADD_FLOOR_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

