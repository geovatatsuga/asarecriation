package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.ride.RideFullInfo;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideItemCheckNotify extends obf_O_8_1034
   {
      
      public var ride:RideFullInfo;
      
      public function PlayerRideItemCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_RIDE_ITEM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["ride:com.sunweb.game.rpg.ride.RideFullInfo"];
      }
   }
}

