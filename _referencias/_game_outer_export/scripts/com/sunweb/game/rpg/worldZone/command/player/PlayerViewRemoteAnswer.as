package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RemotePlayerViewInfo;
   
   public class PlayerViewRemoteAnswer extends obf_O_8_1034
   {
      
      public var remotePlayerInfo:RemotePlayerViewInfo;
      
      public function PlayerViewRemoteAnswer()
      {
         super(CommandCodePlayer.PLAYER_VIEW_REMOTE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["remotePlayerInfo:com.sunweb.game.rpg.role.RemotePlayerViewInfo"];
      }
   }
}

