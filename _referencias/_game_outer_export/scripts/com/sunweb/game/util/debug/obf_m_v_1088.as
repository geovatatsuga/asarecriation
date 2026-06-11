package com.sunweb.game.util.debug
{
   import flash.events.Event;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class obf_m_v_1088 extends TextField
   {
      
      private var ms:int;
      
      public function obf_m_v_1088()
      {
         super();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 16711680;
         _loc1_.size = 12;
         _loc1_.bold = true;
         _loc1_.font = "Verdana";
         textColor = 13553358;
         autoSize = "left";
         defaultTextFormat = _loc1_;
         this.ms = getTimer();
         addEventListener(Event.ADDED_TO_STAGE,this.obf_y_v_2029);
         addEventListener(Event.REMOVED_FROM_STAGE,this.obf_q_m_1513);
      }
      
      private function obf_y_v_2029(param1:Event) : void
      {
         stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function obf_q_m_1513(param1:Event) : void
      {
         stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(getTimer() - 250 > this.ms)
         {
            this.ms = getTimer();
            _loc2_ = System.totalMemory;
            _loc3_ = _loc2_ / 1024;
            _loc4_ = _loc3_ / 1024;
            text = "mem: " + _loc4_.toFixed(3) + "(mb)";
         }
      }
   }
}

