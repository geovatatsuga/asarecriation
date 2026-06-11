package com.sunweb.game.rpg.playerUI
{
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import playerUI.TaskTracerBoxUIMC;
   
   public class TaskTracerBoxUI extends TaskTracerBoxUIMC
   {
      
      private var _taskObj:Object;
      
      private var _taskId:int;
      
      private var clickToMap:Boolean;
      
      public function TaskTracerBoxUI(param1:int)
      {
         super();
         this.initDiversity();
         this._taskId = param1;
         this._taskObj = TaskManager.getTaskObjById(param1);
         this.addListener();
         txtTaskName.wordWrap = true;
         txtTaskCondition.wordWrap = true;
         this.refreshTask();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtViewTask,"TaskTracerUI","txtClickShowContent",null,true);
      }
      
      private function addListener() : void
      {
         txtTaskName.addEventListener(MouseEvent.CLICK,this.onClickTaskName);
         txtTaskCondition.addEventListener(MouseEvent.CLICK,this.onClickCondition);
         txtTaskCondition.addEventListener(TextEvent.LINK,this.onClickLink);
         txtViewTask.addEventListener(MouseEvent.CLICK,this.onClickViewTask);
      }
      
      private function removeListener() : void
      {
         txtTaskName.removeEventListener(MouseEvent.CLICK,this.onClickTaskName);
         txtTaskCondition.removeEventListener(MouseEvent.CLICK,this.onClickCondition);
         txtTaskCondition.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtViewTask.removeEventListener(MouseEvent.CLICK,this.onClickViewTask);
      }
      
      public function get taskKind() : int
      {
         return JSONUtil.getInt(this._taskObj,["kind"]);
      }
      
      private function onClickCondition(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = null;
         var _loc3_:Point = null;
         if(Boolean(GameContext.currentMap) && this.clickToMap)
         {
            _loc2_ = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
            _loc3_ = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
            _loc2_.localX = _loc3_.x;
            _loc2_.localY = _loc3_.y;
            GameContext.currentMap.dispatchEvent(_loc2_);
         }
         this.clickToMap = true;
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
         this.clickToMap = false;
         if(this._taskId == TaskManager.autoTaskId)
         {
            TaskManager.isAutoTask = true;
         }
      }
      
      private function onClickViewTask(param1:Event) : void
      {
         if(obf_K_e_3075.playerTaskUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerTaskUI);
            obf_K_e_3075.playerTaskUI.refreshTask();
            obf_K_e_3075.playerTaskUI.showTaskById(this._taskId);
         }
      }
      
      private function onClickTaskName(param1:Event) : void
      {
         if(this.contains(txtTaskCondition))
         {
            this.removeChild(txtTaskCondition);
         }
         else
         {
            this.addChild(txtTaskCondition);
         }
         if(obf_K_e_3075.obf_0___5_510)
         {
            obf_K_e_3075.obf_0___5_510.refreshTaskTracer();
         }
      }
      
      public function refreshTask() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         if(!this._taskObj)
         {
            return;
         }
         txtTaskName.text = (this.contains(txtTaskCondition) ? "－" : "＋") + this._taskObj.name;
         var _loc1_:String = "";
         var _loc2_:Boolean = ConditionScript.checkCondition(this._taskObj.finishRule.condition);
         if(!obf_L_l_4100.isEmpty(this._taskObj.brief))
         {
            _loc1_ += ChatDecoder.decode(this._taskObj.brief) + "\n";
         }
         if(_loc2_)
         {
            if(Boolean(this._taskObj.finishRule.atAnyNpc) && this._taskObj.finishRule.atAnyNpc.length > 0)
            {
               _loc3_ = "";
               for each(_loc4_ in this._taskObj.finishRule.atAnyNpc)
               {
                  _loc5_ = _loc4_.split("@");
                  if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc5_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
                  {
                     _loc1_ += DiversityManager.getString("TaskTracerUI","taskFinish",[ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc4_) + "-" + WorldMapManager.getMapName(_loc5_[1]),_loc5_[1],_loc5_[0]))]) + "\n";
                  }
                  _loc3_ += DiversityManager.getString("TaskTracerUI","taskFinish",[ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc4_) + "-" + WorldMapManager.getMapName(_loc5_[1]),_loc5_[1],_loc5_[0]))]) + "\n";
               }
               if(_loc1_ == "")
               {
                  _loc1_ = _loc3_;
               }
            }
         }
         if(!_loc2_)
         {
            for(_loc6_ in this._taskObj.finishRule.condition)
            {
               _loc1_ += ConditionScript.getConditionHTML(_loc6_,this._taskObj.finishRule.condition[_loc6_]) + "\n";
            }
         }
         txtTaskCondition.htmlText = _loc1_;
         txtTaskCondition.height = txtTaskCondition.textHeight + 5;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

