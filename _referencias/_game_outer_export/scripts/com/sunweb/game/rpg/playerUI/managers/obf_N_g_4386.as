package com.sunweb.game.rpg.playerUI.managers
{
   import com.sunweb.game.res.ResourceManager;
   import flash.display.DisplayObject;
   
   public class obf_N_g_4386
   {
      
      public function obf_N_g_4386()
      {
         super();
      }
      
      public static function getFaceDisplay(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = ResourceManager.instance.getDisplayObject("f" + param1 + "@t03");
         if(_loc2_)
         {
            _loc2_.scaleX = 16 / _loc2_.width;
            _loc2_.scaleY = 16 / _loc2_.height;
         }
         return _loc2_;
      }
   }
}

