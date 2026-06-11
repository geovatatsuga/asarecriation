package com.sunweb.game.rpg.worldZone.command.divine
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDivineUpLevelRequest extends obf_O_8_1034
   {
      
      public function PlayerDivineUpLevelRequest()
      {
         super(CommandCodePlayerDivine.PLAYER_DIVINE_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

