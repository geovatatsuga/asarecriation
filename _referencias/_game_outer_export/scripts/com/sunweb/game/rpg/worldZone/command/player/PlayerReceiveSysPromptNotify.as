package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveSysPromptNotify extends obf_O_8_1034
   {
      
      public var promptIndex:int = 0;
      
      public function PlayerReceiveSysPromptNotify()
      {
         super(CommandCodePlayer.PLAYER_RECEIVE_SYS_PROMPT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["promptIndex:short"];
      }
   }
}

