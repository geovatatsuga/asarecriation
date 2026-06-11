package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.util.debug.obf_x_0_1295;
   
   public class obf_d_8_4301
   {
      
      private static var obf_L_h_2449:Object;
      
      public function obf_d_8_4301()
      {
         super();
      }
      
      public static function initialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         obf_L_h_2449 = new Object();
         for each(_loc2_ in param1)
         {
            if(getFarmBuildingInfo(_loc2_.code) == null)
            {
               obf_L_h_2449[_loc2_.code] = _loc2_;
            }
            else
            {
               obf_x_0_1295.obf_r_w_3556("==== obf_________37：" + _loc2_.code);
            }
         }
      }
      
      public static function getFarmBuildingInfo(param1:String) : Object
      {
         return obf_L_h_2449[param1];
      }
   }
}

