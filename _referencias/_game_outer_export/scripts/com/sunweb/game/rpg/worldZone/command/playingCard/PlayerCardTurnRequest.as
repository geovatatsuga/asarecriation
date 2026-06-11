package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardTurnRequest extends obf_O_8_1034
   {
      
      public var index:int;
      
      public var cardId:String;
      
      public function PlayerCardTurnRequest()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_TURN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:ubyte","cardId:string"];
      }
   }
}

