package obf_0_8_3_434
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AssembleListUIMC;
   
   public class AssembleListUI extends AssembleListUIMC implements IPlayerUI
   {
      
      public function AssembleListUI()
      {
         super();
         this.initDiversity();
         this.x = 250;
         this.y = GameContext.gameStage.stageHeight / 2;
         listType.dataProvider = new DataProvider(WorldConfig.getObjectSetting("bagAssembleTypeList") as Array);
         listType.selectedIndex = 0;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"AssembleListUI","txtTitle");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         listType.addEventListener(ListEvent.ITEM_CLICK,this.obf_P_G_3138);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         listType.removeEventListener(ListEvent.ITEM_CLICK,this.obf_P_G_3138);
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
         obf_K_e_3075.closeUI(obf_K_e_3075.assembleBoxUI);
      }
      
      private function obf_P_G_3138(param1:Event) : void
      {
         if(!listType.selectedItem)
         {
            return;
         }
         obf_K_e_3075.assembleBoxUI.show("",listType.selectedItem.data,null);
         obf_K_e_3075.assembleBoxUI.x = this.x + 230;
         obf_K_e_3075.assembleBoxUI.y = this.y;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_P_G_3138(null);
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

