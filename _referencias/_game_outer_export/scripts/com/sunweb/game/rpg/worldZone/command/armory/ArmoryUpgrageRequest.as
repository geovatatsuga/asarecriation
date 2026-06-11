package com.sunweb.game.rpg.worldZone.command.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArmoryUpgrageRequest extends obf_O_8_1034
   {
      
      public function ArmoryUpgrageRequest()
      {
         super(CommandCodeArmory.PLAYER_ARMORY_UPGRADE_REQUEST);
      }
   }
}

