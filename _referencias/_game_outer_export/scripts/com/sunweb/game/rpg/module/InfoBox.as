package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mmorpg.InfoBoxUI;
   
   public class InfoBox extends InfoBoxUI implements IWindow
   {
      
      public function InfoBox(param1:String)
      {
         super();
         txtContent.wordWrap = true;
         txtContent.htmlText = param1;
         scrollInfo.update();
         scrollInfo.visible = scrollInfo.enabled;
         this.x = GameContext.gameStage.stageWidth;
         this.y = GameContext.gameStage.stageHeight / 2 - this.height / 2;
         this.addListener();
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.x > GameContext.gameStage.stageWidth - this.width)
         {
            this.x -= 2;
         }
      }
      
      private function onClose(param1:Event) : void
      {
         WindowManager.closeWindow(this);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

