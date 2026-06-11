package com.sunweb.game.rpg.playerUI
{
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.TaskBoxUIMC;
   
   public class PlayerTaskUI extends TaskBoxUIMC implements IPlayerUI, IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array = new Array();
      
      private var _noviceSprite:Sprite;
      
      private var refreshTaskShowTime:TimeLimiter = new TimeLimiter(2000);
      
      public function PlayerTaskUI()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 + 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
         txtTaskDetail.wordWrap = true;
         txtTaskCondition.wordWrap = true;
         taskList.labelFunction = this.taskListLabel;
         taskList.iconFunction = this.taskListIcon;
         scrollTaskAward.pageSize = scrollTaskAward.height;
         this.refreshTask();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TaskUI","txtTitle");
         DiversityManager.setTextField(txtDeyTaskDescription,"TaskUI","txtTaskDescription");
         DiversityManager.setTextField(txtDeyTaskCondition,"TaskUI","txtTaskCondition");
         DiversityManager.setTextField(txtDeyTaskAward,"TaskUI","txtTaskAward");
         chkTaskTracer.label = DiversityManager.getString("TaskUI","txtShowTaskTracer");
         DiversityManager.setTextField(tableHadTask.txtLabel,"TaskUI","cmdTable_HadTask",null,true);
         DiversityManager.setTextField(tableCanReceiveTask.txtLabel,"TaskUI","cmdTable_CanReceiveTask",null,true);
         cmdAbortTask.label = DiversityManager.getString("TaskUI","cmdAbortTask");
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "TaskUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         return null;
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this[param1];
      }
      
      private function addListener() : void
      {
         chkTaskTracer.addEventListener(MouseEvent.CLICK,this.onClickTaskTracer);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         taskList.addEventListener(MouseEvent.CLICK,this.onClickTask);
         cmdAbortTask.addEventListener(MouseEvent.CLICK,this.onAbortTask);
         scrollTaskAward.addEventListener(ScrollEvent.SCROLL,this.onScrollAward);
         txtTaskCondition.addEventListener(TextEvent.LINK,this.onClickLink);
         txtTaskDetail.addEventListener(TextEvent.LINK,this.onClickLink);
         tableHadTask.addEventListener(MouseEvent.CLICK,this.onClickHadTask);
         tableCanReceiveTask.addEventListener(MouseEvent.CLICK,this.obf_0_8_P_340);
      }
      
      private function removeListener() : void
      {
         chkTaskTracer.removeEventListener(MouseEvent.CLICK,this.onClickTaskTracer);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         taskList.removeEventListener(MouseEvent.CLICK,this.onClickTask);
         cmdAbortTask.removeEventListener(MouseEvent.CLICK,this.onAbortTask);
         scrollTaskAward.removeEventListener(ScrollEvent.SCROLL,this.onScrollAward);
         txtTaskCondition.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtTaskDetail.removeEventListener(TextEvent.LINK,this.onClickLink);
         tableHadTask.removeEventListener(MouseEvent.CLICK,this.onClickHadTask);
         tableCanReceiveTask.removeEventListener(MouseEvent.CLICK,this.obf_0_8_P_340);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClickHadTask(param1:Event) : void
      {
         this.refreshTask();
      }
      
      private function obf_0_8_P_340(param1:Event) : void
      {
         this.refreshCanReceiveTask();
      }
      
      private function obf_6_6_1282(param1:Event) : void
      {
         this.refreshCanReceiveTask();
      }
      
      private function onClickTaskTracer(param1:Event) : void
      {
         if(chkTaskTracer.selected)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_0___5_510);
         }
         else
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_0___5_510);
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.visible) && Boolean(taskList.selectedItem) && this.refreshTaskShowTime.checkTimeout())
         {
            this.setTaskCondition(taskList.selectedItem.finishRule.condition);
         }
      }
      
      private function taskListLabel(param1:Object) : String
      {
         return param1.name;
      }
      
      private function taskListIcon(param1:Object) : DisplayObject
      {
         if(ConditionScript.checkCondition(param1.finishRule.condition))
         {
            return null;
         }
         return null;
      }
      
      private function onScrollAward(param1:ScrollEvent) : void
      {
         taskAwardContent.scrollRect = new Rectangle(0,param1.position,scrollTaskAward.x - taskAwardContent.x,scrollTaskAward.height);
      }
      
      public function refreshCanReceiveTask() : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         tableHadTask.gotoAndStop(1);
         tableCanReceiveTask.gotoAndStop(2);
         this.clearTaskContent();
         var _loc1_:Array = new Array();
         for(_loc2_ in TaskManager.taskObject)
         {
            _loc3_ = TaskManager.getTaskObjById(int(_loc2_));
            if(!(!_loc3_ || (JSONUtil.getObject(_loc3_,["receiveRule","atAnyNpc"],new Array()) as Array).length == 0))
            {
               if(!(TaskManager.doingTasks.indexOf(int(_loc2_)) > -1 || TaskManager.doneTasks[_loc2_] > 0))
               {
                  if(ConditionScript.checkCondition(JSONUtil.getObject(_loc3_,["receiveRule","condition"])))
                  {
                     _loc1_.push(_loc3_);
                  }
               }
            }
         }
         taskList.dataProvider = new DataProvider(_loc1_);
         taskList.sortItemsOn("kind",Array.NUMERIC);
      }
      
      public function refreshTaskShow() : void
      {
         if(!taskList.selectedItem)
         {
            return;
         }
         var _loc1_:Object = taskList.selectedItem;
         this.setTaskDetail(_loc1_.detail);
         this.setTaskCondition(_loc1_.finishRule.condition);
         this.setTaskAward(_loc1_.finishRule.onFinished);
      }
      
      private function onClickTask(param1:Event) : void
      {
         this.refreshTaskShow();
      }
      
      private function setTaskDetail(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         param1 = obf_K_e_3075.getSwitchString(param1);
         var _loc2_:String = "";
         if(taskList.selectedItem)
         {
            _loc4_ = "";
            for each(_loc5_ in taskList.selectedItem.receiveRule.atAnyNpc)
            {
               _loc6_ = _loc5_.split("@");
               if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc6_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
               {
                  _loc2_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcFullBriefName(_loc5_),_loc6_[1],_loc6_[0]));
               }
               _loc4_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc5_) + "-" + WorldMapManager.getMapName(_loc6_[1]),_loc6_[1],_loc6_[0]);
            }
            if(obf_L_l_4100.isEmpty(_loc2_))
            {
               _loc2_ = _loc4_;
            }
            _loc2_ = DiversityManager.getString("TaskUI","recevieNPC") + _loc2_;
         }
         var _loc3_:String = "";
         if(taskList.selectedItem)
         {
            _loc7_ = "";
            for each(_loc8_ in taskList.selectedItem.finishRule.atAnyNpc)
            {
               _loc9_ = _loc8_.split("@");
               if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc9_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
               {
                  _loc3_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc8_) + "-" + WorldMapManager.getMapName(_loc9_[1]),_loc9_[1],_loc9_[0]));
               }
               _loc7_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc8_) + "-" + WorldMapManager.getMapName(_loc9_[1]),_loc9_[1],_loc9_[0]);
            }
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ = _loc7_;
            }
            _loc3_ = "\n" + DiversityManager.getString("TaskUI","finishNPC") + _loc3_;
         }
         txtTaskDetail.htmlText = ChatDecoder.decode(_loc2_ + _loc3_ + "\n\n" + param1);
         scrollTaskDetail.update();
         scrollTaskDetail.visible = scrollTaskDetail.enabled;
      }
      
      private function setTaskCondition(param1:Object) : void
      {
         var _loc2_:String = null;
         txtTaskCondition.htmlText = "";
         if(!param1)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            txtTaskCondition.htmlText += ConditionScript.getConditionHTML(_loc2_,param1[_loc2_]);
         }
         scrollTaskCondition.update();
         scrollTaskCondition.visible = scrollTaskCondition.enabled;
      }
      
      private function setTaskAward(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:DisplayObject = null;
         if(!param1)
         {
            return;
         }
         this.bags = new Array();
         while(taskAwardContent.numChildren > 0)
         {
            if(taskAwardContent.getChildAt(0) is ItemShowBoxUI)
            {
               ItemShowBoxUI(taskAwardContent.getChildAt(0)).destroy();
            }
            taskAwardContent.removeChildAt(0);
         }
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_.sort();
         _loc5_ = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc7_ = MacroScript.getMacroDisplay(_loc6_,param1[_loc6_]);
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc9_ = _loc7_[_loc8_];
               if(_loc9_)
               {
                  if(_loc9_ is ItemShowBoxUI)
                  {
                     ItemShowBoxUI(_loc9_).dockParentUI(this,this.bags);
                  }
                  _loc9_.x = _loc8_ % 2 * 150;
                  _loc9_.y = _loc4_;
                  _loc5_ = Math.max(_loc5_,_loc9_.height);
                  if(_loc8_ % 2 == 0 && _loc8_ > 0)
                  {
                     _loc4_ += _loc5_;
                     _loc9_.y = _loc4_;
                  }
                  if(_loc8_ == _loc7_.length - 1)
                  {
                     _loc4_ += _loc5_;
                  }
                  taskAwardContent.addChild(_loc9_);
               }
               _loc8_++;
            }
         }
         if(_loc4_ > scrollTaskAward.height)
         {
            scrollTaskAward.maxScrollPosition = _loc4_ - scrollTaskAward.height;
            scrollTaskAward.visible = true;
         }
         else
         {
            scrollTaskAward.scrollPosition = 0;
            scrollTaskAward.maxScrollPosition = 1;
            scrollTaskAward.visible = false;
         }
         taskAwardContent.scrollRect = new Rectangle(0,scrollTaskAward.scrollPosition,scrollTaskAward.x - taskAwardContent.x,scrollTaskAward.height);
      }
      
      public function showTaskById(param1:int) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < taskList.dataProvider.length)
         {
            _loc3_ = taskList.dataProvider.getItemAt(_loc2_);
            if(Boolean(_loc3_) && _loc3_.taskId == param1)
            {
               taskList.selectedItem = _loc3_;
               this.refreshTask();
               return;
            }
            _loc2_++;
         }
      }
      
      public function refreshTask() : void
      {
         tableHadTask.gotoAndStop(2);
         tableCanReceiveTask.gotoAndStop(1);
         var _loc1_:Object = taskList.selectedItem;
         var _loc2_:Array = TaskManager.getDoingTask();
         taskList.dataProvider = new DataProvider(_loc2_);
         taskList.sortItemsOn("kind",Array.NUMERIC);
         this.clearTaskContent();
         if(!_loc1_ || _loc2_.indexOf(_loc1_) == -1)
         {
            taskList.selectedIndex = _loc2_.length - 1;
         }
         else
         {
            taskList.selectedItem = _loc1_;
         }
         this.refreshTaskShow();
      }
      
      public function clearTaskContent() : void
      {
         txtTaskDetail.htmlText = "";
         scrollTaskDetail.visible = false;
         txtTaskCondition.htmlText = "";
         scrollTaskCondition.visible = false;
         this.bags = new Array();
         while(taskAwardContent.numChildren > 0)
         {
            if(taskAwardContent.getChildAt(0) is ItemShowBoxUI)
            {
               ItemShowBoxUI(taskAwardContent.getChildAt(0)).destroy();
            }
            taskAwardContent.removeChildAt(0);
         }
         scrollTaskAward.visible = false;
      }
      
      private function onAbortTask(param1:Event) : void
      {
         if(taskList.selectedItem)
         {
            if(Boolean(taskList.selectedItem.abortRule) && Boolean(taskList.selectedItem.abortRule.cannotAbort))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("TaskUI","promptContAbortTask"));
            }
            else
            {
               WindowManager.showConfirmBox(DiversityManager.getString("TaskUI","promptConfirmAbortTask"),this.confirmAbortTask,taskList.selectedItem.taskId);
            }
         }
      }
      
      private function confirmAbortTask(param1:Object) : void
      {
         if(param1.confirm)
         {
            TaskManager.sendAbortTask(param1.par);
         }
      }
      
      private function onClickDayTask(param1:Event) : void
      {
         if(obf_K_e_3075.daysActPromptUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.daysActPromptUI);
            obf_K_e_3075.closeUI(this);
         }
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
         if(obf_K_e_3075.obf_0___5_510)
         {
            chkTaskTracer.selected = obf_K_e_3075.obf_0___5_510.visible;
         }
         this.refreshTaskShow();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearTaskContent();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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

