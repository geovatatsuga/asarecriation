package com.sunweb.game.rpg.worldZone.command.player.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerRideFusionRequest extends obf_O_8_1034
   {
      
      public var mainRideId:String;
      
      public var minorRideId:String;
      
      public var changeItem:Object;
      
      public var fusionItem:Object;
      
      public function PlayerRideFusionRequest()
      {
         super(CommandCodePlayer.PLAYER_RIDE_FUSION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mainRideId:string","minorRideId:string","changeItem:map(string,ubyte)","fusionItem:map(string,ubyte)"];
      }
   }
}

