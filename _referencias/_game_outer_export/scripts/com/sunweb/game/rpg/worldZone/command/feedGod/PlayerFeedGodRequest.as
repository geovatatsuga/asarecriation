package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFeedGodRequest extends obf_O_8_1034
   {
      
      public var godName:String;
      
      public function PlayerFeedGodRequest()
      {
         super(CommandCodePlayerFeedGod.PLAYER_FEED_GOD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["godName:string"];
      }
   }
}

