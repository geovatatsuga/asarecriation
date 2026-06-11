package com.sunweb.game.rpg.worldZone.command.favor
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFavorOfferAnswer extends obf_O_8_1034
   {
      
      public var favorValue:int;
      
      public function PlayerFavorOfferAnswer()
      {
         super(CommandPlayerFavor.PLAYER_FAVOR_OFFER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["favorValue:int"];
      }
   }
}

