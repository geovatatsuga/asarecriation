package com.sunweb.game.util
{
   import flash.utils.getTimer;
   
   public class TimeLimiter
   {
      
      public var timelimit:int;
      
      public var startTime:int;
      
      public var obf_Z_s_1070:int;
      
      public var lastCheckedInterval:int;
      
      public function TimeLimiter(param1:int)
      {
         super();
         this.timelimit = param1;
         this.startTime = this.obf_Z_s_1070 = getTimer();
         this.lastCheckedInterval = 0;
      }
      
      public function checkTimeout(param1:Boolean = false) : Boolean
      {
         var _loc2_:int = getTimer();
         this.lastCheckedInterval = _loc2_ - this.obf_Z_s_1070;
         if(this.lastCheckedInterval < this.timelimit)
         {
            return false;
         }
         if(!param1)
         {
            this.obf_Z_s_1070 = _loc2_;
         }
         return true;
      }
      
      public function restartTime() : void
      {
         this.obf_Z_s_1070 = getTimer();
         this.lastCheckedInterval = 0;
      }
      
      public function get totalTimeInMS() : int
      {
         return getTimer() - this.startTime;
      }
   }
}

