package com.sunweb.game.rpg.worldZone.command.playerBook
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBookTimePointNotify extends obf_O_8_1034
   {
      
      public var bookTimePoint:int;
      
      public function PlayerBookTimePointNotify()
      {
         super(CommandCodePlayerBook.PLAYER_BOOK_TIME_POINT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bookTimePoint:int"];
      }
   }
}

