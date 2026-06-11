package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerSetUsingRideRequest extends obf_O_8_1034
   {
      
      public var rideId:String;
      
      public function PlayerSetUsingRideRequest()
      {
         super(CommandCodePlayer.PLAYER_SET_USING_RIDE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string"];
      }
   }
}

