package com.sunweb.game.rpg.role
{
   public class obf_o_2392
   {
      
      private static var _rideModelList:Array;
      
      private static var _rideModelMap:Object;
      
      public function obf_o_2392()
      {
         super();
      }
      
      public static function set rideModelList(param1:Array) : void
      {
         var _loc2_:Object = null;
         _rideModelList = param1;
         _rideModelMap = new Object();
         for each(_loc2_ in param1)
         {
            _rideModelMap[_loc2_.code] = _loc2_;
         }
      }
      
      public static function get rideModelList() : Array
      {
         return _rideModelList;
      }
      
      public static function getRideModel(param1:String) : Object
      {
         return _rideModelMap[param1];
      }
   }
}

