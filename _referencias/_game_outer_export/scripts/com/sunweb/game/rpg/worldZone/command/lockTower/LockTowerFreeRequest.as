package com.sunweb.game.rpg.worldZone.command.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LockTowerFreeRequest extends obf_O_8_1034
   {
      
      public var floor:int;
      
      public function LockTowerFreeRequest()
      {
         super(CommandCodeLockTower.LOCK_TOWER_FREE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["floor:ubyte"];
      }
   }
}

