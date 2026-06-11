package com.sunweb.game.res
{
   import flash.events.Event;
   
   public class obf_J_Y_3494 extends Event
   {
      
      public static const obf_7_1_3649:String = "itemLoad";
      
      public static const obf_9_a_1908:String = "itemError";
      
      public static const PROGRESS:String = "progress";
      
      public static const COMPLETE:String = "complete";
      
      public var bytesLoaded:uint = 0;
      
      public var bytesTotal:uint = 0;
      
      public var itemsLoaded:int = 0;
      
      public var itemsError:int = 0;
      
      public var itemsTotal:int = 0;
      
      public var itemCurrent:Object = null;
      
      public var loadingPercent:Number;
      
      public function obf_J_Y_3494(param1:String)
      {
         super(param1);
      }
   }
}

