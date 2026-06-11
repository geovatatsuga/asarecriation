package com.sunweb.game.rpg.worldZone.command.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCardBounAnswer extends obf_O_8_1034
   {
      
      public var isSucceed:Boolean;
      
      public function PlayerCardBounAnswer()
      {
         super(CommandCodePlayerNineCard.PLAYER_CARD_BOUN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSucceed:boolean"];
      }
   }
}

