package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerKitTitleCheckNotify extends obf_O_8_1034
   {
      
      public var titleIndex:int;
      
      public function PlayerKitTitleCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_KIT_TITLE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["titleIndex:short"];
      }
   }
}

