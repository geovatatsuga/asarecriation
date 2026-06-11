package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFeedGodAnswer extends obf_O_8_1034
   {
      
      public var feedGodLevels:Object;
      
      public function PlayerFeedGodAnswer()
      {
         super(CommandCodePlayerFeedGod.PLAYER_FEED_GOD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["feedGodLevels:map(string,ubyte)"];
      }
   }
}

