package com.sunweb.game.rpg.treasury
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_t_8_2995
   {
      
      private var config:Object;
      
      public function obf_t_8_2995(param1:Object)
      {
         super();
         this.config = param1;
      }
      
      public function get name() : String
      {
         return JSONUtil.getStr(this.config,["name"]);
      }
      
      public function get freeNum() : int
      {
         return JSONUtil.getInt(this.config,["freeNum"]);
      }
      
      public function get itemCode() : String
      {
         return JSONUtil.getStr(this.config,["itemCode"]);
      }
      
      public function get awards() : Array
      {
         var _loc4_:Object = null;
         var _loc1_:Array = JSONUtil.getValue(this.config,["awards"]) as Array;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(_loc4_)
            {
               _loc2_.push(new obf_Z_g_3185(_loc4_));
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get levelAttr() : Array
      {
         return JSONUtil.getValue(this.config,["levelAttr"]) as Array;
      }
      
      public function get levelExp() : Array
      {
         return JSONUtil.getValue(this.config,["levelExp"]) as Array;
      }
      
      public function get maxAttr() : Object
      {
         return JSONUtil.getObject(this.config,["maxAttr"]);
      }
   }
}

