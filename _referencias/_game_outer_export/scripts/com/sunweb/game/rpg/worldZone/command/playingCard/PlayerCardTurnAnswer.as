package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardTurnAnswer extends obf_O_8_1034
   {
      
      public var turnTimes:int;
      
      public var ruleKind:Array;
      
      public var bounIndexs:Array;
      
      public var indexs:Array;
      
      public function PlayerCardTurnAnswer()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_TURN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["turnTimes:ubyte","ruleKind:array(ubyte)","bounIndexs:array(ubyte)","indexs:array(ubyte)"];
      }
   }
}

