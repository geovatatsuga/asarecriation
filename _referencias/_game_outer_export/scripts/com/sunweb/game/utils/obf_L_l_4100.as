package com.sunweb.game.utils
{
   public class obf_L_l_4100
   {
      
      public function obf_L_l_4100()
      {
         super();
      }
      
      public static function getResLibStringByResID(param1:String) : String
      {
         return param1.split("@").reverse()[0];
      }
      
      public static function checkNameString(param1:String) : Boolean
      {
         return !obf_S_7_2498(param1,"　~`!@#$%^&*()+-={}[]|\\;:\"\',.<>/? ");
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         return param1 == null || param1 == "";
      }
      
      public static function obf_I_C_3435(param1:String) : String
      {
         param1 = param1.replace(/^\s*/g,"");
         param1 = param1.replace(/\s*$/g,"");
         return param1.replace(/(  +)/g," ");
      }
      
      public static function autoNumber(param1:String, param2:int = -1) : String
      {
         if(param1 == null || param1 == "")
         {
            return "1";
         }
         if(param2 == -1)
         {
            param2 = int(param1.length - 1);
         }
         var _loc3_:String = "";
         var _loc4_:int = param1.length;
         var _loc5_:int = param1.charCodeAt(param2) + 1;
         if(_loc4_ == 0)
         {
            return "";
         }
         if(param2 == 0)
         {
            if(48 < _loc5_ && _loc5_ <= 57)
            {
               _loc3_ = param1.substring(0,param2) + String.fromCharCode(_loc5_) + param1.substring(param2 + 1,_loc4_);
            }
            else if(_loc5_ == 58)
            {
               _loc3_ = "10" + param1.substring(param2 + 1,_loc4_);
            }
            else if(65 < _loc5_ && _loc5_ <= 90)
            {
               _loc3_ = param1.substring(0,param2) + String.fromCharCode(_loc5_) + param1.substring(param2 + 1,_loc4_);
            }
            else if(_loc5_ == 91)
            {
               _loc3_ = "AA" + param1.substring(param2 + 1,_loc4_);
            }
            else if(97 < _loc5_ && _loc5_ <= 122)
            {
               _loc3_ = param1.substring(0,param2) + String.fromCharCode(_loc5_) + param1.substring(param2 + 1,_loc4_);
            }
            else if(_loc5_ == 123)
            {
               _loc3_ = "aa" + param1.substring(param2 + 1,_loc4_);
            }
         }
         else if(48 < _loc5_ && _loc5_ <= 57 || 65 < _loc5_ && _loc5_ <= 90 || 97 < _loc5_ && _loc5_ <= 122)
         {
            _loc3_ = param1.substring(0,param2) + String.fromCharCode(_loc5_) + param1.substring(param2 + 1,_loc4_);
         }
         else
         {
            param2--;
            if(_loc5_ == 58)
            {
               return autoNumber(param1.substring(0,param2 + 1) + "0" + param1.substring(param2 + 2,_loc4_),param2);
            }
            if(_loc5_ == 91)
            {
               return autoNumber(param1.substring(0,param2 + 1) + "A" + param1.substring(param2 + 2,_loc4_),param2);
            }
            if(_loc5_ == 123)
            {
               return autoNumber(param1.substring(0,param2 + 1) + "a" + param1.substring(param2 + 2,_loc4_),param2);
            }
         }
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         return "";
      }
      
      public static function obf_x_2_3800(param1:String, param2:int) : String
      {
         if(param2 <= 0)
         {
            return "";
         }
         var _loc3_:String = "";
         var _loc4_:int = Math.floor(param2 / param1.length);
         var _loc5_:int = param2 % param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ += param1;
            _loc6_++;
         }
         return _loc3_ + param1.substring(0,_loc5_);
      }
      
      public static function repeat(param1:String, param2:int) : String
      {
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param2)
         {
            _loc3_ += param1;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function obf_1_m_1767(param1:String, param2:int, param3:String) : String
      {
         return obf_x_2_3800(param3,param2 - param1.length) + param1;
      }
      
      public static function obf_L_2_2226(param1:String, param2:int, param3:String) : String
      {
         return param1 + obf_x_2_3800(param3,param2 - param1.length);
      }
      
      public static function obf_6_d_4028(param1:String, param2:String) : Boolean
      {
         if(param2 == null || param2 == "")
         {
            return false;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param2.indexOf(param1.charAt(_loc3_)) < 0)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function obf_S_7_2498(param1:String, param2:String) : Boolean
      {
         if(param2 == null || param2 == "")
         {
            return true;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            if(param1.indexOf(param2.charAt(_loc3_)) > -1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function obf_r_1236(param1:String) : String
      {
         param1 = param1.replace(/&/g,"&#38;");
         param1 = param1.replace(/</g,"&lt;");
         param1 = param1.replace(/>/g,"&gt;");
         param1 = param1.replace(/\r\n/g,"<br>");
         param1 = param1.replace(/\r/g,"<br>");
         return param1.replace(/\n/g,"<br>");
      }
   }
}

