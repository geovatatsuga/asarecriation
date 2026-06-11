package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLeaveWorldRequest extends obf_O_8_1034
   {
      
      public function PlayerLeaveWorldRequest()
      {
         super(CommandCodePlayer.PLAYER_LEAVE_WORLD_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

