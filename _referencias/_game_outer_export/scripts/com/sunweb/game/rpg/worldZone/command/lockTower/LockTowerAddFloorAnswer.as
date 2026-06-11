package com.sunweb.game.rpg.worldZone.command.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.lockTower.LockTowerInfo;
   
   public class LockTowerAddFloorAnswer extends obf_O_8_1034
   {
      
      public var lockTowerInfo:LockTowerInfo;
      
      public function LockTowerAddFloorAnswer()
      {
         super(CommandCodeLockTower.LOCK_TOWER_ADD_FLOOR_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["lockTowerInfo:com.sunweb.game.rpg.lockTower.LockTowerInfo"];
      }
   }
}

