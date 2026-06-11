package com.sunweb.game.rpg.worldZone.command.rideDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideDepotUpLevelRequest extends obf_O_8_1034
   {
      
      public function RideDepotUpLevelRequest()
      {
         super(CommandCodePlayerRideDepot.RIDEDEPOT_UPLEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

