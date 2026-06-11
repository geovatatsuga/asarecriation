package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerInviteRideRequest extends obf_O_8_1034
   {
      
      public var guestPlayerId:String;
      
      public function PlayerInviteRideRequest()
      {
         super(CommandCodePlayer.PLAYER_INVITE_RIDE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["guestPlayerId:string"];
      }
   }
}

