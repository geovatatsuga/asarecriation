package com.sunweb.game.util
{
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   
   public class obf_3_9_3148
   {
      
      public function obf_3_9_3148()
      {
         super();
      }
      
      public static function removeChildren(param1:DisplayObjectContainer) : void
      {
         var _loc2_:* = int(param1.numChildren - 1);
         while(_loc2_ >= 0)
         {
            param1.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      public static function mcContainsLabel(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:FrameLabel = null;
         for each(_loc3_ in param1.currentLabels)
         {
            if(_loc3_.name == param2)
            {
               return true;
            }
         }
         return false;
      }
   }
}

