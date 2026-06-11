package com.sunweb.game.rpg.worldZone.command.rideDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideDepotRemoveRequest extends obf_O_8_1034
   {
      
      public var index:int;
      
      public var itemId:String;
      
      public function RideDepotRemoveRequest()
      {
         super(CommandCodePlayerRideDepot.RIDEDEPOT_REMOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:ushort","itemId:string"];
      }
   }
}

