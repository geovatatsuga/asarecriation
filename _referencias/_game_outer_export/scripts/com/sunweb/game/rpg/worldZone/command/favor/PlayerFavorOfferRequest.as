package com.sunweb.game.rpg.worldZone.command.favor
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFavorOfferRequest extends obf_O_8_1034
   {
      
      public var items:Object;
      
      public function PlayerFavorOfferRequest()
      {
         super(CommandPlayerFavor.PLAYER_FAVOR_OFFER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:map(string,ubyte)"];
      }
   }
}

