package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideStateCheckNotify extends obf_O_8_1034
   {
      
      public var rideCode:String;
      
      public var rideMasterPlayerId:String;
      
      public var rideGuestPlayerIds:Array;
      
      public function PlayerRideStateCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_RIDE_STATE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideCode:string","rideMasterPlayerId:string","rideGuestPlayerIds:array(string)"];
      }
   }
}

