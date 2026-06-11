package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardTurnNotify extends obf_O_8_1034
   {
      
      public var cards:Array;
      
      public var turnTimes:int;
      
      public var gameTimes:int;
      
      public var indexs:Array;
      
      public var ruleKind:Array;
      
      public var bounIndexs:Array;
      
      public function PlayerCardTurnNotify()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_TURN_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["cards:array(com.sunweb.game.rpg.playingCard.CardInfo)","turnTimes:ubyte","gameTimes:ubyte","indexs:array(ubyte)","ruleKind:array(ubyte)","bounIndexs:array(ubyte)"];
      }
   }
}

