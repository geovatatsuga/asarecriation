package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class GameItemCDManager
   {
      
      private static var cdDisplay:Object = new Object();
      
      private static var cdObject:Object = new Object();
      
      private static var completedCDDisplay:Object = new Object();
      
      public function GameItemCDManager()
      {
         super();
      }
      
      public static function setItemCD(param1:String, param2:int) : void
      {
         if(obf_L_l_4100.isEmpty(param1) || param2 <= 0)
         {
            return;
         }
         if(!cdObject[param1])
         {
            cdObject[param1] = new TimeLimiter(param2);
         }
         createCDBitmapData(param1);
      }
      
      private static function createCDBitmapData(param1:String) : void
      {
         if(!cdDisplay[param1])
         {
            cdDisplay[param1] = new BitmapData(32,32,true,0);
         }
      }
      
      public static function checkItemCD(param1:String) : Boolean
      {
         if(!cdObject[param1])
         {
            return false;
         }
         if(cdObject[param1].checkTimeout())
         {
            return false;
         }
         return true;
      }
      
      public static function getCDBitmapData(param1:String) : BitmapData
      {
         createCDBitmapData(param1);
         return cdDisplay[param1];
      }
      
      public static function getCDBitmap(param1:String) : Bitmap
      {
         return new Bitmap(getCDBitmapData(param1));
      }
      
      public static function runCD() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:TimeLimiter = null;
         var _loc4_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc6_:Rectangle = null;
         var _loc7_:BitmapData = null;
         var _loc8_:int = 0;
         for(_loc1_ in cdObject)
         {
            _loc3_ = cdObject[_loc1_];
            _loc4_ = getCDBitmapData(_loc1_);
            if(_loc4_)
            {
               _loc5_ = _loc3_.lastCheckedInterval / _loc3_.timelimit * 32;
               _loc6_ = new Rectangle(0,0,32,_loc5_);
               _loc4_.fillRect(new Rectangle(0,0,32,32),3422552064);
               _loc4_.fillRect(new Rectangle(0,32 - _loc5_,32,32),0);
            }
            if(_loc3_.checkTimeout())
            {
               if(_loc4_)
               {
                  _loc4_.fillRect(new Rectangle(0,0,32,32),4294967295);
                  completedCDDisplay[_loc1_] = _loc4_;
               }
               delete cdObject[_loc1_];
            }
            else if(completedCDDisplay.hasOwnProperty(_loc1_))
            {
               delete completedCDDisplay[_loc1_];
            }
         }
         for(_loc2_ in completedCDDisplay)
         {
            _loc7_ = completedCDDisplay[_loc2_] as BitmapData;
            if(_loc7_)
            {
               _loc8_ = _loc7_.getPixel32(1,1) >> 24 & 0xFF;
               if(_loc8_ > 0)
               {
                  _loc8_ -= 15;
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 0;
                  }
                  _loc7_.fillRect(new Rectangle(0,0,32,32),16777215 + (_loc8_ << 24));
               }
               else
               {
                  _loc7_.fillRect(new Rectangle(0,0,32,32),0);
                  delete completedCDDisplay[_loc2_];
               }
            }
         }
      }
   }
}

