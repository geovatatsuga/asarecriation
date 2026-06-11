package com.sunweb.game.rpg.ride
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RideBriefInfo extends obf_2_M_853
   {
      
      public var rideId:String;
      
      public var rideCode:String;
      
      public function RideBriefInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["rideId:string","rideCode:string"];
      }
   }
}

