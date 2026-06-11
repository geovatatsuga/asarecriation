package com.sunweb.game.rpg.worldZone.command.player.pk
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerPKModeChangeNotify extends obf_O_8_1034
   {
      
      public var pkMode:int;
      
      public function PlayerPKModeChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_PK_MODE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["pkMode:byte"];
      }
   }
}

