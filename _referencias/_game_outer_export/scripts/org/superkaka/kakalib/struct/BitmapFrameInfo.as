package org.superkaka.kakalib.struct
{
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.BitmapData;
   
   public class BitmapFrameInfo
   {
      
      private static const map_data:Object = {};
      
      public var x:Number;
      
      public var y:Number;
      
      public var bitmapData:BitmapData;
      
      public function BitmapFrameInfo()
      {
         super();
      }
      
      public static function storeBitmapFrameInfo(param1:String, param2:Vector.<BitmapFrameInfo>) : void
      {
         if(obf_L_l_4100.isEmpty(param1) || Boolean(map_data[param1]))
         {
            return;
         }
         map_data[param1] = param2;
         trace("obf____________18 id:",param1);
      }
      
      public static function storeBitmapInfo(param1:String, param2:BitmapFrameInfo) : void
      {
         if(obf_L_l_4100.isEmpty(param1) || Boolean(map_data[param1]))
         {
            return;
         }
         var _loc3_:Vector.<BitmapFrameInfo> = new Vector.<BitmapFrameInfo>(1,true);
         _loc3_[0] = param2;
         map_data[param1] = _loc3_;
         trace("obf___________25(obf___4899) id:",param1);
      }
      
      public static function getBitmapFrameInfo(param1:String) : Vector.<BitmapFrameInfo>
      {
         return map_data[param1];
      }
      
      public static function isBeingBitmapFrameInfo(param1:String) : Boolean
      {
         return map_data[param1] ? true : false;
      }
   }
}

