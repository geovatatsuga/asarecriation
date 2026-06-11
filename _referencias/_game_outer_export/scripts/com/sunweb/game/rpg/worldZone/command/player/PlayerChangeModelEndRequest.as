package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChangeModelEndRequest extends obf_O_8_1034
   {
      
      public function PlayerChangeModelEndRequest()
      {
         super(CommandCodePlayer.PLAYER_CHANGE_MODEL_END_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

