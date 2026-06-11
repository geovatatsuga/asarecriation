package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLevelUpNotify extends obf_O_8_1034
   {
      
      public var newLevel:int;
      
      public function PlayerLevelUpNotify()
      {
         super(CommandCodePlayer.PLAYER_LEVEL_UP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["newLevel:short"];
      }
   }
}

