package com.sunweb.game.rpg.playerUI.armory
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
   import flash.utils.Dictionary;
   import playerUI.ArmoryUIMC;
   
   public class ArmoryUI extends ArmoryUIMC implements obf_z_A_3653, IIconItemUI
   {
      
      private var obf_A_e_3998:IPlayerUI;
      
      private var obf_5_F_4317:Array;
      
      private var bagTypeCmd:Array;
      
      private var obf_0_5_I_285:Dictionary;
      
      public function ArmoryUI()
      {
         super();
         this.visible = false;
         this.obf_5_F_4317 = new Array();
         this.bagTypeCmd = new Array();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.onResize(null);
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[obf_V_X_3378] = obf_K_e_3075.armoryUpgradeUI;
         this.obf_0_5_I_285[tabCompose] = obf_K_e_3075.armoryComposeUI;
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[obf_V_X_3378]);
         this.refreshTableButton();
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 + 50;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function refreshTableButton() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.obf_0_5_I_285)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(this.obf_5_F_4317.indexOf(this.obf_0_5_I_285[_loc1_]) > -1 ? 2 : 1);
            }
         }
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
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[obf_V_X_3378]);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         obf_K_e_3075.closeAllChildUI(this);
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
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
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
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this.txtDeyTitle,"ArmoryUI","armory");
         DiversityManager.setTextField(this.obf_V_X_3378.txtLabel,"ArmoryUI","armoryUpgrade",null,true);
         DiversityManager.setTextField(this.tabCompose.txtLabel,"ArmoryUI","armoryCompose",null,true);
      }
   }
}

