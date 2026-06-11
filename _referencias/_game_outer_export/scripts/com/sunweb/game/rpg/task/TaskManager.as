package com.sunweb.game.rpg.task
{
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.module.obf_0_K_4070;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.PromptsManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerEnterWorldAnswer;
   import com.sunweb.game.rpg.worldZone.command.task.CommandCodeTask;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerAbortTaskNotify;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerAbortTaskRequest;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerFinishTaskNotify;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerFinishTaskRequest;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerReceiveTaskNotify;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerReceiveTaskRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.utils.setTimeout;
   
   public class TaskManager
   {
      
      private static var taskRecorder:TaskRecorder;
      
      public static var isAutoTask:Boolean;
      
      private static var autoTaskConfig:Object;
      
      private static var taskListById:Object = new Object();
      
      private static var npcTaskId:Object = new Object();
      
      private static var doingTaskObj:Object = new Object();
      
      public function TaskManager()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            taskListById[_loc2_.taskId] = _loc2_;
            _loc3_ = new Array();
            if(_loc2_.receiveRule.atAnyNpc)
            {
               _loc3_ = _loc3_.concat(_loc2_.receiveRule.atAnyNpc);
            }
            if(_loc2_.finishRule.atAnyNpc)
            {
               _loc3_ = _loc3_.concat(_loc2_.finishRule.atAnyNpc);
            }
            if(Boolean(_loc3_) && _loc3_.length > 0)
            {
               for each(_loc4_ in _loc3_)
               {
                  if(!npcTaskId[_loc4_])
                  {
                     npcTaskId[_loc4_] = new Array();
                  }
                  if(npcTaskId[_loc4_].indexOf(_loc2_.taskId) == -1)
                  {
                     npcTaskId[_loc4_].push(_loc2_.taskId);
                  }
               }
            }
         }
      }
      
      public static function obf_o_Y_4485() : Array
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in taskListById)
         {
            _loc3_ = taskListById[_loc2_];
            _loc4_ = new Object();
            _loc4_.taskId = _loc2_;
            _loc4_.receiveNpcName = new Array();
            for each(_loc5_ in _loc3_.receiveRule.atAnyNpc)
            {
               _loc4_.receiveNpcName.push(obf_b_p_3604.getNpcBriefName(_loc5_));
            }
            _loc4_.receiveCondition = new Array();
            for(_loc6_ in _loc3_.receiveRule.condition)
            {
               _loc4_.receiveCondition.push(ConditionScript.getConditionHTML(_loc6_,_loc3_.receiveRule.condition[_loc6_]));
            }
            _loc4_.finishNpcName = new Array();
            for each(_loc7_ in _loc3_.finishRule.atAnyNpc)
            {
               _loc4_.finishNpcName.push(obf_b_p_3604.getNpcBriefName(_loc7_));
            }
            _loc4_.finishCondition = new Array();
            for(_loc8_ in _loc3_.finishRule.condition)
            {
               _loc4_.finishCondition.push(ConditionScript.getConditionHTML(_loc8_,_loc3_.finishRule.condition[_loc8_]));
            }
            _loc1_.push(_loc4_);
         }
         return _loc1_;
      }
      
      public static function getTaskObjById(param1:int) : Object
      {
         return taskListById[param1];
      }
      
      public static function getTaskName(param1:int) : String
      {
         return JSONUtil.getStr(getTaskObjById(param1),["name"]);
      }
      
      public static function getNpcTaskIdList(param1:String) : Array
      {
         return npcTaskId[param1];
      }
      
      public static function getCanReceiveTask() : Array
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in taskObject)
         {
            _loc3_ = getTaskObjById(int(_loc2_));
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
         _loc1_.sortOn("kind",Array.NUMERIC);
         return _loc1_;
      }
      
      public static function get taskObject() : Object
      {
         return taskListById;
      }
      
      public static function get doneTasks() : Object
      {
         return taskRecorder != null ? taskRecorder.doneTasks : new Object();
      }
      
      public static function get doingTasks() : Array
      {
         return taskRecorder != null ? taskRecorder.doingTasks.concat() : [];
      }
      
      public static function isDoingAllocatorByTaskId(param1:int) : Boolean
      {
         return taskRecorder.getAllocatorByTaskId(param1) > 0;
      }
      
      public static function getAllocatorByTaskId(param1:int) : int
      {
         return taskRecorder.getAllocatorByTaskId(param1);
      }
      
      public static function isDoingAllocator(param1:int) : Boolean
      {
         return taskRecorder.doingAllocators[param1] != null;
      }
      
      public static function checkPromptTask(param1:int) : Boolean
      {
         var _loc4_:String = null;
         var _loc2_:Object = getTaskObjById(param1);
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["receiveRule","condition"]);
         for each(_loc4_ in ConditionScript.mainConditionSet)
         {
            if(_loc3_.hasOwnProperty(_loc4_) && !ConditionScript.obf_H_E_2430(_loc3_,_loc4_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function setDoingTasks(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(obf_K_e_3075.obf_0___5_510)
         {
            obf_K_e_3075.obf_0___5_510.clearTaskTracer();
         }
         for each(_loc2_ in param1)
         {
            addDoingTask(_loc2_);
         }
      }
      
      public static function addDoingTask(param1:int) : void
      {
         var _loc2_:Object = getTaskObjById(param1);
         if(_loc2_)
         {
            doingTaskObj[param1] = _loc2_;
            if(obf_K_e_3075.obf_0___5_510)
            {
               obf_K_e_3075.obf_0___5_510.addTaskTracer(param1);
            }
         }
      }
      
      public static function delDoingTask(param1:int) : void
      {
         delete doingTaskObj[param1];
         if(obf_K_e_3075.obf_0___5_510)
         {
            obf_K_e_3075.obf_0___5_510.delTaskTracer(param1);
         }
      }
      
      public static function getDoingTask() : Array
      {
         var _loc2_:String = null;
         if(!taskRecorder || !taskRecorder.doingTasks)
         {
            return [];
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in taskRecorder.doingTasks)
         {
            if(doingTaskObj[_loc2_])
            {
               _loc1_.push(doingTaskObj[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public static function get autoTaskId() : int
      {
         return JSONUtil.getInt(autoTaskConfig,["taskId"]);
      }
      
      public static function setAutoTask(param1:int) : void
      {
         autoTaskConfig = getTaskObjById(param1);
         isAutoTask = true;
      }
      
      public static function doAutoTask() : void
      {
         var _loc2_:String = null;
         if(!autoTaskConfig || !isAutoTask)
         {
            return;
         }
         if(WorldConfig.getValue("functionSwitch","autoTask"))
         {
            return;
         }
         var _loc1_:Object = JSONUtil.getObject(autoTaskConfig,["finishRule","condition"]);
         if(ConditionScript.checkCondition(_loc1_))
         {
            obf_R_6_1363.stopBot();
            if(GameContext.localPlayer.isUsingSkill)
            {
               setTimeout(doAutoTask,500);
               return;
            }
            obf_F_2_2975.obf_O_p_3236("moveToNpc " + JSONUtil.getStr(autoTaskConfig,["finishRule","atAnyNpc",0]));
            return;
         }
         for(_loc2_ in _loc1_)
         {
            if(!ConditionScript.obf_H_E_2430(_loc1_,_loc2_))
            {
               obf_W_c_3422(_loc1_,_loc2_);
               return;
            }
         }
      }
      
      public static function obf_W_c_3422(param1:Object, param2:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(param2 == "hasKilledMonster")
         {
            _loc3_ = param1[param2];
            for(_loc4_ in _loc3_)
            {
               if(!(obf_R_6_1363.isRuning && obf_R_6_1363.obf_L_A_4035 == _loc4_))
               {
                  if(GameContext.localPlayer.obf_i_S_846.getIntVar(_loc4_) < _loc3_[_loc4_])
                  {
                     _loc5_ = MonsterInfoUtil.getMonsterInfo(_loc4_);
                     obf_F_2_2975.obf_O_p_3236("MoveToDo " + _loc5_.atPlace + " startBot " + _loc4_);
                     return;
                  }
               }
            }
         }
         else if(param2 == "itemsInBag")
         {
            _loc6_ = param1["itemsInBag"];
            for(_loc7_ in _loc6_)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc7_) < _loc6_[_loc7_])
               {
                  obf_6_j_925(GameItemManager.getItemConfig(_loc7_));
                  return;
               }
            }
         }
         else if(param2 == "hasAnyItem")
         {
            for each(_loc8_ in param1[param2])
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc8_) < 1)
               {
                  obf_6_j_925(GameItemManager.getItemConfig(_loc8_));
                  return;
               }
            }
         }
      }
      
      public static function obf_6_j_925(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.atPlace) && !obf_L_l_4100.isEmpty(param1.atActionMacro))
         {
            obf_F_2_2975.obf_O_p_3236("MoveToDo " + param1.atPlace + " " + param1.atActionMacro);
         }
         else if(!obf_L_l_4100.isEmpty(param1.atPlace))
         {
            obf_F_2_2975.obf_O_p_3236("MoveTo " + param1.atPlace);
         }
      }
      
      public static function destroy() : void
      {
         taskRecorder = null;
         taskListById = new Object();
         npcTaskId = new Object();
         doingTaskObj = new Object();
      }
      
      public static function sendReceiveTask(param1:String, param2:int) : void
      {
         var _loc3_:PlayerReceiveTaskRequest = new PlayerReceiveTaskRequest();
         _loc3_.npcId = param1;
         _loc3_.taskId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendFinishTask(param1:String, param2:int) : void
      {
         var _loc3_:PlayerFinishTaskRequest = new PlayerFinishTaskRequest();
         _loc3_.npcId = param1;
         _loc3_.taskId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendAbortTask(param1:int) : void
      {
         var _loc2_:PlayerAbortTaskRequest = new PlayerAbortTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER)
         {
            onPlayerEnterWorld(param1 as PlayerEnterWorldAnswer);
         }
         else if(param1.code == CommandCodeTask.PLAYER_RECEIVE_TASK_NOTIFY)
         {
            onReceiveTask(param1 as PlayerReceiveTaskNotify);
         }
         else if(param1.code == CommandCodeTask.PLAYER_FINISH_TASK_NOTIFY)
         {
            onFinishTask(param1 as PlayerFinishTaskNotify);
         }
         else if(param1.code == CommandCodeTask.PLAYER_ABORT_TASK_NOTIFY)
         {
            onAbortTask(param1 as PlayerAbortTaskNotify);
         }
         obf_K_e_3075.obf_a_X_819();
      }
      
      private static function onPlayerEnterWorld(param1:PlayerEnterWorldAnswer) : void
      {
         taskRecorder = param1.taskRecorder;
         if(taskRecorder == null)
         {
            taskRecorder = new TaskRecorder();
         }
         setDoingTasks(taskRecorder.doingTasks);
         obf_K_e_3075.refreshTask();
         obf_K_e_3075.showUI(obf_K_e_3075.obf_0___5_510);
      }
      
      private static function onReceiveTask(param1:PlayerReceiveTaskNotify) : void
      {
         obf_0_K_4070.showWelcome("irt");
         taskRecorder.addDoingTask(param1.taskId,param1.taskAllocatorId);
         addDoingTask(param1.taskId);
         obf_K_e_3075.refreshTask();
         if(obf_K_e_3075.playerTaskUI)
         {
            obf_K_e_3075.playerTaskUI.taskList.selectedIndex = obf_K_e_3075.playerTaskUI.taskList.dataProvider.length - 1;
            obf_K_e_3075.playerTaskUI.refreshTaskShow();
         }
         var _loc2_:String = getTaskObjById(param1.taskId) != null ? getTaskObjById(param1.taskId).name : DiversityManager.getString("CommonPrompt","unknow");
         obf_K_e_3075.showTipInfo(DiversityManager.getString("TaskUI","receiveTask",[_loc2_]));
         obf_6_D_3816.print(DiversityManager.getString("TaskUI","receiveTask",[_loc2_]));
         PromptsManager.checkReceiveTask(param1.taskId);
         var _loc3_:Object = getTaskObjById(param1.taskId);
         if(JSONUtil.getInt(_loc3_,["kind"]) == 1)
         {
            setAutoTask(param1.taskId);
            setTimeout(doAutoTask,500);
         }
         obf_Z_j_930.onRefreshRewardTaskList(param1.taskId);
      }
      
      private static function onFinishTask(param1:PlayerFinishTaskNotify) : void
      {
         var taskObj:Object;
         var taskName:String;
         var thisNpc:AINpc = null;
         var cmd:PlayerFinishTaskNotify = param1;
         obf_0_K_4070.showWelcome("ift");
         taskRecorder.delDoingTask(cmd.taskId);
         taskRecorder.addDoneTask(cmd.taskId);
         delDoingTask(cmd.taskId);
         obf_K_e_3075.refreshTask();
         if(GameContext.localPlayer.fullInfo.constellationTaskId == cmd.taskId)
         {
            obf_K_e_3075.constellationUI.clearTaskContent();
            GameContext.localPlayer.fullInfo.constellationTaskId = 0;
            obf_K_e_3075.constellationUI.hideTaskButton();
         }
         taskObj = getTaskObjById(cmd.taskId);
         try
         {
            obf_H_l_800.call("onPlayerFinishTask",getTaskName(cmd.taskId));
         }
         catch(e:Error)
         {
         }
         taskName = taskObj != null ? taskObj.name : DiversityManager.getString("CommonPrompt","unknow");
         obf_K_e_3075.showTipInfo(DiversityManager.getString("TaskUI","finishTask",[taskName]));
         obf_6_D_3816.print(DiversityManager.getString("TaskUI","finishTask",[taskName]));
         if(Boolean(GameContext.currentMap) && Boolean(obf_b_p_3604.obf_h_n_3961 != "") && Boolean(taskObj.finishRule.atAnyNpc) && taskObj.finishRule.atAnyNpc.indexOf(obf_b_p_3604.obf_h_n_3961) > -1)
         {
            thisNpc = GameContext.currentMap.npcSet.getObject(obf_b_p_3604.obf_h_n_3961.split("@")[0]) as AINpc;
            if(thisNpc)
            {
               thisNpc.refreshTask();
            }
            if(Boolean(thisNpc) && Boolean(thisNpc.receiveTaskMenus.length > 0) && GameContext.localPlayer.getLineDistance(thisNpc) <= WorldConfig.MAX_NPC_TALK_DISTANCE)
            {
               obf_K_e_3075.showNpcTalkBox(thisNpc);
            }
         }
         if(WorldConfig.getNumberSetting("detachNoviceTask") > 0 && cmd.taskId == int(WorldConfig.getNumberSetting("detachNoviceTask")))
         {
            obf_K_e_3075.obf_0___V_239();
            GameContext.userConfig.dnc = true;
            GameContext.saveConfigNow();
         }
         if(cmd.taskId == autoTaskId)
         {
            autoTaskConfig = null;
         }
         obf_Z_j_930.onRefreshRewardTaskList(cmd.taskId);
      }
      
      private static function onAbortTask(param1:PlayerAbortTaskNotify) : void
      {
         taskRecorder.delDoingTask(param1.taskId);
         delDoingTask(param1.taskId);
         obf_K_e_3075.refreshTask();
         var _loc2_:String = getTaskObjById(param1.taskId) != null ? getTaskObjById(param1.taskId).name : DiversityManager.getString("CommonPrompt","unknow");
         obf_K_e_3075.showTipInfo(DiversityManager.getString("TaskUI","taskFailed",[_loc2_]));
         obf_6_D_3816.print(DiversityManager.getString("TaskUI","taskFailed",[_loc2_]));
         if(param1.taskId == autoTaskId)
         {
            autoTaskConfig = null;
         }
         obf_Z_j_930.onRefreshRewardTaskList(param1.taskId);
      }
   }
}

