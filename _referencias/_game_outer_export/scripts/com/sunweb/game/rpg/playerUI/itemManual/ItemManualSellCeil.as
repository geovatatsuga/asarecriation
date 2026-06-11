package com.sunweb.game.rpg.playerUI.itemManual
{
   import obf_Z_Y_1344.ItemManualManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ItemManualSellCeilUIMC;
   
   public class ItemManualSellCeil extends ItemManualSellCeilUIMC implements IPlayerUI, IWindow
   {
      
      private var itemCode:String;
      
      public function ItemManualSellCeil()
      {
         super();
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdOne.addEventListener(MouseEvent.CLICK,this.obf_P_b_866);
         cmdAll.addEventListener(MouseEvent.CLICK,this.obf_d_Q_4277);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         try
         {
            this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         catch(e:Error)
         {
         }
         cmdOne.removeEventListener(MouseEvent.CLICK,this.obf_P_b_866);
         cmdAll.removeEventListener(MouseEvent.CLICK,this.obf_d_Q_4277);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         WindowManager.closeWindow(this);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.x = this.stage.mouseX + 5;
         this.y = this.stage.mouseY + 5;
      }
      
      private function onMouseDown(param1:Event) : void
      {
         if(!this.contains(param1.target as DisplayObject))
         {
            WindowManager.closeWindow(this);
         }
      }
      
      public function getCode(param1:String) : void
      {
         this.itemCode = param1;
      }
      
      private function obf_P_b_866(param1:MouseEvent) : void
      {
         ItemManualManager.sendItemManualSellReq(this.itemCode,0);
         WindowManager.closeWindow(this);
      }
      
      private function obf_d_Q_4277(param1:MouseEvent) : void
      {
         ItemManualManager.sendItemManualSellReq(this.itemCode,1);
         WindowManager.closeWindow(this);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtExplain,"ItemManualUI","ItemManualSellCeilExplain");
         cmdOne.label = DiversityManager.getString("ItemManualUI","ItemManualSellCeilOne");
         cmdAll.label = DiversityManager.getString("ItemManualUI","ItemManualSellCeilAll");
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
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
         this.removeListener();
      }
   }
}

