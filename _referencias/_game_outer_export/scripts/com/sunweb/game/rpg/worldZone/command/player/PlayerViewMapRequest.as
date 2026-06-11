package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewMapRequest extends obf_O_8_1034
   {
      
      public function PlayerViewMapRequest()
      {
         super(CommandCodePlayer.PLAYER_VIEW_MAP_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

