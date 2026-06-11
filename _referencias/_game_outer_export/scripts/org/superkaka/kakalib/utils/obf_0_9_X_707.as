package org.superkaka.kakalib.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   import org.superkaka.kakalib.struct.BitmapFrameInfo;
   import org.superkaka.kakalib.struct.obf_0_1_E_79;
   
   public class obf_0_9_X_707
   {
      
      private static var obf_X_H_3231:Point = new Point();
      
      public function obf_0_9_X_707()
      {
         super();
      }
      
      public static function cacheBitmap(param1:DisplayObject, param2:Boolean = true, param3:uint = 0, param4:Number = 1) : BitmapFrameInfo
      {
         var _loc11_:BitmapData = null;
         if(!param1)
         {
            return null;
         }
         var _loc5_:Rectangle = param1.getBounds(param1);
         var _loc6_:int = Math.round(_loc5_.x * param4);
         var _loc7_:int = Math.round(_loc5_.y * param4);
         if(_loc5_.isEmpty())
         {
            _loc5_.width = 1;
            _loc5_.height = 1;
         }
         var _loc8_:BitmapData = new BitmapData(Math.ceil(_loc5_.width * param4),Math.ceil(_loc5_.height * param4),param2,param3);
         _loc8_.draw(param1,new Matrix(param4,0,0,param4,-_loc6_,-_loc7_),null,null,null,true);
         var _loc9_:Rectangle = _loc8_.getColorBoundsRect(4278190080,0,false);
         if(!_loc9_.isEmpty() && (_loc8_.width != _loc9_.width || _loc8_.height != _loc9_.height))
         {
            _loc11_ = new BitmapData(_loc9_.width,_loc9_.height,param2,param3);
            _loc11_.copyPixels(_loc8_,_loc9_,obf_X_H_3231);
            _loc8_.dispose();
            _loc8_ = _loc11_;
            _loc6_ += _loc9_.x;
            _loc7_ += _loc9_.y;
         }
         var _loc10_:BitmapFrameInfo = new BitmapFrameInfo();
         _loc10_.x = _loc6_;
         _loc10_.y = _loc7_;
         _loc10_.bitmapData = _loc8_;
         return _loc10_;
      }
      
      public static function obf_t_X_3506(param1:DisplayObject, param2:Boolean = true, param3:uint = 0, param4:Number = 1) : Vector.<BitmapFrameInfo>
      {
         var _loc5_:Vector.<BitmapFrameInfo> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:MovieClip = null;
         var _loc6_:MovieClip = param1 as MovieClip;
         if(_loc6_ == null)
         {
            _loc5_ = new Vector.<BitmapFrameInfo>(1,true);
            _loc5_[0] = cacheBitmap(param1,param2,param3,param4);
         }
         else
         {
            _loc7_ = 0;
            _loc8_ = _loc6_.totalFrames;
            _loc6_.gotoAndStop(1);
            _loc5_ = new Vector.<BitmapFrameInfo>(_loc8_,true);
            while(_loc7_ < _loc8_)
            {
               _loc5_[_loc7_] = cacheBitmap(_loc6_,param2,param3,param4);
               _loc9_ = searchChild(_loc6_,MovieClip);
               _loc6_.nextFrame();
               _loc10_ = 0;
               _loc11_ = int(_loc9_.length);
               while(_loc10_ < _loc11_)
               {
                  _loc12_ = _loc9_[_loc10_];
                  _loc12_.nextFrame();
                  _loc10_++;
               }
               _loc7_++;
            }
         }
         return _loc5_;
      }
      
      public static function obf_l_f_1865(param1:DisplayObject, param2:Boolean = true, param3:uint = 0) : Vector.<BitmapFrameInfo>
      {
         var _loc4_:int = 0;
         var _loc5_:int = 360;
         var _loc6_:Vector.<BitmapFrameInfo> = new Vector.<BitmapFrameInfo>(_loc5_,true);
         var _loc7_:DisplayObjectContainer = param1.parent;
         var _loc8_:Transform = param1.transform;
         var _loc9_:Sprite = new Sprite();
         _loc9_.addChild(param1);
         param1.x = 0;
         param1.y = 0;
         while(_loc4_ < _loc5_)
         {
            param1.rotation = _loc4_;
            _loc6_[_loc4_] = cacheBitmap(_loc9_,param2,param3);
            _loc4_++;
         }
         if(_loc7_ != null)
         {
            _loc7_.addChild(param1);
         }
         param1.transform = _loc8_;
         return _loc6_;
      }
      
      public static function cacheGridBitmap(param1:DisplayObject, param2:int, param3:int, param4:Boolean = true, param5:uint = 0, param6:Number = 1) : obf_0_1_E_79
      {
         var _loc15_:int = 0;
         var _loc16_:Array = null;
         var _loc17_:BitmapData = null;
         var _loc7_:Rectangle = param1.getBounds(param1);
         var _loc8_:int = (_loc7_.width + Math.round(_loc7_.x)) * param6;
         var _loc9_:int = (_loc7_.height + Math.round(_loc7_.y)) * param6;
         var _loc10_:int = Math.ceil(_loc9_ / param3);
         var _loc11_:int = Math.ceil(_loc8_ / param2);
         var _loc12_:int = 0;
         var _loc13_:Array = new Array(_loc10_);
         while(_loc12_ < _loc10_)
         {
            _loc15_ = 0;
            _loc16_ = new Array(_loc11_);
            _loc13_[_loc12_] = _loc16_;
            while(_loc15_ < _loc11_)
            {
               _loc17_ = new BitmapData(param2,param3,param4,param5);
               _loc17_.draw(param1,new Matrix(param6,0,0,param6,-param2 * _loc15_,-param3 * _loc12_),null,null,null,true);
               _loc16_[_loc15_] = _loc17_;
               _loc15_++;
            }
            _loc12_++;
         }
         var _loc14_:obf_0_1_E_79 = new obf_0_1_E_79();
         _loc14_.row = _loc10_;
         _loc14_.column = _loc11_;
         _loc14_.validWidth = _loc8_;
         _loc14_.validHeight = _loc9_;
         _loc14_.obf_3_G_1255 = param2;
         _loc14_.obf_k_m_4138 = param3;
         _loc14_.obf_G_t_3186 = _loc13_;
         return _loc14_;
      }
   }
}

