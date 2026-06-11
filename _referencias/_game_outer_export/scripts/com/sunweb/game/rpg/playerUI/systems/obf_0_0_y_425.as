package com.sunweb.game.rpg.playerUI.systems
{
   import com.sunweb.game.rpg.GameContext;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import playerUI.SystemCenterMessage;
   
   public class obf_0_0_y_425 extends SystemCenterMessage
   {
      
      private var createTime:int;
      
      public function obf_0_0_y_425(param1:String)
      {
         super();
         this.cacheAsBitmap = true;
         infoMC.txtInfo.htmlText = param1;
         infoMC.txtInfo.y = -(infoMC.txtInfo.textHeight / 2);
         infoMC.bgBox.width = infoMC.txtInfo.textWidth + 50;
         infoMC.bgBox.height = infoMC.txtInfo.textHeight + 50;
         this.createTime = getTimer();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(getTimer() - this.createTime > 10000 || this.currentLabel == "end")
         {
            this.destroy();
         }
      }
      
      private function onClick(param1:Event) : void
      {
         if(this.parent)
         {
            GameContext.gameStage.focus = this.parent;
         }
         this.destroy();
      }
      
      public function destroy() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

