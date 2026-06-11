package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetKitTitleRequest extends obf_O_8_1034
   {
      
      public var titleIndex:int;
      
      public function PlayerSetKitTitleRequest()
      {
         super(CommandCodePlayer.PLAYER_SET_KIT_TITLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["titleIndex:short"];
      }
   }
}

