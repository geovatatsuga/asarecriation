package obf_a_F_1055
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_o_I_4492 extends obf_0_6_b_250
   {
      
      public static const obf_T_B_1270:String = "CloseTask";
      
      public static const obf_K_6_4447:String = "TalkTask";
      
      public static const obf_W_W_3673:String = "ReceiveTask";
      
      public static const obf_A_Y_3125:String = "FinishTask";
      
      private var _taskId:int;
      
      private var _taskObj:Object;
      
      private var currentTalkIndex:int;
      
      private var obf_D_q_1083:Object;
      
      private var obf_f_c_2150:String;
      
      public function obf_o_I_4492(param1:Object, param2:int, param3:int = -1, param4:String = "")
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:PeriodCounterItemInfo = null;
         var _loc11_:String = null;
         super();
         this._taskId = param2;
         this._taskObj = param1;
         this.obf_f_c_2150 = param4;
         this.currentTalkIndex = param3;
         if(Boolean(this.currentTalkIndex >= 0) && Boolean(param1.talks) && this.currentTalkIndex < param1.talks.length)
         {
            this.obf_D_q_1083 = param1.talks[this.currentTalkIndex];
         }
         if(param3 == -1)
         {
            _loc5_ = "";
            _loc5_ = JSONUtil.getStr(param1,["label"]);
            if(obf_L_l_4100.isEmpty(_loc5_))
            {
               _loc5_ = TaskManager.getTaskObjById(param2).name || DiversityManager.getString("CommonPrompt","unknow");
            }
            _loc6_ = TaskManager.getTaskObjById(this._taskId);
            _loc9_ = "";
            _loc5_ = obf_K_e_3075.getSwitchString(_loc5_);
            if(param4 == obf_W_W_3673)
            {
               _loc10_ = obf_Y_F_1424.getCounter(this._taskId + "");
               if(JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerDay"]) > 0)
               {
                  _loc8_ = JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerDay"]);
                  _loc7_ = _loc8_ - JSONUtil.getInt(_loc10_,["numOfDay"]);
               }
               else if(JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerWeek"]) > 0)
               {
                  _loc8_ = JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerWeek"]);
                  _loc7_ = _loc8_ - JSONUtil.getInt(_loc10_,["numOfWeek"]);
               }
               else if(JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerMonth"]) > 0)
               {
                  _loc8_ = JSONUtil.getInt(_loc6_,["receiveRule","repeatRule","numberLimitPerMonth"]);
                  _loc7_ = _loc8_ - JSONUtil.getInt(_loc10_,["numOfMonth"]);
               }
               if(_loc8_ > 0)
               {
                  _loc9_ = DiversityManager.getString("NpcTalkUI","menuCounter",[_loc7_,_loc8_]);
               }
            }
            txtLabel.text = _loc5_ + _loc9_;
         }
         else if(param4 == obf_T_B_1270)
         {
            if(Boolean(this.obf_D_q_1083) && Boolean(this.obf_D_q_1083.noLable))
            {
               txtLabel.text = this.obf_D_q_1083.noLable;
            }
            else
            {
               DiversityManager.setTextField(txtLabel,"NpcPrompt","menuClose",null,true);
            }
         }
         else
         {
            _loc11_ = "";
            if(obf_L_l_4100.isEmpty(_loc11_))
            {
               _loc11_ = JSONUtil.getStr(this.obf_D_q_1083,["yesLable"]);
            }
            if(obf_L_l_4100.isEmpty(_loc11_))
            {
               if(this.currentTalkIndex >= this._taskObj.talks.length - 1)
               {
                  if(param4 == obf_W_W_3673)
                  {
                     _loc11_ = DiversityManager.getString("NpcTalkUI","receiveTask",[JSONUtil.getStr(TaskManager.getTaskObjById(param2),["name"])]);
                  }
                  else if(param4 == obf_A_Y_3125)
                  {
                     _loc11_ = DiversityManager.getString("NpcTalkUI","finishTask",[JSONUtil.getStr(TaskManager.getTaskObjById(param2),["name"])]);
                  }
               }
               else
               {
                  _loc11_ = DiversityManager.getString("NpcTalkUI","clickToContinue");
               }
            }
            txtLabel.text = _loc11_;
         }
      }
      
      override public function obf_5_y_948() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         super.obf_5_y_948();
         if(!obf_i_7_4475)
         {
            return;
         }
         obf_i_7_4475.clearContent();
         if(this.obf_f_c_2150 == obf_T_B_1270)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            return;
         }
         if(this.currentTalkIndex >= this._taskObj.talks.length - 2 && Boolean(obf_i_7_4475))
         {
            obf_i_7_4475.showTaskAward(this._taskId);
         }
         if(this.currentTalkIndex < this._taskObj.talks.length - 1)
         {
            obf_i_7_4475.addMenu(new obf_o_I_4492(this._taskObj,this._taskId,this.currentTalkIndex + 1,this.obf_f_c_2150));
            obf_i_7_4475.setTalkContent(this._taskObj.talks[this.currentTalkIndex + 1].talk);
            if(JSONUtil.getStr(this._taskObj,["talks",this.currentTalkIndex + 1,"speaker"]) == "i")
            {
               obf_i_7_4475.showPlayerTalkHeadIcon();
            }
            else
            {
               _loc1_ = this._taskObj.talks[this.currentTalkIndex + 1];
               if(_loc1_.noLable)
               {
                  obf_i_7_4475.addMenu(new obf_o_I_4492(this._taskObj,this._taskId,this.currentTalkIndex + 1,obf_T_B_1270));
               }
               obf_i_7_4475.showNpcHeadIcon();
            }
         }
         else if(this.obf_f_c_2150 == obf_K_6_4447)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(this.obf_f_c_2150 == obf_W_W_3673)
         {
            if(TaskManager.doingTasks.indexOf(this._taskId) > -1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("NpcPrompt","taskError_havedTask"));
               obf_K_e_3075.npcTalkBox.refreshMenu();
               return;
            }
            _loc2_ = TaskManager.getTaskObjById(this._taskId);
            if(!ConditionScript.checkCondition(JSONUtil.getObject(_loc2_,["receiveRule","condition"]),null,true))
            {
               obf_K_e_3075.npcTalkBox.refreshMenu();
               return;
            }
            TaskManager.sendReceiveTask(obf_i_7_4475.npcId,this._taskId);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(this.obf_f_c_2150 == obf_A_Y_3125)
         {
            if(TaskManager.doingTasks.indexOf(this._taskId) <= -1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("NpcPrompt","taskError_notHaveTask"));
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               return;
            }
            TaskManager.sendFinishTask(obf_i_7_4475.npcId,this._taskId);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
      }
   }
}

