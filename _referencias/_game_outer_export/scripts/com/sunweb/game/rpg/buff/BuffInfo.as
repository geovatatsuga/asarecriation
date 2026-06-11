package com.sunweb.game.rpg.buff
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import flash.utils.getTimer;
   
   public class BuffInfo extends obf_2_M_853
   {
      
      private var checkTime:int;
      
      public var buffId:int;
      
      public var durationInSec:int;
      
      public function BuffInfo()
      {
         super();
         this.checkTime = getTimer();
      }
      
      public function getDurationTimeInMS() : int
      {
         return this.durationInSec * 1000 - (getTimer() - this.checkTime);
      }
      
      public function get buffConfig() : Object
      {
         return BuffManager.getBuffConfigById(this.buffId);
      }
      
      override public function getFieldList() : Array
      {
         return ["buffId:ushort","durationInSec:vint"];
      }
   }
}

