package com.sunweb.game.rpg.playerUI.systems
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import playerUI.SystemInfoUIMC;
   
   public class obf_2_5_1204 extends SystemInfoUIMC
   {
      
      private var obf_u_b_993:Array = new Array();
      
      private var fixedMsg:Array = new Array();
      
      private var fixedTimeInv:TimeLimiter;
      
      private var showTime:int;
      
      public function obf_2_5_1204()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         var _loc1_:TextField = sysBox.txtSystem;
         var _loc2_:MovieClip = sysBox.maskBox;
         _loc1_.cacheAsBitmap = true;
         sysBox.cacheAsBitmap = true;
         _loc1_.mask = _loc2_;
         this.addListener();
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.setSystemInfo();
         this.setTipInfo();
         this.setFixedInfo();
      }
      
      private function setFixedInfo() : void
      {
         if(!this.fixedTimeInv || this.fixedTimeInv.checkTimeout())
         {
            if(this.fixedMsg.length > 0)
            {
               txtMsgTip.htmlText = this.fixedMsg.shift() as String;
               txtMsgTip.visible = true;
               this.fixedTimeInv = new TimeLimiter(10000);
            }
            else
            {
               this.fixedTimeInv = null;
               if(txtMsgTip.text != "")
               {
                  txtMsgTip.text = "";
                  txtMsgTip.visible = false;
               }
            }
         }
      }
      
      private function setSystemInfo() : void
      {
         var _loc1_:TextField = sysBox.txtSystem;
         if(_loc1_.text == "" && this.obf_u_b_993.length > 0)
         {
            _loc1_.htmlText = this.obf_u_b_993.shift() as String;
            _loc1_.width = _loc1_.textWidth + 4;
            this.showTime = getTimer();
         }
         var _loc2_:int = 80;
         if(_loc1_.text != "")
         {
            _loc1_.x -= (getTimer() - this.showTime) * (_loc2_ / 1000);
            this.showTime = getTimer();
            if(_loc1_.x < sysBox.maskBox.x - _loc1_.textWidth)
            {
               _loc1_.text = "";
               _loc1_.x = sysBox.maskBox.x + sysBox.maskBox.width;
            }
         }
      }
      
      public function showSystemInfo(param1:String) : void
      {
         this.obf_u_b_993.push(param1);
      }
      
      public function showFixedInfo(param1:String) : void
      {
         this.fixedMsg.push(param1);
      }
      
      private function setTipInfo() : void
      {
         if(txtTip.visible)
         {
            txtTip.alpha -= 0.005;
            if(txtTip.alpha <= 0)
            {
               txtTip.visible = false;
            }
         }
      }
      
      public function showTipInfo(param1:String) : void
      {
         txtTip.visible = true;
         txtTip.alpha = 1;
         txtTip.htmlText = param1 || "";
      }
      
      public function obf_0_4_K_719() : void
      {
         txtTip.visible = false;
         txtTip.alpha = 1;
         txtTip.htmlText = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_u_b_993 = null;
      }
   }
}

