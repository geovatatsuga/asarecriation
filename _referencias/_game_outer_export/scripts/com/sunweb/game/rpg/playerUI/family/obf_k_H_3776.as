package com.sunweb.game.rpg.playerUI.family
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyIntVarListInfo;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import fl.controls.dataGridClasses.DataGridColumn;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FamilyVarListUIMC;
   
   public class obf_k_H_3776 extends FamilyVarListUIMC implements IPlayerUI
   {
      
      public function obf_k_H_3776()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyLevel"));
         _loc2_.dataField = "level";
         _loc2_.editable = false;
         _loc2_.sortOptions = Array.NUMERIC;
         _loc2_.width = 80;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyName"));
         _loc3_.dataField = "familyName";
         _loc3_.width = 150;
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
         var _loc6_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyListUI","titleFamilyVar"));
         _loc6_.dataField = "intVarValue";
         _loc6_.editable = false;
         _loc6_.sortOptions = Array.NUMERIC;
         _loc6_.width = 85;
         _loc1_.push(_loc6_);
         listFamilyVar.columns = _loc1_;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyListUI","txtTitle");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      public function setFamilyVarList(param1:Array) : void
      {
         var _loc2_:FamilyIntVarListInfo = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_)
            {
               if(_loc2_.intVarValue != 0)
               {
                  listFamilyVar.addItem(_loc2_);
               }
            }
         }
         listFamilyVar.dataProvider.sortOn("intVarValue",Array.DESCENDING | Array.NUMERIC);
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
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         listFamilyVar.removeAll();
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         listFamilyVar.removeAll();
      }
   }
}

