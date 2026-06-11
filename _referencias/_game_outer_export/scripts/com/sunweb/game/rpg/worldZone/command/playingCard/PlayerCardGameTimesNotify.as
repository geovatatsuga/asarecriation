package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardGameTimesNotify extends obf_O_8_1034
   {
      
      public var gameTimes:int;
      
      public function PlayerCardGameTimesNotify()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_GAME_TIMES_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["gameTimes:ubyte"];
      }
   }
}

