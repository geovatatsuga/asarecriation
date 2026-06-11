package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardStartRequest extends obf_O_8_1034
   {
      
      public function PlayerCardStartRequest()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_START_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

