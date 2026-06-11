package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEnterWorldRequest extends obf_O_8_1034
   {
      
      public function PlayerEnterWorldRequest()
      {
         super(CommandCodePlayer.PLAYER_ENTER_WORLD_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

