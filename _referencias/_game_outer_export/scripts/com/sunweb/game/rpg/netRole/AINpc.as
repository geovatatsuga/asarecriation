package com.sunweb.game.rpg.netRole
{
   import obf_g_A_3629.obf_M_z_1692;
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.managers.obf_N_g_4386;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_l_4_4027;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.ui.MouseCursor;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.geom.Point;
   import img.NpcMapIcon;
   import img.NpcTaskIcon;
   
   public class AINpc extends obf_l_4_4027
   {
      
      private var config:Object;
      
      private var _npcName:String;
      
      private var _mapId:String;
      
      private var _fullId:String;
      
      private var _taskIdList:Array;
      
      private var canReceiveTask:Array;
      
      private var canFinishTask:Array;
      
      private var doingTask:Array;
      
      private var promptTask:Array;
      
      public var npcMapIcon:NpcMapIcon;
      
      public var npcSmallMapIcon:NpcMapIcon;
      
      private var npcTaskIcon:NpcTaskIcon;
      
      private var faceShow:obf_M_z_1692;
      
      private var randomSay:Array;
      
      private var randomSayTimeInv:TimeLimiter;
      
      public function AINpc(param1:Object, param2:String)
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         this.canReceiveTask = new Array();
         this.canFinishTask = new Array();
         this.doingTask = new Array();
         this.promptTask = new Array();
         this.npcMapIcon = new NpcMapIcon();
         this.npcSmallMapIcon = new NpcMapIcon();
         this.npcTaskIcon = new NpcTaskIcon();
         this.randomSayTimeInv = new TimeLimiter(10000 + Math.random() * 20000);
         this.config = param1;
         super(this.config.modelCode);
         this.id = this.config.id;
         this._npcName = this.config.name;
         this._fullId = this.id + "@" + param2;
         this._mapId = param2;
         this.randomSay = this.config.randomSay;
         this._taskIdList = TaskManager.getNpcTaskIdList(this._fullId);
         this.obf_t_F_1534(obf_D_0_1300.nameToDirection(param1.direction));
         this.moveToPixel(this.config.px,this.config.py);
         this.npcMapIcon.txtName.text = this._npcName;
         this.npcMapIcon.gotoAndStop(1);
         this.npcSmallMapIcon.txtName.text = this._npcName;
         this.npcSmallMapIcon.gotoAndStop(1);
         this.npcTaskIcon.y = this.getTopmostY() - 30;
         this.npcTaskIcon.gotoAndStop(1);
         this.addChild(this.npcTaskIcon);
         this.refreshTask();
         var _loc3_:String = "";
         if(Boolean(DynamicVars.systemVar) && !obf_L_l_4100.isEmpty(DynamicVars.systemVar.getStrVar("#ldz_winner")))
         {
            _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_G_I_2446.toString(16) + "\'>" + DynamicVars.systemVar.getStrVar("#ldz_winner") + "</font>\r";
         }
         _loc3_ += this._npcName;
         this.setAndShowLabel(_loc3_);
         if(!obf_L_l_4100.isEmpty(param1.sigIconRes))
         {
            _loc4_ = String(param1.sigIconRes).split(",");
            for each(_loc5_ in _loc4_)
            {
               this.showAlwaysEffect(param1.id + "_" + _loc5_,_loc5_);
            }
         }
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("n_" + this.config.modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(this.config.modelCode));
         _loc1_.load();
      }
      
      override protected function obf_K_Y_3943() : void
      {
         super.obf_K_Y_3943();
         this.doAction(this.config.actionName,-1,true);
      }
      
      override protected function checkAndCreateActions(param1:Event) : void
      {
         super.checkAndCreateActions(param1);
         this.doAction(this.config.actionName,-1,true);
      }
      
      public function get defaultTalk() : String
      {
         return this.config.defaultTalk;
      }
      
      public function get obf_0_5_e_341() : String
      {
         return JSONUtil.getStr(this.config,["headIconRes"]);
      }
      
      public function get menus() : Array
      {
         return this.config.menus;
      }
      
      public function get mapId() : String
      {
         return this._mapId;
      }
      
      public function get receiveTaskMenus() : Array
      {
         return this.canReceiveTask;
      }
      
      public function get finishTaskMenus() : Array
      {
         return this.canFinishTask;
      }
      
      public function get doingTaskMenus() : Array
      {
         return this.doingTask;
      }
      
      public function get promptTaskMenus() : Array
      {
         return this.promptTask;
      }
      
      public function get npcName() : String
      {
         return this._npcName;
      }
      
      public function get npcConfig() : Object
      {
         return this.config;
      }
      
      override public function say(param1:String, param2:int = 5) : void
      {
         param1 = "<textformat leading=\'10\'>" + param1 + "</textformat>";
         param1 = obf_r_Y_1874.obf_y_Q_3915(param1);
         super.say(param1,param2);
         if(!this.faceShow)
         {
            this.faceShow = new obf_M_z_1692(this.obf_C_a_2892.txtLabel);
            this.faceShow.getFace = obf_N_g_4386.getFaceDisplay;
         }
         this.faceShow.refresh();
      }
      
      override protected function updateSayLabel() : void
      {
         super.updateSayLabel();
         if(this.obf_C_a_2892 == null && Boolean(this.faceShow))
         {
            this.faceShow.destroy();
            this.faceShow = null;
         }
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         if(this.isTracked == param1)
         {
            return;
         }
         super.isTracked = param1;
         if(param1 && GameContext.currentMap.containsPoint(new Point(GameContext.gameStage.mouseX,GameContext.gameStage.mouseY)))
         {
            obf_e_P_918.useCursor(MouseCursor.CURSOR_DIALOG);
         }
         else
         {
            obf_K_e_3075.obf_S_Y_4185();
         }
      }
      
      public function refreshTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         if(Boolean(this.isInStage && this.randomSay) && Boolean(this.randomSay.length > 0) && this.randomSayTimeInv.checkTimeout())
         {
            this.say(this.randomSay[int(Math.random() * this.randomSay.length)]);
            this.randomSayTimeInv = new TimeLimiter(10000 + Math.random() * 20000);
         }
         this.canReceiveTask = new Array();
         this.canFinishTask = new Array();
         this.doingTask = new Array();
         this.promptTask = new Array();
         for each(_loc1_ in this._taskIdList)
         {
            _loc3_ = TaskManager.getTaskObjById(_loc1_);
            if(_loc3_)
            {
               if(Boolean(_loc3_.finishRule.atAnyNpc) && Boolean(_loc3_.finishRule.atAnyNpc.indexOf(this._fullId) > -1) && TaskManager.doingTasks.indexOf(_loc1_) > -1)
               {
                  if(Boolean(_loc3_.finishRule) && Boolean(_loc3_.finishRule.activityForFinish) && _loc3_.finishRule.activityForFinish.length > 0)
                  {
                     if(!obf_J_F_3431.obf_U_Q_3887(_loc3_.finishRule.activityForFinish))
                     {
                        continue;
                     }
                  }
                  _loc4_ = _loc3_.finishRule.condition;
                  if(!_loc4_ || ConditionScript.checkCondition(_loc4_))
                  {
                     this.canFinishTask.push(_loc3_);
                  }
                  else
                  {
                     this.doingTask.push(_loc3_);
                  }
               }
               if(Boolean(_loc3_.receiveRule && _loc3_.receiveRule.atAnyNpc) && Boolean(_loc3_.receiveRule.atAnyNpc.indexOf(this._fullId) > -1) && TaskManager.doingTasks.indexOf(_loc1_) == -1)
               {
                  if(Boolean(_loc3_.receiveRule.activityForReceive) && _loc3_.receiveRule.activityForReceive.length > 0)
                  {
                     if(!obf_J_F_3431.obf_U_Q_3887(_loc3_.receiveRule.activityForReceive))
                     {
                        continue;
                     }
                  }
                  if(!_loc3_.receiveRule.repeatable)
                  {
                     _loc7_ = TaskManager.doneTasks;
                     if((Boolean(_loc7_)) && _loc7_[_loc1_] > 0)
                     {
                        continue;
                     }
                  }
                  _loc5_ = _loc3_.receiveRule.condition;
                  _loc6_ = 1;
                  if(!_loc5_ || ConditionScript.checkCondition(_loc5_))
                  {
                     this.canReceiveTask.push(_loc3_);
                  }
                  else if(TaskManager.checkPromptTask(_loc1_))
                  {
                     this.promptTask.push(_loc3_);
                  }
               }
            }
         }
         this.npcMapIcon.gotoAndStop(1);
         this.npcSmallMapIcon.gotoAndStop(1);
         this.npcTaskIcon.gotoAndStop(1);
         for each(_loc2_ in this.config.menus)
         {
            if(_loc2_.functionIndex == 3)
            {
               if(!(Boolean(_loc2_.hideRule) && Boolean(!ConditionScript.isEmptyPar(_loc2_.hideRule)) && ConditionScript.checkCondition(_loc2_.hideRule)))
               {
                  if(!(Boolean(_loc2_.showRule) && !ConditionScript.checkCondition(_loc2_.showRule)))
                  {
                     if(!(Boolean(_loc2_.condition) && !ConditionScript.checkCondition(_loc2_.condition)))
                     {
                        this.npcMapIcon.gotoAndStop("dayTask");
                        this.npcSmallMapIcon.gotoAndStop("dayTask");
                        this.npcTaskIcon.gotoAndStop("dayTask");
                        break;
                     }
                  }
               }
            }
         }
         if(this.promptTask.length > 0)
         {
            this.npcMapIcon.gotoAndStop("promptTask");
            this.npcSmallMapIcon.gotoAndStop("promptTask");
            this.npcTaskIcon.gotoAndStop("promptTask");
         }
         if(this.doingTask.length > 0)
         {
            this.npcMapIcon.gotoAndStop("doingTask");
            this.npcSmallMapIcon.gotoAndStop("doingTask");
            this.npcTaskIcon.gotoAndStop("doingTask");
         }
         if(this.canReceiveTask.length > 0)
         {
            this.npcMapIcon.gotoAndStop("canReceiveTask");
            this.npcSmallMapIcon.gotoAndStop("canReceiveTask");
            this.npcTaskIcon.gotoAndStop("canReceiveTask");
         }
         if(this.canFinishTask.length > 0)
         {
            this.npcMapIcon.gotoAndStop("canFinishTask");
            this.npcSmallMapIcon.gotoAndStop("canFinishTask");
            this.npcTaskIcon.gotoAndStop("canFinishTask");
         }
      }
      
      override public function destroy() : void
      {
         this.canFinishTask = null;
         this.canReceiveTask = null;
         this.promptTask = null;
         super.destroy();
      }
   }
}

