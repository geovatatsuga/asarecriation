package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardBounRequest extends obf_O_8_1034
   {
      
      public var bounList:Array;
      
      public function PlayerCardBounRequest()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_BOUN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bounList:array(ubyte)"];
      }
   }
}

