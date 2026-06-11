package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerKickRideRequest extends obf_O_8_1034
   {
      
      public var kickPlayerId:String;
      
      public function PlayerKickRideRequest()
      {
         super(CommandCodePlayer.PLAYER_KICK_RIDE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kickPlayerId:string"];
      }
   }
}

