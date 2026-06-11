package com.sunweb.game.rpg.worldZone.command.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArmoryUpgradeAnswer extends obf_O_8_1034
   {
      
      public var armoryExp:int;
      
      public function ArmoryUpgradeAnswer()
      {
         super(CommandCodeArmory.PLAYER_ARMORY_UPGRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["armoryExp:int"];
      }
   }
}

