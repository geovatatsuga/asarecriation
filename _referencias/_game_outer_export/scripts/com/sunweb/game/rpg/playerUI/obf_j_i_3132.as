package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.trade.obf_G_0_3203;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TradeCheckUIMC;
   
   public class obf_j_i_3132 extends TradeCheckUIMC implements IPlayerUI
   {
      
      public function obf_j_i_3132()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.onResize(null);
         this.addListener();
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdVerify.addEventListener(MouseEvent.CLICK,this.obf_d_m_1815);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdVerify.removeEventListener(MouseEvent.CLICK,this.obf_d_m_1815);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = Math.floor(Math.random() * (GameContext.gameStage.stageWidth / 2)) + 300;
         this.y = Math.floor(Math.random() * (GameContext.gameStage.stageHeight / 2)) + 250;
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
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_d_m_1815(param1:Event) : void
      {
         obf_G_0_3203.sendConfirmTradeCheck(txtInputNum.text);
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TradeUI","txtDeyTitle");
         cmdVerify.label = DiversityManager.getString("TradeUI","txtDeyTitle");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.onResize(null);
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

