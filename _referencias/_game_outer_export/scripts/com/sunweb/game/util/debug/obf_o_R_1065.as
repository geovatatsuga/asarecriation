package com.sunweb.game.util.debug
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class obf_o_R_1065 extends TextField
   {
      
      private var obf_a_e_1735:int;
      
      private var ms:int;
      
      public function obf_o_R_1065()
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
         this.obf_a_e_1735 = 0;
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
         if(getTimer() - 1000 > this.ms)
         {
            this.ms = getTimer();
            text = "fps: " + this.obf_a_e_1735.toString();
            this.obf_a_e_1735 = 0;
         }
         else
         {
            ++this.obf_a_e_1735;
         }
      }
   }
}

