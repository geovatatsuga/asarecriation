package com.sunweb.game.rpg.playerUI.playerInfo
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.PlayerBoxUIMC;
   
   public class obf_V_U_1704 extends PlayerBoxUIMC implements obf_z_A_3653, IIconItemUI
   {
      
      private var obf_5_F_4317:Array;
      
      private var obf_0_5_I_285:Dictionary;
      
      public function obf_V_U_1704()
      {
         super();
         this.visible = false;
         this.initDiversity();
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         this.obf_5_F_4317 = new Array();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[obf_0_b_772] = obf_K_e_3075.playerFullInfoUI;
         this.obf_0_5_I_285[obf_F_W_1022] = obf_K_e_3075.obf_J_K_2135;
         this.obf_0_5_I_285[obf_0_4_B_173] = obf_K_e_3075.animalBoxUI;
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[obf_0_b_772]);
         this.refreshTableButton();
         this.addListener();
      }
      
      private function setNoAnimalUI(param1:Boolean = true) : void
      {
         if(param1)
         {
            obf_0_4_B_173.visible = false;
         }
         else
         {
            obf_0_4_B_173.visible = true;
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this.obf_0_b_772.txtLabel,"RoleUI","roleAtt",null,true);
         DiversityManager.setTextField(this.obf_F_W_1022.txtLabel,"RoleUI","godSoul",null,true);
         DiversityManager.setTextField(this.obf_0_4_B_173.txtLabel,"RoleUI","animalAtt",null,true);
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
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
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
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
      
      public function set txtTitle(param1:String) : void
      {
         txtDeyTitle.text = param1;
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
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         if(param1.currentTarget == obf_F_W_1022 && GameContext.localPlayer.fullInfo.level < 60)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleLevel>=",[60]),null);
            return;
         }
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      public function showAnimalUI() : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[obf_0_4_B_173]);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointChildUI;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         if(GameContext.localPlayer.fullInfo.jobCode == obf_I_5_1944.obf_0_1_133)
         {
            this.setNoAnimalUI(false);
         }
         else
         {
            this.setNoAnimalUI();
         }
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[obf_0_b_772]);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         obf_K_e_3075.closeAllChildUI(this);
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
   }
}

