package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerAddRideExpRequest extends obf_O_8_1034
   {
      
      public var rideId:String;
      
      public var exp:int;
      
      public function PlayerAddRideExpRequest()
      {
         super(CommandCodePlayer.PLAYER_ADD_RIDE_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string","exp:short"];
      }
   }
}

