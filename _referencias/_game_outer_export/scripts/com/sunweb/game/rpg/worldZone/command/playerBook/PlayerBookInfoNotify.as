package com.sunweb.game.rpg.worldZone.command.playerBook
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBookInfoNotify extends obf_O_8_1034
   {
      
      public var bookLevel:int;
      
      public var bookExp:int;
      
      public var bookTimePoint:int;
      
      public var bookSkillMap:Object;
      
      public function PlayerBookInfoNotify()
      {
         super(CommandCodePlayerBook.PLAYER_BOOK_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bookLevel:ubyte","bookExp:int","bookTimePoint:int","bookSkillMap:map(string,ubyte)"];
      }
   }
}

