package obf_V_n_3191
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ArtifactBoxUIMC;
   
   public class ArtifactBoxUI extends ArtifactBoxUIMC implements obf_z_A_3653, IIconItemUI
   {
      
      private var obf_5_F_4317:Array;
      
      private var obf_A_e_3998:IPlayerUI;
      
      public function ArtifactBoxUI()
      {
         super();
         this.initDiversity();
         this.obf_5_F_4317 = new Array();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"ArtifactBoxUI","txtTitle");
         cmdArtifactUpgrade.label = DiversityManager.getString("ArtifactBoxUI","cmdArtifactUpgrade");
         cmdArtifactFusion.label = DiversityManager.getString("ArtifactBoxUI","cmdArtifactFusion");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdArtifactUpgrade.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdArtifactFusion.addEventListener(MouseEvent.CLICK,this.onClickButton);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdArtifactUpgrade.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdArtifactFusion.removeEventListener(MouseEvent.CLICK,this.onClickButton);
      }
      
      private function onClickButton(param1:Event) : void
      {
         if(this.obf_A_e_3998)
         {
            obf_K_e_3075.closeChildUI(this,this.obf_A_e_3998);
         }
         if(param1.currentTarget == cmdArtifactUpgrade)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.artifactUpgradeUI);
         }
         else if(param1.currentTarget == cmdArtifactFusion)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.artifactFusionUI);
         }
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
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         if(this.obf_A_e_3998)
         {
            obf_K_e_3075.closeChildUI(this,this.obf_A_e_3998);
         }
         obf_K_e_3075.showChildUI(this,obf_K_e_3075.artifactUpgradeUI);
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = param1;
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = null;
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:IPlayerUI = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.obf_5_F_4317)
         {
            if(Boolean(_loc2_) && _loc2_ is IIconItemUI)
            {
               _loc1_ = _loc1_.concat((_loc2_ as IIconItemUI).getIconItemBags());
            }
         }
         return _loc1_;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

