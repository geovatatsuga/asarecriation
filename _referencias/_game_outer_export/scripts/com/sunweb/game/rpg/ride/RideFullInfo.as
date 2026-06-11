package com.sunweb.game.rpg.ride
{
   import com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo;
   
   public class RideFullInfo extends ItemPlayerRideInfo
   {
      
      public var rideId:String;
      
      public var rideCode:String;
      
      public function RideFullInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string","rideCode:string"].concat(super.getFieldList());
      }
   }
}

