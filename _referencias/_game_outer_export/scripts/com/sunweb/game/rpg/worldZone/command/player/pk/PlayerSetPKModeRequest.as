package com.sunweb.game.rpg.worldZone.command.player.pk
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerSetPKModeRequest extends obf_O_8_1034
   {
      
      public var pkMode:int;
      
      public function PlayerSetPKModeRequest()
      {
         super(CommandCodePlayer.PLAYER_SET_PK_MODE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["pkMode:byte"];
      }
   }
}

