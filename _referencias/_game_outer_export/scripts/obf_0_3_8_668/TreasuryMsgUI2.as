package obf_0_3_8_668
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.treasuryMsgUI2MC;
   
   public class TreasuryMsgUI2 extends treasuryMsgUI2MC implements IPlayerUI
   {
      
      public function TreasuryMsgUI2()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = obf_K_e_3075.obf_0___I_542.x;
         this.y = obf_K_e_3075.obf_0___I_542.y;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtMsgTitle,"TreasuryMsgUI","txtMsgTitle");
         DiversityManager.setTextField(txtX3,"TreasuryMsgUI","txtX3");
         cmdOk.label = DiversityManager.getString("TreasuryMsgUI","cmdOk");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOk.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOk.removeEventListener(MouseEvent.CLICK,this.onClose);
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

