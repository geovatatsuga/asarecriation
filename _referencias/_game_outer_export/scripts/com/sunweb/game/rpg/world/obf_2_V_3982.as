package com.sunweb.game.rpg.world
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_2_V_3982
   {
      
      private static var obf_c_o_2644:Object;
      
      private static var _trainerList:Array;
      
      public function obf_2_V_3982()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         obf_c_o_2644 = new Object();
         _trainerList = param1;
         for each(_loc2_ in param1)
         {
            obf_c_o_2644[_loc2_.code] = _loc2_;
         }
      }
      
      public static function getTrianerInfo(param1:String) : Object
      {
         return obf_c_o_2644[param1];
      }
      
      public static function getTrianerName(param1:String) : String
      {
         return JSONUtil.getStr(obf_c_o_2644,[param1,"name"]);
      }
      
      public static function getTrianerMode(param1:String) : String
      {
         return JSONUtil.getStr(obf_c_o_2644,[param1,"modelCode"]);
      }
      
      public static function getTrianerDefSkillCode(param1:String) : String
      {
         return JSONUtil.getStr(obf_c_o_2644,[param1,"defSkill"]);
      }
      
      public static function getAnimalIcon(param1:String) : String
      {
         return JSONUtil.getStr(obf_c_o_2644,[param1,"headCode"]);
      }
   }
}

