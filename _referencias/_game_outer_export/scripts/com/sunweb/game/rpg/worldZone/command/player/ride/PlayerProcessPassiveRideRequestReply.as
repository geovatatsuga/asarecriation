package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerProcessPassiveRideRequestReply extends obf_O_8_1034
   {
      
      public var guestPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessPassiveRideRequestReply()
      {
         super(CommandCodePlayer.PLAYER_PROCESS_PASSIVE_RIDE_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["guestPlayerId:string","isAgreed:boolean"];
      }
   }
}

