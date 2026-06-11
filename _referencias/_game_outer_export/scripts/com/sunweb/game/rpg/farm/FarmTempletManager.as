package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.util.debug.obf_x_0_1295;
   
   public class FarmTempletManager
   {
      
      private static var _farmTempletMap:Object;
      
      public function FarmTempletManager()
      {
         super();
      }
      
      public static function initialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_n_v_1693 = null;
         _farmTempletMap = new Object();
         for each(_loc2_ in param1)
         {
            _loc3_ = new obf_n_v_1693(_loc2_);
            if(getFarmTemplet(_loc3_.code) == null)
            {
               _farmTempletMap[_loc2_.code] = _loc3_;
            }
            else
            {
               obf_x_0_1295.obf_r_w_3556("==== obf_________49：" + _loc3_.code);
            }
         }
      }
      
      public static function getFarmTemplet(param1:String) : obf_n_v_1693
      {
         return _farmTempletMap[param1];
      }
   }
}

