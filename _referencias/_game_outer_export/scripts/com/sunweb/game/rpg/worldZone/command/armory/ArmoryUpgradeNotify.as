package com.sunweb.game.rpg.worldZone.command.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArmoryUpgradeNotify extends obf_O_8_1034
   {
      
      public var opendArmoryGrids:Array;
      
      public var armoryLevel:int;
      
      public var armoryExp:int;
      
      public function ArmoryUpgradeNotify()
      {
         super(CommandCodeArmory.PLAYER_ARMORY_UPGRADE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["opendArmoryGrids:array(string)","armoryLevel:byte","armoryExp:int"];
      }
   }
}

