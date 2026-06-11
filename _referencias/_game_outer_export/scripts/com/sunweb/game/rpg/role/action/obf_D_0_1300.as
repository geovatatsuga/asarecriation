package com.sunweb.game.rpg.role.action
{
   import flash.geom.Point;
   
   public class obf_D_0_1300
   {
      
      private static var dirSuffixMap:Object;
      
      private static var dirNameMap:Object;
      
      public static const RIGHT:int = 0;
      
      public static const obf_J_j_3523:int = 1;
      
      public static const UP:int = 2;
      
      public static const obf_S_d_907:int = 3;
      
      public static const LEFT:int = 4;
      
      public static const obf_3_3_2145:int = 5;
      
      public static const DOWN:int = 6;
      
      public static const obf_m_g_3030:int = 7;
      
      public static const NONE:int = 8;
      
      private static var dirSuffixArray:Array = [obf_e_G_3911.RIGHT,obf_e_G_3911.obf_J_j_3523,obf_e_G_3911.UP,obf_e_G_3911.obf_S_d_907,obf_e_G_3911.LEFT,obf_e_G_3911.obf_3_3_2145,obf_e_G_3911.DOWN,obf_e_G_3911.obf_m_g_3030,obf_e_G_3911.NONE];
      
      private static var dirNameArray:Array = [obf_0_4_9_162.RIGHT,obf_0_4_9_162.obf_J_j_3523,obf_0_4_9_162.UP,obf_0_4_9_162.obf_S_d_907,obf_0_4_9_162.LEFT,obf_0_4_9_162.obf_3_3_2145,obf_0_4_9_162.DOWN,obf_0_4_9_162.obf_m_g_3030,obf_0_4_9_162.NONE];
      
      public function obf_D_0_1300()
      {
         super();
      }
      
      public static function getDirection(param1:Point, param2:Point, param3:int = 8) : int
      {
         if(!(param3 == 8 || param3 == 4 || param3 == 2))
         {
            return NONE;
         }
         var _loc4_:Point = param2.subtract(param1);
         var _loc5_:int = getAngle(_loc4_);
         return getDirectionByAngle(_loc5_,param3);
      }
      
      public static function directionToSuffix(param1:int) : String
      {
         return dirSuffixArray[param1];
      }
      
      public static function obf_5_k_4384(param1:String) : int
      {
         var _loc4_:int = 0;
         if(dirSuffixMap == null)
         {
            dirSuffixMap = new Object();
            _loc4_ = 0;
            while(_loc4_ < dirSuffixArray.length)
            {
               dirSuffixMap[dirSuffixArray[_loc4_]] = _loc4_;
               _loc4_++;
            }
         }
         var _loc2_:int = param1.lastIndexOf("_");
         var _loc3_:String = _loc2_ > -1 ? param1.substr(_loc2_) : "";
         return dirSuffixMap[_loc3_];
      }
      
      public static function directionToName(param1:int) : String
      {
         return dirNameArray[param1];
      }
      
      public static function nameToDirection(param1:String) : int
      {
         var _loc2_:int = 0;
         if(dirNameMap == null)
         {
            dirNameMap = new Object();
            _loc2_ = 0;
            while(_loc2_ < dirNameArray.length)
            {
               dirNameMap[dirNameArray[_loc2_]] = _loc2_;
               _loc2_++;
            }
         }
         return dirNameMap[param1];
      }
      
      public static function getAngle(param1:Point) : int
      {
         var _loc2_:Number = Math.atan2(param1.y,param1.x) * 180 / Math.PI;
         if(_loc2_ < 0)
         {
            _loc2_ += 360;
         }
         return Math.round(_loc2_);
      }
      
      public static function getAngle2(param1:Point, param2:Point) : int
      {
         var _loc3_:Point = param2.subtract(param1);
         return getAngle(_loc3_);
      }
      
      public static function getDirectionByAngle(param1:int, param2:int) : int
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         if(!(param2 == 8 || param2 == 4 || param2 == 2))
         {
            return NONE;
         }
         param1 = 360 - param1;
         var _loc3_:Number = 360 / param2;
         var _loc4_:Number = _loc3_ / 2;
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            _loc7_ = param1;
            _loc8_ = _loc3_ * _loc6_;
            if(_loc6_ == 0 && _loc7_ > 180)
            {
               _loc7_ -= 360;
            }
            if(Math.abs(_loc7_ - _loc8_) <= _loc4_)
            {
               _loc5_ = _loc6_ * (8 / param2);
               break;
            }
            _loc6_++;
         }
         return _loc5_;
      }
   }
}

