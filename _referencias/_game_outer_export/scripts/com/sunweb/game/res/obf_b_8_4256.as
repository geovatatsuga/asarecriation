package com.sunweb.game.res
{
   public class obf_b_8_4256
   {
      
      public static const obf_P_O_2085:String = "url:";
      
      private static var _urdCache:Object = new Object();
      
      private static var obf_Y_Y_3176:obf_b_8_4256 = new obf_b_8_4256();
      
      public var type:int = 0;
      
      public var name:String = null;
      
      public var url:String = null;
      
      public var lib:String = null;
      
      public var dir:String = null;
      
      private var _resId:String = null;
      
      public function obf_b_8_4256(param1:String = null)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         if(param1.charAt(0) == "@")
         {
            param1 = param1.substr(1);
         }
         if(param1 == "")
         {
            return;
         }
         if(param1.indexOf(obf_P_O_2085) == 0)
         {
            this.type = obf_g_I_3092.obf_0_8_v_318;
            this.url = param1.substr(4);
            _loc2_ = this.url.lastIndexOf("/");
            if(_loc2_ < 0)
            {
               this.name = param1;
            }
            else
            {
               this.name = this.url.substr(_loc2_ + 1);
            }
            this._resId = param1;
         }
         else
         {
            _loc3_ = param1.indexOf("@");
            if(_loc3_ < 0)
            {
               _loc4_ = param1.lastIndexOf("/");
               if(_loc4_ < 0)
               {
                  this.type = obf_g_I_3092.obf_X_F_4583;
                  this.name = param1;
                  this._resId = param1;
               }
               else
               {
                  this.type = obf_g_I_3092.obf_z_u_4101;
                  this.dir = param1.substring(0,_loc4_);
                  this.name = param1.substr(_loc4_ + 1);
                  this._resId = param1;
               }
            }
            else
            {
               this.type = obf_g_I_3092.obf_0_8_K_597;
               this.name = param1.substring(0,_loc3_);
               this.lib = param1.substr(_loc3_ + 1);
               this._resId = this.lib;
            }
         }
      }
      
      public static function getUrdReadonly(param1:String) : obf_b_8_4256
      {
         if(param1 == null)
         {
            return obf_Y_Y_3176;
         }
         var _loc2_:obf_b_8_4256 = _urdCache[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new obf_b_8_4256(param1);
            _urdCache[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public static function getResIdToImport(param1:String) : String
      {
         return getUrdReadonly(param1).resIdToImport;
      }
      
      public function toString() : String
      {
         if(this.url == null || this.url == "")
         {
            if(this.lib == null || this.lib == "")
            {
               if(this.dir == null || this.dir == "")
               {
                  return this.name;
               }
               return this.dir + "/" + this.name;
            }
            return this.name + "@" + this.lib;
         }
         return obf_P_O_2085 + this.url;
      }
      
      public function get resIdToImport() : String
      {
         return this._resId;
      }
   }
}

