package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerShowTalksNotify extends obf_O_8_1034
   {
      
      public var talkList:Array;
      
      public function PlayerShowTalksNotify()
      {
         super(CommandCodePlayer.PLAYER_SHOW_TALKS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["talkList:array(string)"];
      }
   }
}

