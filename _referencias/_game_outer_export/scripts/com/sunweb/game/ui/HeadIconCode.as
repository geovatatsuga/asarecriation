package com.sunweb.game.ui
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import img.*;
   
   public class HeadIconCode
   {
      
      private static const HEADICONCODE_SEX0:Array = ["000","001","002","003","004","005"];
      
      private static const HEADICONCODE_SEX1:Array = ["000","101","102","103","104","105"];
      
      public function HeadIconCode()
      {
         super();
      }
      
      public static function getHeadIconCodeArray(param1:int) : Array
      {
         if(param1 == 0)
         {
            return HEADICONCODE_SEX0;
         }
         if(param1 == 1)
         {
            return HEADICONCODE_SEX1;
         }
         return null;
      }
      
      public static function getHeadIconCode(param1:int, param2:int) : int
      {
         var _loc3_:Array = getHeadIconCodeArray(param2);
         if(!_loc3_ || param1 < 0 || param1 >= _loc3_.length)
         {
            return 0;
         }
         return parseInt(_loc3_[param1]);
      }
      
      public static function getHeadIcon(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = ResourceManager.instance.getMovieClip("HeadIcon_" + param1 + "@ta3");
         if(!_loc2_)
         {
            _loc2_ = new HeadIcon_000();
         }
         return _loc2_;
      }
      
      public static function getHeadIconByInt(param1:int) : DisplayObject
      {
         var _loc2_:String = obf_L_l_4100.obf_1_m_1767(param1 + "",3,"0");
         return getHeadIcon(_loc2_);
      }
      
      public static function getTalkHeadIcon(param1:String) : DisplayObject
      {
         return ResourceManager.instance.getMovieClip("HeadIcon_" + param1 + "@ta4");
      }
      
      public static function getTalkHeadIconByInt(param1:int) : DisplayObject
      {
         var _loc2_:String = obf_L_l_4100.obf_1_m_1767(param1 + "",3,"0");
         return getTalkHeadIcon(_loc2_);
      }
      
      public static function getMonsterIcon(param1:String) : Bitmap
      {
         return new Bitmap();
      }
   }
}

