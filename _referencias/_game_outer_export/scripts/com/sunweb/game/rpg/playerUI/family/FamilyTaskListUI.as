package com.sunweb.game.rpg.playerUI.family
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyTaskInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.TaskManager;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.FamilyTaskListUIMC;
   
   public class FamilyTaskListUI extends FamilyTaskListUIMC implements IPlayerUI
   {
      
      public function FamilyTaskListUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyTaskListUI","titleTaskName"));
         _loc2_.dataField = "taskId";
         _loc2_.editable = false;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyTaskListUI","titleTaskTimes"));
         _loc3_.dataField = "timesTotal";
         _loc3_.editable = false;
         _loc3_.width = 50;
         _loc1_.push(_loc3_);
         listTask.columns = _loc1_;
         listTask.labelFunction = this.obf_5_l_4504;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyTaskListUI","txtTitle");
         cmdGetTask.label = DiversityManager.getString("FamilyTaskListUI","cmdGetTask");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         listTask.addEventListener(ListEvent.ITEM_CLICK,this.onSelectTask);
         cmdGetTask.addEventListener(MouseEvent.CLICK,this.onClickGetTask);
         txtTaskRemark.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         listTask.removeEventListener(ListEvent.ITEM_CLICK,this.onSelectTask);
         cmdGetTask.removeEventListener(MouseEvent.CLICK,this.onClickGetTask);
         txtTaskRemark.removeEventListener(TextEvent.LINK,this.onClickLink);
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function setTaskList(param1:Array) : void
      {
         var _loc2_:FamilyTaskInfo = null;
         listTask.removeAll();
         txtTaskName.text = "";
         txtTaskRemark.htmlText = "";
         for each(_loc2_ in param1)
         {
            listTask.addItem(_loc2_);
         }
      }
      
      private function onSelectTask(param1:ListEvent) : void
      {
         var _loc2_:Object = TaskManager.getTaskObjById(param1.item.taskId);
         if(!_loc2_)
         {
            return;
         }
         txtTaskName.text = _loc2_.name;
         txtTaskRemark.htmlText = ChatDecoder.decode(_loc2_.detail);
      }
      
      private function onClickGetTask(param1:Event) : void
      {
         if(!listTask.selectedItem)
         {
            return;
         }
         var _loc2_:FamilyTaskInfo = listTask.selectedItem as FamilyTaskInfo;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.timesAvailable <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyTaskListUI","prompt_NoTimes"));
            return;
         }
         obf_F_9_1495.sendGetFamilyTask(_loc2_.taskId);
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_5_l_4504(param1:Object, param2:DataGridColumn) : String
      {
         var _loc3_:Object = null;
         if(param2.dataField == "taskId")
         {
            _loc3_ = TaskManager.getTaskObjById(param1.taskId);
            if(_loc3_)
            {
               return _loc3_.name;
            }
            return param1.taskId;
         }
         if(param2.dataField == "timesTotal")
         {
            return param1.timesAvailable + "/" + param1.timesTotal;
         }
         return param1.timesTotal;
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
         this.visible = false;
         listTask.removeAll();
         txtTaskName.text = "";
         txtTaskRemark.htmlText = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

