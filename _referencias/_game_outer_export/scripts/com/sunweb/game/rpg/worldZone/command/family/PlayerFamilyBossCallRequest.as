package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyBossCallRequest extends obf_O_8_1034
   {
      
      public function PlayerFamilyBossCallRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_BOSS_CALL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

