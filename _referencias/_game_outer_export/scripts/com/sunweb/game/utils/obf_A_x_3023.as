package com.sunweb.game.utils
{
   import flash.geom.Point;
   
   public class obf_A_x_3023
   {
      
      public function obf_A_x_3023()
      {
         super();
      }
      
      public static function getPointInScreenAngle(param1:Point) : Number
      {
         var _loc2_:Number = Math.atan2(param1.y,param1.x) * 180 / Math.PI;
         if(param1.y > 0)
         {
            _loc2_ = 360 - _loc2_;
         }
         else if(param1.y < 0)
         {
            _loc2_ = -_loc2_;
         }
         return _loc2_;
      }
      
      public static function getRateString(param1:Number) : String
      {
         return Math.round(param1 * 100) + "%";
      }
      
      public static function getTwoRateString(param1:Number) : String
      {
         return Math.round(param1 * 10000) / 100 + "%";
      }
   }
}

