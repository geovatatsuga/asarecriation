package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFeedGodNotify extends obf_O_8_1034
   {
      
      public var feedGodLevels:Object;
      
      public var useGodName:String;
      
      public var sumGodLevel:int;
      
      public function PlayerFeedGodNotify()
      {
         super(CommandCodePlayerFeedGod.PLAYER_FEED_GOD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["feedGodLevels:map(string,ubyte)","useGodName:string","sumGodLevel:ubyte"];
      }
   }
}

