package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.ride.RideBriefInfo;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerUsingRideCheckNotify extends obf_O_8_1034
   {
      
      public var usingRide:RideBriefInfo;
      
      public function PlayerUsingRideCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_USING_RIDE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["usingRide:com.sunweb.game.rpg.ride.RideBriefInfo"];
      }
   }
}

