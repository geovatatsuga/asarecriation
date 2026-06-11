package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetTitleRequest extends obf_O_8_1034
   {
      
      public var titleIndex:int;
      
      public function PlayerSetTitleRequest()
      {
         super(CommandCodePlayer.PLAYER_SET_TITLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["titleIndex:short"];
      }
   }
}

