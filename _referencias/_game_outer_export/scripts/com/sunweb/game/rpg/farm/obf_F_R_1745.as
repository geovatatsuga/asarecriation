package com.sunweb.game.rpg.farm
{
   public class obf_F_R_1745
   {
      
      private static var obf_8_i_2475:Array;
      
      private static var _styles:Object = new Object();
      
      public function obf_F_R_1745()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         obf_8_i_2475 = param1;
         for each(_loc2_ in param1)
         {
            _styles[_loc2_.styleCode] = _loc2_;
         }
      }
      
      public static function getFarmStyleRes(param1:String) : String
      {
         if(_styles[param1] != null)
         {
            return _styles[param1].res;
         }
         return "";
      }
      
      public static function getFarmStyleName(param1:String) : String
      {
         if(_styles[param1] != null)
         {
            return _styles[param1].styleName;
         }
         return "";
      }
      
      public static function getValidFarmStyle(param1:String) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in obf_8_i_2475)
         {
            if(Boolean(_loc3_.farmCodes) && _loc3_.farmCodes.indexOf(param1) > -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

