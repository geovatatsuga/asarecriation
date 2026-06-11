package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerReceivePassiveRideRequestNotify extends obf_O_8_1034
   {
      
      public var guestPlayerId:String;
      
      public function PlayerReceivePassiveRideRequestNotify()
      {
         super(CommandCodePlayer.PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["guestPlayerId:string"];
      }
   }
}

