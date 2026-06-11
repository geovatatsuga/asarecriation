package obf_p_w_3235
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.lockTower.obf_N_9_4230;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.MouseEvent;
   import playerUI.LockTowerFreeUIMC;
   
   public class obf_p_J_2393 extends LockTowerFreeUIMC implements IPlayerUI
   {
      
      private var obf_g_y_3934:int;
      
      public function obf_p_J_2393()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function setFloor(param1:int) : void
      {
         this.obf_g_y_3934 = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"lockTowerFreeUI","txtTitle");
         DiversityManager.setTextField(txtTip,"lockTowerFreeUI","txtTip");
         cmdSure.label = DiversityManager.getString("lockTowerFreeUI","cmdSure");
         cmdCancel.label = DiversityManager.getString("lockTowerFreeUI","cmdCancel");
      }
      
      public function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.addEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.obf_I_I_2821);
      }
      
      public function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.removeEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.obf_I_I_2821);
      }
      
      public function obf_H_Z_3613(param1:MouseEvent) : void
      {
         obf_N_9_4230.obf_c_a_t_c_h_529(this.obf_g_y_3934);
         obf_K_e_3075.closeUI(this);
      }
      
      public function obf_I_I_2821(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
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

