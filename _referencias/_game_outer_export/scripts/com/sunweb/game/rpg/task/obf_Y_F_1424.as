package com.sunweb.game.rpg.task
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Y_F_1424
   {
      
      private static var counterObject:Object;
      
      public function obf_Y_F_1424()
      {
         super();
      }
      
      public static function setCounterMap(param1:Array) : void
      {
         var _loc2_:PeriodCounterItemInfo = null;
         counterObject = new Object();
         for each(_loc2_ in param1)
         {
            if(_loc2_)
            {
               counterObject[_loc2_.itemFlag] = _loc2_;
            }
         }
      }
      
      public static function setOneCounter(param1:PeriodCounterItemInfo) : void
      {
         if(!counterObject)
         {
            return;
         }
         counterObject[param1.itemFlag] = param1;
      }
      
      public static function getCounter(param1:String) : PeriodCounterItemInfo
      {
         return JSONUtil.getObject(counterObject,[param1]) as PeriodCounterItemInfo;
      }
   }
}

