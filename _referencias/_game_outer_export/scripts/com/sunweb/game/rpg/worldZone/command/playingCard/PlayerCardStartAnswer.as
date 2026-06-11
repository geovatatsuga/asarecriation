package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardStartAnswer extends obf_O_8_1034
   {
      
      public var cards:Array;
      
      public var turnTimes:int;
      
      public var gameTimes:int;
      
      public function PlayerCardStartAnswer()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_START_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["cards:array(com.sunweb.game.rpg.playingCard.CardInfo)","turnTimes:ubyte","gameTimes:ubyte"];
      }
   }
}

