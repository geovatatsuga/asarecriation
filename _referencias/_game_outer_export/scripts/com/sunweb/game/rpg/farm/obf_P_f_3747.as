package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.util.debug.obf_x_0_1295;
   
   public class obf_P_f_3747
   {
      
      private static var obf_z_L_2483:Object;
      
      public function obf_P_f_3747()
      {
         super();
      }
      
      public static function initialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         obf_z_L_2483 = new Object();
         for each(_loc2_ in param1)
         {
            if(getFarmHarvestInfo(_loc2_.code) == null)
            {
               obf_z_L_2483[_loc2_.code] = _loc2_;
            }
            else
            {
               obf_x_0_1295.obf_r_w_3556("==== obf__________28：" + _loc2_.code);
            }
         }
      }
      
      public static function getFarmHarvestInfo(param1:String) : Object
      {
         return obf_z_L_2483[param1];
      }
   }
}

