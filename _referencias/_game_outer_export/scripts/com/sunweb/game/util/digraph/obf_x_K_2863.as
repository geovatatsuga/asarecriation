package com.sunweb.game.util.digraph
{
   public class obf_x_K_2863
   {
      
      private static const obf_f_o_r_4648:int = 100;
      
      private static const obf_0_6_D_377:int = 1000;
      
      private static const obf_D_l_2316:int = -1;
      
      public function obf_x_K_2863()
      {
         super();
      }
      
      public static function getShortedPath(param1:Array, param2:int, param3:int, param4:int) : Object
      {
         var _loc6_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc5_:Array = new Array();
         var _loc7_:int = 0;
         var _loc8_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc10_:Array = new Array();
         var _loc11_:int = 0;
         while(_loc11_ < param4)
         {
            _loc5_[_loc11_] = false;
            _loc8_[_loc11_] = param1[param2][_loc11_];
            if(_loc8_[_loc11_] > obf_0_6_D_377)
            {
               _loc9_[_loc11_] = obf_D_l_2316;
            }
            else
            {
               _loc9_[_loc11_] = param2;
            }
            _loc11_++;
         }
         _loc10_[0] = param3;
         _loc8_[param2] = 0;
         _loc5_[param2] = true;
         var _loc12_:int = 1;
         while(_loc12_ < param4)
         {
            _loc6_ = obf_0_6_D_377;
            _loc16_ = 0;
            while(_loc16_ < param4)
            {
               if(!_loc5_[_loc16_] && _loc8_[_loc16_] < _loc6_)
               {
                  _loc7_ = _loc16_;
                  _loc6_ = int(_loc8_[_loc16_]);
               }
               _loc16_++;
            }
            _loc5_[_loc7_] = true;
            _loc17_ = 0;
            while(_loc17_ < param4)
            {
               if(!_loc5_[_loc17_] && _loc6_ + param1[_loc7_][_loc17_] < _loc8_[_loc17_])
               {
                  _loc8_[_loc17_] = _loc6_ + param1[_loc7_][_loc17_];
                  _loc9_[_loc17_] = _loc7_;
               }
               _loc17_++;
            }
            _loc12_++;
         }
         var _loc13_:int = param3;
         var _loc14_:int = 0;
         while(_loc13_ != param2)
         {
            _loc14_++;
            _loc10_[_loc14_] = _loc9_[_loc13_];
            _loc13_ = int(_loc9_[_loc13_]);
            if(_loc13_ == obf_D_l_2316 || _loc14_ >= obf_f_o_r_4648)
            {
               return {
                  "dist":int.MAX_VALUE,
                  "path":[]
               };
            }
         }
         var _loc15_:* = _loc14_;
         while(_loc15_ > _loc14_ / 2)
         {
            _loc18_ = int(_loc10_[_loc14_ - _loc15_]);
            _loc10_[_loc14_ - _loc15_] = _loc10_[_loc15_];
            _loc10_[_loc15_] = _loc18_;
            _loc15_--;
         }
         return {
            "dist":_loc8_[param3],
            "path":_loc10_
         };
      }
   }
}

