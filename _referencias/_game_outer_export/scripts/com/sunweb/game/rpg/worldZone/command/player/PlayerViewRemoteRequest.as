package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewRemoteRequest extends obf_O_8_1034
   {
      
      public var remotePlayerId:String;
      
      public function PlayerViewRemoteRequest()
      {
         super(CommandCodePlayer.PLAYER_VIEW_REMOTE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["remotePlayerId:string"];
      }
   }
}

