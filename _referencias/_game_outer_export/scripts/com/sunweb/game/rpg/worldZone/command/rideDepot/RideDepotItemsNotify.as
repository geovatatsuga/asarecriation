package com.sunweb.game.rpg.worldZone.command.rideDepot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideDepotItemsNotify extends obf_O_8_1034
   {
      
      public var items:Array;
      
      public var attrs:Object;
      
      public function RideDepotItemsNotify()
      {
         super(CommandCodePlayerRideDepot.RIDEDEPOT_ITEMS_NOYIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:array(com.sunweb.game.rpg.rideDepot.RideDepotItemInfo)","attrs:map(ushort,int)"];
      }
   }
}

