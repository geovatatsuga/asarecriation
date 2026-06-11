package obf_k_F_2870
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class obf_1_4637 extends Sprite
   {
      
      private static var end_p:Point;
      
      private static var openArray:Array;
      
      private static var closeArray:Array;
      
      private static var mapPhy:MapPhysics;
      
      private static var pointArray:Array;
      
      private static var obf_s_E_2345:Boolean;
      
      public static var obf_0_7_F_183:int = 1;
      
      public static var getDis:int = 1;
      
      public static var poiDis:int = 1;
      
      public static var timeout:int = 1000;
      
      public function obf_1_4637()
      {
         super();
      }
      
      private static function initPoint() : void
      {
         var _loc4_:Point = null;
         var _loc1_:Array = new Array(0,0,-getDis,getDis,-getDis,-getDis,getDis,getDis);
         var _loc2_:Array = new Array(-getDis,getDis,0,0,-getDis,getDis,-getDis,getDis);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = new Point(_loc1_[_loc3_],_loc2_[_loc3_]);
            pointArray.push(_loc4_);
            _loc3_++;
         }
      }
      
      public static function reset() : void
      {
         mapPhy = null;
      }
      
      public static function startFind(param1:Point, param2:Point, param3:MapPhysics) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:Array = new Array();
         mapPhy = param3;
         param1.x = Math.round(param1.x);
         param1.y = Math.round(param1.y);
         param2.x = Math.round(param2.x);
         param2.y = Math.round(param2.y);
         if(!mapPhy.checkPass(param2.x,param2.y))
         {
            param2 = obf_l_6_3809(param1,param2);
         }
         _loc4_ = obf_N_w_2712(param1,param2,param3);
         if(obf_s_E_2345)
         {
            return _loc4_;
         }
         if(_loc4_.length == 0)
         {
            trace("#######obf_______1728");
            return _loc5_;
         }
         _loc4_ = obf_N_w_2712(param2,param1,param3);
         if(obf_s_E_2345)
         {
            _loc4_.reverse();
            return _loc4_;
         }
         if(_loc4_.length == 0)
         {
            trace("#######obf_______1244");
            return _loc5_;
         }
         trace("#######obf_______3821");
         return _loc5_;
      }
      
      private static function obf_N_w_2712(param1:Point, param2:Point, param3:MapPhysics) : *
      {
         var _loc4_:Number = NaN;
         var _loc7_:MyPoint = null;
         var _loc10_:MyPoint = null;
         var _loc13_:int = 0;
         var _loc14_:Point = null;
         var _loc15_:MyPoint = null;
         openArray = new Array();
         closeArray = new Array();
         pointArray = new Array();
         param1.x = Math.round(param1.x);
         param1.y = Math.round(param1.y);
         param2.x = Math.round(param2.x);
         param2.y = Math.round(param2.y);
         end_p = param2;
         mapPhy = param3;
         initPoint();
         var _loc5_:int = 1;
         var _loc6_:Dictionary = new Dictionary();
         obf_s_E_2345 = false;
         var _loc8_:Array = new Array();
         var _loc9_:Number = 0;
         var _loc11_:int = 0;
         var _loc12_:int = timeout;
         _loc7_ = new MyPoint(param1,0,_loc5_);
         closeArray.push(_loc7_);
         _loc5_++;
         _loc11_ = getTimer();
         while(!obf_s_E_2345)
         {
            _loc13_ = 0;
            while(_loc13_ < pointArray.length)
            {
               _loc14_ = _loc7_.subtract(pointArray[_loc13_]);
               _loc9_ = _loc13_ >= 4 ? _loc7_.G_num + 14 : _loc7_.G_num + 10;
               if(_loc6_[String(_loc14_.x) + String(_loc14_.y)] == undefined)
               {
                  if(isPass(_loc14_,obf_0_7_F_183))
                  {
                     _loc10_ = new MyPoint(_loc14_,_loc7_.id_num,_loc5_);
                     _loc5_++;
                     _loc6_[String(_loc14_.x) + String(_loc14_.y)] = _loc10_;
                     _loc10_.G_num = _loc9_;
                     _loc10_.in_open = true;
                     _loc10_.H_num = 10 * (Math.abs(_loc10_.x - end_p.x) + Math.abs(_loc10_.y - end_p.y));
                     _loc10_.F_num = _loc10_.H_num + _loc10_.G_num;
                     obf_0___r_77(_loc10_);
                  }
               }
               else if(!_loc6_[String(_loc14_.x) + String(_loc14_.y)].in_close)
               {
                  if(_loc9_ < _loc6_[String(_loc14_.x) + String(_loc14_.y)].G_num)
                  {
                     _loc10_ = _loc6_[String(_loc14_.x) + String(_loc14_.y)];
                     _loc4_ = obf_Z_o_3642(_loc10_);
                     openArray.splice(_loc4_,1);
                     _loc10_.G_num = _loc9_;
                     _loc10_.prent_id = _loc7_.id_num;
                     _loc10_.H_num = 10 * (Math.abs(_loc10_.x - end_p.x) + Math.abs(_loc10_.y - end_p.y));
                     _loc10_.F_num = _loc10_.H_num + _loc10_.G_num;
                     obf_0___r_77(_loc10_);
                  }
               }
               if(obf_n_X_3655(_loc14_,end_p) < obf_0_7_F_183)
               {
                  obf_s_E_2345 = true;
                  break;
               }
               _loc13_++;
            }
            if(obf_s_E_2345)
            {
               _loc15_ = new MyPoint(end_p,_loc7_.id_num,_loc5_);
               closeArray.push(_loc15_);
               return getPath();
            }
            if(!(openArray.length > 0 && getTimer() - _loc11_ < _loc12_))
            {
               return openArray;
            }
            _loc7_ = openArray.shift();
            closeArray.push(_loc7_);
            _loc7_.in_close = true;
         }
      }
      
      private static function obf_Z_o_3642(param1:MyPoint) : *
      {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < openArray.length)
         {
            if(openArray[_loc2_].F_num > param1.F_num)
            {
               _loc3_ = _loc2_;
               while(_loc3_ >= 0)
               {
                  if(openArray[_loc3_].equals(param1))
                  {
                     return _loc3_;
                  }
                  _loc3_--;
               }
            }
            _loc2_ += 4;
         }
      }
      
      private static function obf_0___r_77(param1:MyPoint) : void
      {
         var _loc2_:int = 0;
         if(openArray.length != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < openArray.length)
            {
               if(param1.F_num <= openArray[_loc2_].F_num)
               {
                  openArray.splice(_loc2_,0,param1);
                  return;
               }
               _loc2_ += 3;
            }
            openArray.push(param1);
         }
         else
         {
            openArray.push(param1);
         }
      }
      
      private static function getPath() : Array
      {
         var _loc4_:* = 0;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         _loc1_.unshift(closeArray[closeArray.length - 1]);
         while(_loc1_[0].prent_id != 0)
         {
            _loc4_ = int(closeArray.length - 1);
            while(_loc4_ >= 0)
            {
               if(_loc1_[0].prent_id == closeArray[_loc4_].id_num)
               {
                  _loc1_.unshift(closeArray[_loc4_]);
                  closeArray.splice(_loc4_,1);
                  break;
               }
               _loc4_--;
            }
         }
         if(!isPass(_loc1_[_loc1_.length - 1],obf_0_7_F_183))
         {
            _loc1_.pop();
            end_p = _loc1_[_loc1_.length - 1];
         }
         _loc2_ = obf_x_W_927(_loc1_);
         if(_loc2_ == null)
         {
            return _loc3_;
         }
         return obf_x_W_927(_loc2_);
      }
      
      private static function isPass(param1:Point, param2:Number) : Boolean
      {
         if(mapPhy.checkPass(param1.x - param2,param1.y) && mapPhy.checkPass(param1.x + param2,param1.y) && mapPhy.checkPass(param1.x,param1.y - param2) && mapPhy.checkPass(param1.x,param1.y + param2))
         {
            return true;
         }
         return false;
      }
      
      private static function obf_x_W_927(param1:Array) : *
      {
         var _loc2_:MyPoint = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Point = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1.length > 0)
         {
            _loc3_ = new Array();
            _loc4_ = new Array();
            _loc6_ = false;
            _loc2_ = param1[0];
            _loc4_.push(_loc2_);
            _loc5_ = param1[1].subtract(_loc2_);
            _loc7_ = 1;
            while(_loc7_ <= param1.length - 1)
            {
               if(!_loc6_ && !_loc5_.add(param1[_loc7_ - 1]).equals(param1[_loc7_]))
               {
                  _loc6_ = true;
               }
               if(_loc6_)
               {
                  _loc3_ = getTeam(_loc2_,param1[_loc7_]);
                  _loc8_ = 0;
                  while(_loc8_ < _loc3_.length - 1)
                  {
                     if(!isPass(_loc3_[_loc8_],poiDis / 2))
                     {
                        _loc6_ = false;
                        _loc2_ = param1[_loc7_ - 1];
                        _loc5_ = param1[_loc7_].subtract(_loc2_);
                        _loc4_.push(_loc2_);
                        break;
                     }
                     _loc8_++;
                  }
               }
               _loc7_++;
            }
         }
         if(!_loc4_[_loc4_.length - 1].equals(end_p))
         {
            _loc4_.push(end_p);
            return _loc4_;
         }
      }
      
      private static function getTeam(param1:Point, param2:Point) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:Point = param2.subtract(param1);
         var _loc5_:Number = obf_n_X_3655(param1,param2);
         _loc4_ = new Point(Math.round(poiDis * _loc4_.x / _loc5_ * 100) / 100,Math.round(poiDis * _loc4_.y / _loc5_ * 100) / 100);
         _loc3_.push(param1.add(_loc4_));
         while(obf_n_X_3655(param1,_loc3_[_loc3_.length - 1]) < _loc5_)
         {
            _loc3_.push(_loc3_[_loc3_.length - 1].add(_loc4_));
         }
         return _loc3_;
      }
      
      private static function obf_n_X_3655(param1:Point, param2:Point) : Number
      {
         var _loc3_:Point = param2.subtract(param1);
         return Math.abs(Math.round(Math.sqrt(_loc3_.x * _loc3_.x + _loc3_.y * _loc3_.y)));
      }
      
      private static function obf_l_6_3809(param1:Point, param2:Point) : Point
      {
         var _loc3_:Array = getTeam(param1,param2);
         var _loc4_:* = int(_loc3_.length - 1);
         while(_loc4_ >= 0)
         {
            if(isPass(_loc3_[_loc4_],obf_0_7_F_183))
            {
               return _loc3_[_loc4_];
            }
            _loc4_--;
         }
         return param1;
      }
   }
}

