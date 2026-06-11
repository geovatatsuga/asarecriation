package com.sunweb.game.rpg.shop
{
   public class obf_f_z_1191
   {
      
      private static var obf_D_W_2830:Object;
      
      public function obf_f_z_1191()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         obf_D_W_2830 = new Object();
         for each(_loc2_ in param1)
         {
            obf_D_W_2830[_loc2_.planId] = _loc2_;
         }
      }
      
      public static function getPlanConfig(param1:String) : Object
      {
         return obf_D_W_2830[param1] || null;
      }
   }
}

