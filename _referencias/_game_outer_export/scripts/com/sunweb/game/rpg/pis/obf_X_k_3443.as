package com.sunweb.game.rpg.pis
{
   public class obf_X_k_3443
   {
      
      public function obf_X_k_3443()
      {
         super();
      }
      
      public static function isValidDate(param1:*, param2:*, param3:*) : Boolean
      {
         var _loc4_:* = undefined;
         if(param2 == 2)
         {
            _loc4_ = param3 % 4 == 0 && (param3 % 100 != 0 || param3 % 400 == 0);
            if(param1 > 29 || param1 == 29 && !_loc4_)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function obf_l_R_1492(param1:String) : Boolean
      {
         var _loc2_:Array = [1,0,"x",9,8,7,6,5,4,3,2];
         var _loc3_:Array = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2];
         var _loc4_:Array = [1,9,8,7,6,5,4,3,2,1,1];
         if(param1.length != 15 && param1.length != 18)
         {
            return false;
         }
         var _loc5_:String = param1.length == 18 ? param1.substring(0,17) : param1.slice(0,6) + "19" + param1.slice(6,16);
         if(!/^\d+$/.test(_loc5_))
         {
            return false;
         }
         var _loc6_:int = int(_loc5_.slice(6,10));
         var _loc7_:int = int(_loc5_.slice(10,12)) - 1;
         var _loc8_:int = int(_loc5_.slice(12,14));
         var _loc9_:Date = new Date(_loc6_,_loc7_,_loc8_);
         var _loc10_:int = _loc9_.getFullYear();
         var _loc11_:int = _loc9_.getMonth();
         var _loc12_:int = _loc9_.getDate();
         var _loc13_:Date = new Date();
         if(_loc10_ != _loc6_ || _loc11_ != _loc7_ || _loc12_ != _loc8_ || _loc9_ > _loc13_ || _loc13_.getFullYear() - _loc10_ > 110 || !isValidDate(_loc8_,_loc7_,_loc6_))
         {
            return false;
         }
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         while(_loc15_ < 17)
         {
            _loc14_ += int(_loc5_.charAt(_loc15_)) * _loc3_[_loc15_];
            _loc15_++;
         }
         _loc5_ += _loc2_[_loc14_ = _loc14_ % 11];
         return param1.length == 18 && param1.toLowerCase() == _loc5_;
      }
   }
}

