package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   import mmorpg.MessageBoxUI;
   
   public class MessageBoxModule extends MessageBoxUI implements IModalWindow
   {
      
      public function MessageBoxModule(param1:String, param2:Boolean = false)
      {
         super();
         this.initDiversity();
         this.setMessage(param1);
         this.addListener();
         if(param2)
         {
            cmdOK.visible = false;
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(titleLabel,"MessageBox","title",null,true);
         cmdOK.label = DiversityManager.getString("MessageBox","ok");
      }
      
      public function setMessage(param1:String) : void
      {
         labelMessage.autoSize = TextFieldAutoSize.LEFT;
         labelMessage.multiline = true;
         labelMessage.htmlText = param1;
         labelMessage.x = -(labelMessage.textWidth / 2);
         labelMessage.y = -(labelMessage.textHeight / 2) - 20;
         bgBox.width = labelMessage.textWidth + 100;
         bgBox.height = 150 + labelMessage.textHeight;
         titleLabel.y = -(bgBox.height / 2) + 10;
         cmdOK.y = bgBox.height / 2 - 60;
      }
      
      private function addListener() : void
      {
         labelMessage.addEventListener(TextEvent.LINK,this.onClickLink);
         cmdOK.addEventListener(MouseEvent.CLICK,this.clickOKHandler);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.startDragHandler);
         this.addEventListener(MouseEvent.MOUSE_UP,this.stopDragHandler);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onCloseHandler);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      
      private function removeListener() : void
      {
         labelMessage.removeEventListener(TextEvent.LINK,this.onClickLink);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.clickOKHandler);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.startDragHandler);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.stopDragHandler);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.onCloseHandler);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      private function onCloseHandler(param1:Event) : void
      {
         this.removeListener();
      }
      
      private function startDragHandler(param1:Event) : void
      {
         if(param1.target != cmdOK)
         {
            this.startDrag();
         }
      }
      
      private function stopDragHandler(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function clickOKHandler(param1:Event) : void
      {
         WindowManager.closeWindow(this);
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

