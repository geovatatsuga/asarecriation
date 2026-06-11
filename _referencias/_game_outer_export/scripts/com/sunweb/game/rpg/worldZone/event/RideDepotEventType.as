package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.rideDepot.CommandCodePlayerRideDepot;
   
   public class RideDepotEventType
   {
      
      public static const RIDEDEPOT_UPLEVEL_ANSWER:String = CommandCodePlayerRideDepot.RIDEDEPOT_UPLEVEL_ANSWER.toString(16);
      
      public static const RIDEDEPOT_ITEMS_NOYIFY:String = CommandCodePlayerRideDepot.RIDEDEPOT_ITEMS_NOYIFY.toString(16);
      
      public function RideDepotEventType()
      {
         super();
      }
   }
}

