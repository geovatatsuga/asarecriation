package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideDecomposeRequest extends obf_O_8_1034
   {
      
      public var rideId:String;
      
      public function PlayerRideDecomposeRequest()
      {
         super(CommandCodePlayer.PLAYER_RIDE_DECOMPOSE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string"];
      }
   }
}

