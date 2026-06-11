package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideRequest extends obf_O_8_1034
   {
      
      public var rideId:String;
      
      public function PlayerRideRequest()
      {
         super(CommandCodePlayer.PLAYER_RIDE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string"];
      }
   }
}

