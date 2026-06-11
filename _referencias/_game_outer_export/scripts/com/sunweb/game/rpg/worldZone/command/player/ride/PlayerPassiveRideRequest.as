package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerPassiveRideRequest extends obf_O_8_1034
   {
      
      public var masterPlayerId:String;
      
      public function PlayerPassiveRideRequest()
      {
         super(CommandCodePlayer.PLAYER_PASSIVE_RIDE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["masterPlayerId:string"];
      }
   }
}

