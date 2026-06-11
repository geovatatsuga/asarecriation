package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.playingCard.CommandCodePlayerNineCard;
   
   public class PlayingCardEvent
   {
      
      public static const PLAYER_CARD_START_ANSWER:String = CommandCodePlayerNineCard.PLAYER_CARD_START_ANSWER.toString(16);
      
      public static const PLAYER_CARD_TURN_ANSWER:String = CommandCodePlayerNineCard.PLAYER_CARD_TURN_ANSWER.toString(16);
      
      public static const PLAYER_CARD_TURN_NOTIFY:String = CommandCodePlayerNineCard.PLAYER_CARD_TURN_NOTIFY.toString(16);
      
      public static const PLAYER_CARD_GAME_TIMES_NOTIFY:String = CommandCodePlayerNineCard.PLAYER_CARD_GAME_TIMES_NOTIFY.toString(16);
      
      public static const PLAYER_CARD_BOUN_ANSWER:String = CommandCodePlayerNineCard.PLAYER_CARD_BOUN_ANSWER.toString(16);
      
      public function PlayingCardEvent()
      {
         super();
      }
   }
}

