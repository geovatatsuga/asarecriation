package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.utils.getTimer;
   import playerUI.SingUIMC;
   
   public class SingBarUI extends SingUIMC implements IPlayerUI
   {
      
      private var singTimelimiter:TimeLimiter;
      
      public function SingBarUI()
      {
         super();
         this.stop();
         this.visible = false;
         this.mouseEnabled = false;
         this.addEventListener(Event.ENTER_FRAME,this.showSingBar);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function showSingBar(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.singTimelimiter)
         {
            if(this.stage)
            {
               this.x = this.stage.stageWidth / 2;
               this.y = this.stage.stageHeight - 160;
            }
            _loc2_ = getTimer() - this.singTimelimiter.obf_Z_s_1070;
            _loc3_ = _loc2_ / this.singTimelimiter.timelimit * 100;
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            else if(_loc3_ > 100)
            {
               _loc3_ = 100;
            }
            singBar.gotoAndStop(_loc3_);
         }
      }
      
      public function singSkill(param1:int, param2:String) : void
      {
         this.singTimelimiter = new TimeLimiter(param1);
         this.showSingBar(null);
         txtLabel.text = param2;
         this.visible = true;
      }
      
      public function skillDone() : void
      {
         this.singTimelimiter = null;
         this.visible = false;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.showSingBar);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

