package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mmorpg.ConfirmBoxUI;
   
   public class ConfirmBoxModule extends ConfirmBoxUI implements IModalWindow
   {
      
      private var returnObj:Object = new Object();
      
      public function ConfirmBoxModule()
      {
         super();
         txtInfo.multiline = true;
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTip,"ConfigBox","title",null,true);
         cmdYes.label = DiversityManager.getString("ConfigBox","yes");
         cmdNo.label = DiversityManager.getString("ConfigBox","no");
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         cmdYes.addEventListener(MouseEvent.CLICK,this.onClickYes);
         cmdNo.addEventListener(MouseEvent.CLICK,this.onClickNo);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         cmdYes.removeEventListener(MouseEvent.CLICK,this.onClickYes);
         cmdNo.removeEventListener(MouseEvent.CLICK,this.onClickNo);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      public function obf_v_p_3986(param1:DisplayObject) : void
      {
         pointDisplay.addChild(param1);
      }
      
      public function setAdditionPar(param1:*) : void
      {
         this.returnObj.par = param1;
      }
      
      public function setInfo(param1:String) : void
      {
         txtInfo.htmlText = param1;
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
      
      public function get returnValue() : Object
      {
         return this.returnObj;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.returnObj = null;
         while(pointDisplay.numChildren > 0)
         {
            pointDisplay.removeChildAt(0);
         }
      }
   }
}

