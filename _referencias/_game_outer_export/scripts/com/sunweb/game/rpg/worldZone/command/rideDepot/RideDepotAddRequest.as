package com.sunweb.game.rpg.worldZone.command.rideDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideDepotAddRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public function RideDepotAddRequest()
      {
         super(CommandCodePlayerRideDepot.RIDEDEPOT_ADD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string"];
      }
   }
}

