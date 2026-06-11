package com.sunweb.game.rpg.playerUI.pet
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PetBoxContainerUIMC;
   
   public class PetBoxContainerUI extends PetBoxContainerUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var obf_5_F_4317:Array;
      
      private var obf_A_e_3998:IPlayerUI;
      
      public function PetBoxContainerUI()
      {
         super();
         this.initDiversity();
         cmdGenie.visible = !WorldConfig.getValue("functionSwitch","genie");
         cmdWardrobe.visible = WorldConfig.getValue("functionSwitch","petDepot");
         this.visible = false;
         this.obf_5_F_4317 = new Array();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2 - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         obf_K_e_3075.showChildUI(this,obf_K_e_3075.petBoxUI);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PerBoxContainerUI","txtTitle");
         cmdPet.label = DiversityManager.getString("PerBoxContainerUI","cmdPet");
         cmdGenie.label = DiversityManager.getString("PerBoxContainerUI","cmdGenie");
         cmdWardrobe.label = DiversityManager.getString("PerBoxContainerUI","cmdWardrobe");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPet.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdGenie.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdWardrobe.addEventListener(MouseEvent.CLICK,this.onShowWardrobe);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPet.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdGenie.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdWardrobe.removeEventListener(MouseEvent.CLICK,this.onShowWardrobe);
      }
      
      private function onClickButton(param1:Event) : void
      {
         if(this.obf_A_e_3998)
         {
            obf_K_e_3075.closeChildUI(this,this.obf_A_e_3998);
         }
         if(param1.currentTarget == cmdPet)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.petBoxUI);
         }
         else if(param1.currentTarget == cmdGenie)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.genieBoxUI);
         }
      }
      
      private function onShowWardrobe(param1:Event) : void
      {
         if(obf_K_e_3075.petDepotUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.petDepotUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.petDepotUI);
            param1.stopPropagation();
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
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
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
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointChildUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = param1;
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = null;
      }
   }
}

