package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerProcessInviteRideRequestReply extends obf_O_8_1034
   {
      
      public var masterPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessInviteRideRequestReply()
      {
         super(CommandCodePlayer.PLAYER_PROCESS_INVITE_RIDE_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["masterPlayerId:string","isAgreed:boolean"];
      }
   }
}

