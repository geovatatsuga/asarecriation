package com.sunweb.game.rpg.worldZone.command.playerBook
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBookUpAnswer extends obf_O_8_1034
   {
      
      public var bookExp:int;
      
      public var bookTimePoint:int;
      
      public function PlayerBookUpAnswer()
      {
         super(CommandCodePlayerBook.PLAYER_BOOK_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["bookExp:int","bookTimePoint:int"];
      }
   }
}

