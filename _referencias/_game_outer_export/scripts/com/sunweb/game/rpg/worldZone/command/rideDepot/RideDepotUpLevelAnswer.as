package com.sunweb.game.rpg.worldZone.command.rideDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideDepotUpLevelAnswer extends obf_O_8_1034
   {
      
      public var currentLv:int;
      
      public var currentCount:int;
      
      public function RideDepotUpLevelAnswer()
      {
         super(CommandCodePlayerRideDepot.RIDEDEPOT_UPLEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["currentLv:short","currentCount:ushort"];
      }
   }
}

