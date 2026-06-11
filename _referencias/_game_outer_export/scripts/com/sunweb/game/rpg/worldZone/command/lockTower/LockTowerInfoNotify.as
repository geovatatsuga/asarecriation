package com.sunweb.game.rpg.worldZone.command.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LockTowerInfoNotify extends obf_O_8_1034
   {
      
      public var isAll:Boolean;
      
      public var lockTower:Object;
      
      public function LockTowerInfoNotify()
      {
         super(CommandCodeLockTower.LOCK_TOWER_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isAll:boolean","lockTower:map(ubyte,com.sunweb.game.rpg.lockTower.LockTowerInfo)"];
      }
   }
}

