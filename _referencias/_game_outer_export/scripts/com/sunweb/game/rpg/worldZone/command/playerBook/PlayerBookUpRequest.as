package com.sunweb.game.rpg.worldZone.command.playerBook
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBookUpRequest extends obf_O_8_1034
   {
      
      public function PlayerBookUpRequest()
      {
         super(CommandCodePlayerBook.PLAYER_BOOK_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

