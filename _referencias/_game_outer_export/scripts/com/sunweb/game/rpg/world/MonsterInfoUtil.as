package com.sunweb.game.rpg.world
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class MonsterInfoUtil
   {
      
      private static var _monsterInfo:Object;
      
      private static var _monsterList:Array;
      
      public function MonsterInfoUtil()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         _monsterInfo = new Object();
         _monsterList = param1;
         for each(_loc2_ in param1)
         {
            _monsterInfo[_loc2_.code] = _loc2_;
         }
      }
      
      public static function getMonsterInfo(param1:String) : Object
      {
         return _monsterInfo[param1];
      }
      
      public static function getMonsterName(param1:String) : String
      {
         return JSONUtil.getStr(_monsterInfo,[param1,"name"]);
      }
   }
}

