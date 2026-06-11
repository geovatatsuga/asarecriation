package com.sunweb.game.rpg.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class PeriodCounterItemInfo extends obf_2_M_853
   {
      
      public var itemFlag:String;
      
      public var numOfDay:int;
      
      public var numOfWeek:int;
      
      public var numOfMonth:int;
      
      public function PeriodCounterItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["itemFlag:string","numOfDay:ushort","numOfWeek:ushort","numOfMonth:ushort"];
      }
   }
}

