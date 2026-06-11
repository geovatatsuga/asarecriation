package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerReceiveInviteRideRequestNotify extends obf_O_8_1034
   {
      
      public var masterPlayerId:String;
      
      public function PlayerReceiveInviteRideRequestNotify()
      {
         super(CommandCodePlayer.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["masterPlayerId:string"];
      }
   }
}

