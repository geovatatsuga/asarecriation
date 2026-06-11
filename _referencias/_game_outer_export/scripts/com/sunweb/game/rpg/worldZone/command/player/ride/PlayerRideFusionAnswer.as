package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideFusionAnswer extends obf_O_8_1034
   {
      
      public var rideId:String;
      
      public var rideCode:String;
      
      public var generation:int;
      
      public var isSucceeded:Boolean;
      
      public function PlayerRideFusionAnswer()
      {
         super(CommandCodePlayer.PLAYER_RIDE_FUSION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string","rideCode:string","generation:byte","isSucceeded:boolean"];
      }
   }
}

