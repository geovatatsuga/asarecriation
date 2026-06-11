package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.TaskTracerUIMC;
   
   public class TaskTracerUI extends TaskTracerUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      private var taskTracers:Object = new Object();
      
      private var refreshTaskTime:TimeLimiter = new TimeLimiter(2000);
      
      private var contentHeight:int = 0;
      
      private var _noviceSprite:Sprite;
      
      public function TaskTracerUI()
      {
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         this.onResize(null);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TaskTracerUI","txtTitle");
         cmdHaveTask.txtLabel.text = DiversityManager.getString("TaskTracerUI","cmdHaveTask");
         cmdCanReceiveTask.txtLabel.text = DiversityManager.getString("TaskTracerUI","cmdCanReceiveTask");
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         obf_7_V_796.addEventListener(MouseEvent.CLICK,this.obf_e_A_2349);
         titleBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         scrollTask.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         cmdHaveTask.addEventListener(MouseEvent.CLICK,this.onClickHaveTask);
         cmdCanReceiveTask.addEventListener(MouseEvent.CLICK,this.obf_0_8_P_340);
         txtCanReceiveTask.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         obf_7_V_796.removeEventListener(MouseEvent.CLICK,this.obf_e_A_2349);
         titleBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         scrollTask.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         cmdHaveTask.removeEventListener(MouseEvent.CLICK,this.onClickHaveTask);
         cmdCanReceiveTask.removeEventListener(MouseEvent.CLICK,this.obf_0_8_P_340);
         txtCanReceiveTask.removeEventListener(TextEvent.LINK,this.onClickLink);
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
         return "TaskTracer";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:String = null;
         for(_loc2_ in this.taskTracers)
         {
            if(_loc2_ == param1)
            {
               return new Point(this.taskTracers[_loc2_].x + 50,this.taskTracers[_loc2_].y + 25);
            }
         }
         return null;
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return null;
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - titleBox.width;
         this.y = 230;
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
      
      private function obf_3_S_1490(param1:Event) : void
      {
         pointTask.scrollRect = new Rectangle(0,scrollTask.scrollPosition,scrollTask.x - pointTask.x,scrollTask.height);
      }
      
      private function obf_e_A_2349(param1:Event) : void
      {
         if(pointTask.parent == this)
         {
            this.removeChild(pointTask);
            this.removeChild(scrollTask);
         }
         else
         {
            this.addChild(pointTask);
            this.addChild(scrollTask);
         }
         obf_7_V_796.text = pointTask.parent == this ? "━" : "╋";
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.visible && this.refreshTaskTime.checkTimeout())
         {
            this.refreshTaskTracer();
         }
      }
      
      private function onClickHaveTask(param1:Event) : void
      {
         this.showHaveTask();
      }
      
      private function obf_0_8_P_340(param1:Event) : void
      {
         this.showCanReceiveTask();
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function showHaveTask() : void
      {
         pointTask.visible = true;
         scrollTask.visible = true;
         txtCanReceiveTask.visible = false;
         obf_4_a_3279.visible = false;
         cmdHaveTask.gotoAndStop(2);
         cmdCanReceiveTask.gotoAndStop(1);
      }
      
      public function showCanReceiveTask() : void
      {
         var _loc3_:Object = null;
         var _loc1_:Array = TaskManager.getCanReceiveTask();
         var _loc2_:String = "";
         for each(_loc3_ in _loc1_)
         {
            _loc2_ += "\n---------";
            _loc2_ += "\n" + JSONUtil.getStr(_loc3_,["name"]);
            _loc2_ += "\n" + obf_7_6_4416.getNpcLinkAByFullId(JSONUtil.getStr(_loc3_,["receiveRule","atAnyNpc"]));
         }
         txtCanReceiveTask.htmlText = _loc2_;
         pointTask.visible = false;
         scrollTask.visible = false;
         txtCanReceiveTask.visible = true;
         obf_4_a_3279.visible = true;
         cmdHaveTask.gotoAndStop(1);
         cmdCanReceiveTask.gotoAndStop(2);
      }
      
      public function addTaskTracer(param1:int) : void
      {
         if(Boolean(this.taskTracers[param1]) && Boolean(this.taskTracers[param1] is TaskTracerBoxUI) && pointTask.contains(this.taskTracers[param1]))
         {
            this.taskTracers[param1].destroy();
            pointTask.removeChild(this.taskTracers[param1]);
         }
         var _loc2_:TaskTracerBoxUI = new TaskTracerBoxUI(param1);
         _loc2_.y = this.contentHeight + 3;
         this.taskTracers[param1] = _loc2_;
         pointTask.addChild(_loc2_);
         this.refreshTaskTracer();
         this.showHaveTask();
      }
      
      public function delTaskTracer(param1:int) : void
      {
         if(Boolean(this.taskTracers[param1]) && Boolean(this.taskTracers[param1] is TaskTracerBoxUI) && pointTask.contains(this.taskTracers[param1]))
         {
            this.taskTracers[param1].destroy();
            pointTask.removeChild(this.taskTracers[param1]);
         }
         delete this.taskTracers[param1];
         this.refreshTaskTracer();
      }
      
      public function clearTaskTracer() : void
      {
         var _loc1_:String = null;
         var _loc2_:TaskTracerBoxUI = null;
         for(_loc1_ in this.taskTracers)
         {
            if(this.taskTracers[_loc1_] is TaskTracerBoxUI)
            {
               _loc2_ = this.taskTracers[_loc1_];
               if(pointTask.contains(_loc2_))
               {
                  pointTask.removeChild(_loc2_);
               }
               _loc2_.destroy();
            }
         }
         this.taskTracers = new Object();
         this.refreshTaskTracer();
         this.showCanReceiveTask();
      }
      
      public function refreshTaskTracer() : void
      {
         var _loc3_:TaskTracerBoxUI = null;
         var _loc4_:TaskTracerBoxUI = null;
         this.contentHeight = 0;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < pointTask.numChildren)
         {
            if(pointTask.getChildAt(_loc2_) is TaskTracerBoxUI)
            {
               _loc4_ = pointTask.getChildAt(_loc2_) as TaskTracerBoxUI;
               _loc1_.push(_loc4_);
            }
            _loc2_++;
         }
         _loc1_.sortOn("taskKind",Array.NUMERIC);
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_)
            {
               _loc3_.y = this.contentHeight + 3;
               _loc3_.refreshTask();
               this.contentHeight += _loc3_.height;
            }
         }
         if(this.contentHeight > scrollTask.height)
         {
            scrollTask.pageSize = scrollTask.height;
            scrollTask.maxScrollPosition = this.contentHeight - scrollTask.height;
            pointTask.scrollRect = new Rectangle(0,scrollTask.scrollPosition,scrollTask.x - pointTask.x,scrollTask.height);
            if(pointTask.visible)
            {
               scrollTask.visible = true;
            }
         }
         else
         {
            pointTask.scrollRect = new Rectangle(0,0,scrollTask.x - pointTask.x,scrollTask.height);
            scrollTask.visible = false;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
         this.refreshTaskTracer();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         while(pointTask.numChildren > 0)
         {
            if(pointTask.getChildAt(0) is TaskTracerBoxUI)
            {
               (pointTask.getChildAt(0) as TaskTracerBoxUI).destroy();
            }
            pointTask.removeChildAt(0);
         }
         this.removeListener();
      }
   }
}

