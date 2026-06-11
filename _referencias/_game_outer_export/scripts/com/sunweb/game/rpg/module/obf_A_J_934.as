package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mmorpg.ConfirmSmallBoxUI;
   
   public class obf_A_J_934 extends ConfirmSmallBoxUI implements IWindow
   {
      
      private var returnObj:Object = new Object();
      
      private var callFun:Function;
      
      public function obf_A_J_934(param1:Function, param2:String, param3:*)
      {
         super();
         this.x = GameContext.gameStage.stageWidth - this.width / 2 - 10;
         this.y = GameContext.gameStage.stageHeight - this.height / 2 - 50;
         this.callFun = param1;
         this.returnObj.par = param3;
         txtInfo.multiline = true;
         txtInfo.htmlText = param2;
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTip,"ConfigBox","title");
         cmdYes.label = DiversityManager.getString("ConfigBox","yes");
         cmdNo.label = DiversityManager.getString("ConfigBox","no");
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         cmdYes.addEventListener(MouseEvent.CLICK,this.onClickYes);
         cmdNo.addEventListener(MouseEvent.CLICK,this.onClickNo);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         cmdYes.removeEventListener(MouseEvent.CLICK,this.onClickYes);
         cmdNo.removeEventListener(MouseEvent.CLICK,this.onClickNo);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      private function onClickYes(param1:Event) : void
      {
         this.returnObj.confirm = true;
         WindowManager.closeWindow(this);
      }
      
      private function onClickNo(param1:Event) : void
      {
         this.returnObj.confirm = false;
         WindowManager.closeWindow(this);
      }
      
      private function onMouseDown(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onMouseUp(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function destroy() : void
      {
         if(this.callFun != null)
         {
            this.callFun.call(null,this.returnObj);
         }
         this.removeListener();
         this.callFun = null;
         this.returnObj = null;
      }
   }
}

