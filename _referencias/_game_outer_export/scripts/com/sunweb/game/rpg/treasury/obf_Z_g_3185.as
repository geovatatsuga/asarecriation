package com.sunweb.game.rpg.treasury
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Z_g_3185
   {
      
      private var award:Object;
      
      public function obf_Z_g_3185(param1:Object)
      {
         super();
         this.award = param1;
      }
      
      public function get type() : int
      {
         return JSONUtil.getInt(this.award,["type"]);
      }
      
      public function get items() : Object
      {
         return JSONUtil.getObject(this.award,["items"]);
      }
      
      public function get attr() : Object
      {
         return JSONUtil.getObject(this.award,["attr"]);
      }
      
      public function get gold() : int
      {
         return JSONUtil.getInt(this.award,["gold"]);
      }
      
      public function get coin() : int
      {
         return JSONUtil.getInt(this.award,["coin"]);
      }
   }
}

