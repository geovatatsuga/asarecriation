package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.BuffIconUIMC;
   
   public class BuffIconUI extends BuffIconUIMC
   {
      
      private var obf_t_V_2149:int;
      
      private var obf_x_Z_749:TimeLimiter;
      
      private var obf_E_r_3123:Boolean;
      
      private var obf_F_l_896:TimeLimiter = new TimeLimiter(500);
      
      public function BuffIconUI(param1:BuffInfo, param2:Boolean = false)
      {
         super();
         this.obf_t_V_2149 = param1.buffId;
         this.obf_x_Z_749 = new TimeLimiter(param1.getDurationTimeInMS());
         this.obf_E_r_3123 = param1.durationInSec < 0;
         txtTime.mouseEnabled = false;
         buffIconPoint.addChild(BuffManager.getBuffIcon(this.obf_t_V_2149));
         if(param2)
         {
            buffIconPoint.scaleX = 0.5;
            buffIconPoint.scaleY = 0.5;
            txtTime.visible = false;
            this.removeChild(txtTime);
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         BuffManager.showBuffTip(this.obf_t_V_2149);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         GameTipManager.closeTip("Buff");
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.obf_F_l_896.checkTimeout() || !txtTime.visible)
         {
            return;
         }
         if(this.obf_E_r_3123)
         {
            txtTime.textColor = 16777215;
            txtTime.text = "N / A";
            return;
         }
         if(this.obf_x_Z_749)
         {
            txtTime.text = obf_l_y_733.getTimeStringHHMMSS(this.obf_x_Z_749.timelimit - this.obf_x_Z_749.totalTimeInMS);
         }
         if(this.obf_x_Z_749.timelimit - this.obf_x_Z_749.totalTimeInMS < 30000)
         {
            if(txtTime.textColor != 16711680)
            {
               txtTime.textColor = 16711680;
            }
            else
            {
               txtTime.textColor = 16777215;
            }
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
         var _loc1_:Rectangle = new Rectangle(0,0,this.width,this.height);
         if(_loc1_.contains(this.mouseX,this.mouseY))
         {
            GameTipManager.closeTip("Buff");
         }
      }
   }
}

