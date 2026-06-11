package com.sunweb.game.rpg.script
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_c_w_2239
   {
      
      private static var varConfig:Object;
      
      public function obf_c_w_2239()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         varConfig = param1;
      }
      
      public static function getVarAtPlace(param1:String) : String
      {
         return JSONUtil.getStr(varConfig,["varPlace",param1]);
      }
   }
}

