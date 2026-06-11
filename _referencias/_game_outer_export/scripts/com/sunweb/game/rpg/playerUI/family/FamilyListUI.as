package com.sunweb.game.rpg.playerUI.family
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyListInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FamilyListUIMC;
   
   public class FamilyListUI extends FamilyListUIMC implements IPlayerUI
   {
      
      public function FamilyListUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyLevel"));
         _loc2_.dataField = "level";
         _loc2_.editable = false;
         _loc2_.sortOptions = Array.NUMERIC;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyName"));
         _loc3_.dataField = "familyName";
         _loc3_.editable = false;
         _loc1_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyExp"));
         _loc4_.dataField = "exp";
         _loc4_.editable = false;
         _loc4_.sortOptions = Array.NUMERIC;
         _loc1_.push(_loc4_);
         var _loc5_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyLeader"));
         _loc5_.dataField = "leaderName";
         _loc5_.editable = false;
         _loc1_.push(_loc5_);
         familyList.columns = _loc1_;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyListUI","txtTitle");
         cmdCreate.label = DiversityManager.getString("FamilyListUI","cmdCreate");
         cmdJoin.label = DiversityManager.getString("FamilyListUI","cmdJoin");
         cmdView.label = DiversityManager.getString("FamilyListUI","cmdView");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdCreate.addEventListener(MouseEvent.CLICK,this.obf_d_i_3391);
         cmdJoin.addEventListener(MouseEvent.CLICK,this.obf_V_a_4586);
         cmdView.addEventListener(MouseEvent.CLICK,this.obf_0_0_j_245);
         familyList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.obf_p_j_2583);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdCreate.removeEventListener(MouseEvent.CLICK,this.obf_d_i_3391);
         cmdJoin.removeEventListener(MouseEvent.CLICK,this.obf_V_a_4586);
         cmdView.removeEventListener(MouseEvent.CLICK,this.obf_0_0_j_245);
         familyList.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.obf_p_j_2583);
      }
      
      private function obf_d_i_3391(param1:Event) : void
      {
         if(!obf_F_9_1495.obf_j_t_4601())
         {
            return;
         }
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyBoxUI","prompt_InputCreateFamilyName")),obf_F_9_1495.obf_0_8_x_487);
      }
      
      private function obf_V_a_4586(param1:Event) : void
      {
         if(GameContext.localPlayer.hasFamily())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_youHasFamily"));
            return;
         }
         if(!familyList.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyListUI","promptNeedSelectFamily"));
            return;
         }
         if(VersionConfig.enableJoinFamilyResume)
         {
            WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyListUI","promptInputJoinMsg"),null,familyList.selectedItem.familyName,20),obf_F_9_1495.confirmJoinRequest);
         }
         else
         {
            WindowManager.showConfirmBox("",obf_F_9_1495.confirmJoinRequestFast,familyList.selectedItem.familyName);
         }
      }
      
      private function obf_0_0_j_245(param1:Event) : void
      {
         if(!familyList.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyListUI","promptNeedSelectFamily"));
            return;
         }
         obf_F_9_1495.sendViewFamily((familyList.selectedItem as FamilyListInfo).familyName);
      }
      
      private function obf_p_j_2583(param1:ListEvent) : void
      {
         obf_F_9_1495.sendViewFamily((param1.item as FamilyListInfo).familyName);
      }
      
      public function setFamilyList(param1:Array) : void
      {
         var _loc2_:FamilyListInfo = null;
         familyList.removeAll();
         for each(_loc2_ in param1)
         {
            familyList.addItem(_loc2_);
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
         familyList.removeAll();
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
      
      public function showUI() : void
      {
         obf_F_9_1495.sendFamilyList();
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

