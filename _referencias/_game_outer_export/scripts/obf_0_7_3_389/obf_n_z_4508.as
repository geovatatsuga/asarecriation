package obf_0_7_3_389
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.MouseEvent;
   import playerUI.DPSRecorderMinUIMC;
   
   public class obf_n_z_4508 extends DPSRecorderMinUIMC implements IPlayerUI
   {
      
      public function obf_n_z_4508()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth - 250;
         this.y = obf_K_e_3075.smallMapUI.height;
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdButton.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function obf_7_G_3713() : void
      {
         cmdButton.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         obf_K_e_3075.obf_o_J_3931.showUI();
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
         cmdButton.label = DiversityManager.getString("MapDPSUI","txtTitle");
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
         this.obf_7_G_3713();
      }
   }
}

