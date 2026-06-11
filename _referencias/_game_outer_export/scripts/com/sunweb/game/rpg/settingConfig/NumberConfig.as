package com.sunweb.game.rpg.settingConfig
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class NumberConfig
   {
      
      private static var numObj:Object;
      
      public function NumberConfig()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         numObj = param1;
      }
      
      public static function getPlayerLevelExpGemValue(param1:int) : int
      {
         return param1 < 1 || param1 > numObj.roleLevelUpExp.length ? 0 : int(numObj.roleExpUnit[param1 - 1]);
      }
      
      public static function getPlayerLevelGoldGemValue(param1:int) : int
      {
         return JSONUtil.getInt(numObj,["roleGoldUnit",param1 - 1]);
      }
      
      public static function getPlayerLevelNumber(param1:int) : uint
      {
         return param1 < 1 || param1 > numObj.roleLevelUpExp.length ? 0 : uint(numObj.roleLevelUpExp[param1 - 1]);
      }
      
      public static function getSkillLevelNumber(param1:int) : int
      {
         return param1 < 1 || param1 > numObj.skillLevelUpExp.length ? 0 : int(numObj.skillLevelUpExp[param1 - 1]);
      }
      
      public static function getLifeJobLevelNumber(param1:int) : int
      {
         return param1 < 1 || param1 > numObj.lifeLevelUpExp.length ? 0 : int(numObj.lifeLevelUpExp[param1 - 1]);
      }
      
      public static function getHonorLevelUpValue(param1:int) : int
      {
         var _loc2_:int = JSONUtil.getInt(numObj,["honorLevelValues",param1]);
         var _loc3_:int = JSONUtil.getInt(numObj,["honorLevelValues",param1 + 1]);
         return Math.max(0,_loc3_ - _loc2_);
      }
      
      public static function getHonorLevelName(param1:int) : String
      {
         return JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[param1]);
      }
      
      public static function getValue(... rest) : *
      {
         return JSONUtil.getObject(numObj,rest);
      }
      
      public static function getSettingObject(param1:String) : *
      {
         return numObj[param1];
      }
   }
}

