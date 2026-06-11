package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteRideCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var rideCode:String;
      
      public var rideMasterPlayerId:String;
      
      public var rideGuestPlayerIds:Array;
      
      public function RemoteRideCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_RIDE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","rideCode:string","rideMasterPlayerId:string","rideGuestPlayerIds:array(string)"];
      }
   }
}

