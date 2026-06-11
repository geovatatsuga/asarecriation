package com.sunweb.game.rpg.worldZone.command.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LockTowerEatRequest extends obf_O_8_1034
   {
      
      public var floor:int;
      
      public var itemCode:String;
      
      public function LockTowerEatRequest()
      {
         super(CommandCodeLockTower.LOCK_TOWER_EAT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["floor:ubyte","itemCode:string"];
      }
   }
}

