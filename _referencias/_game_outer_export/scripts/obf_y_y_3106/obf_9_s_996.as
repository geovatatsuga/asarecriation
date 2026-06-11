package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.RewardAllTaskBoxMC;
   
   public class obf_9_s_996 extends RewardAllTaskBoxMC implements IPlayerUI
   {
      
      private var obf_0_7_9_626:Array;
      
      private var _taskButton:Object;
      
      public function obf_9_s_996()
      {
         super();
         this.initDiversity();
         this.addListener();
      }
      
      public function get getTasks() : Array
      {
         return this.obf_0_7_9_626;
      }
      
      public function setTasks(param1:Array) : void
      {
         this.obf_0_7_9_626 = param1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtPrompt,"rewardAllTaskBoxUI","txtPrompt");
         DiversityManager.setTextField(txtLastNum,"rewardAllTaskBoxUI","txtLastNum");
         var _loc1_:int = 1;
         while(_loc1_ <= 10)
         {
            this["cmdButton" + _loc1_].label = DiversityManager.getString("rewardAllTaskBoxUI","cmdButton");
            _loc1_++;
         }
      }
      
      private function addListener() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 10)
         {
            this["cmdButton" + _loc1_].addEventListener(MouseEvent.CLICK,this.onCmdButton);
            this["txtItem" + _loc1_].addEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 10)
         {
            this["cmdButton" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onCmdButton);
            this["txtItem" + _loc1_].removeEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      public function onCmdButton(param1:MouseEvent) : void
      {
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         if(!this._taskButton)
         {
            return;
         }
         var _loc2_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_R_O_1021);
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardAllTask");
         var _loc4_:int = _loc3_ ? _loc3_.numOfDay : 0;
         if(_loc4_ >= _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardAllTaskBoxUI","noNum"));
            return;
         }
         var _loc5_:int = int(this._taskButton[param1.currentTarget.name]);
         var _loc6_:Object = obf_Z_j_930.rewardAllTaskConfig(_loc5_);
         var _loc7_:String = JSONUtil.getStr(_loc6_,["numSign"]);
         var _loc8_:int = DynamicVars.systemVar.getIntVar(_loc7_);
         if(_loc8_ <= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardAllTaskBoxUI","noNum"));
            return;
         }
         var _loc9_:Array = TaskManager.getDoingTask();
         for each(_loc10_ in _loc9_)
         {
            _loc11_ = obf_Z_j_930.rewardAllTaskConfig(_loc10_.taskId);
            if(_loc11_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("rewardAllTaskBoxUI","noNum"));
               return;
            }
         }
         obf_Z_j_930.obf_Z_3_3453(_loc5_);
      }
      
      public function obf_p_d_982() : void
      {
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:String = null;
         var _loc15_:Object = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:int = 0;
         if(!this.obf_0_7_9_626)
         {
            return;
         }
         var _loc1_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_R_O_1021);
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardAllTask");
         var _loc3_:int = _loc2_ ? _loc2_.numOfDay : 0;
         DiversityManager.setTextField(txtLastNum,"rewardAllTaskBoxUI","txtLastNum",[_loc3_ + "/" + _loc1_]);
         this._taskButton = new Array();
         var _loc4_:int = 1;
         while(_loc4_ <= this.obf_0_7_9_626.length)
         {
            _loc5_ = int(this.obf_0_7_9_626[_loc4_ - 1]);
            _loc6_ = obf_Z_j_930.rewardAllTaskConfig(_loc5_);
            if(_loc6_)
            {
               this._taskButton["cmdButton" + _loc4_] = _loc5_;
               _loc7_ = JSONUtil.getInt(_loc6_,["color"]);
               _loc8_ = TaskManager.getTaskName(_loc5_);
               this["txtTaskName" + _loc4_].htmlText = this.setColor(_loc7_,_loc8_);
               _loc9_ = JSONUtil.getStr(_loc6_,["pic"]);
               obf_0_P_4381.obf_m_X_1194(_loc9_,this["pic" + _loc4_]);
               _loc10_ = JSONUtil.getInt(_loc6_,["star"]);
               this["txtStar" + _loc4_].text = this.setStar(_loc10_);
               _loc11_ = JSONUtil.getStr(_loc6_,["numSign"]);
               _loc12_ = DynamicVars.systemVar.getIntVar(_loc11_);
               DiversityManager.setTextField(this["txtNum" + _loc4_],"rewardAllTaskBoxUI","txtNum",[_loc12_]);
               _loc13_ = JSONUtil.getInt(_loc6_,["awardExp"]);
               DiversityManager.setTextField(this["txtExp" + _loc4_],"rewardAllTaskBoxUI","txtExp",[_loc13_]);
               _loc14_ = "";
               _loc15_ = JSONUtil.getObject(_loc6_,["awardItems"]);
               for(_loc16_ in _loc15_)
               {
                  _loc17_ = GameItemManager.getItemName(_loc16_);
                  _loc18_ = int(_loc15_[_loc16_]);
                  _loc14_ += obf_Z_j_930.getItemLinkCode(_loc17_,_loc16_) + "x" + _loc18_ + "\n";
               }
               this["txtItem" + _loc4_].htmlText = _loc14_;
            }
            _loc4_++;
         }
      }
      
      public function obf_L_T_4072() : void
      {
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc1_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_R_O_1021);
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardAllTask");
         var _loc3_:int = _loc2_ ? _loc2_.numOfDay : 0;
         DiversityManager.setTextField(txtLastNum,"rewardAllTaskBoxUI","txtLastNum",[_loc3_ + "/" + _loc1_]);
         var _loc4_:int = 1;
         while(_loc4_ <= this.obf_0_7_9_626.length)
         {
            _loc5_ = int(this.obf_0_7_9_626[_loc4_ - 1]);
            _loc6_ = obf_Z_j_930.rewardAllTaskConfig(_loc5_);
            if(_loc6_)
            {
               _loc7_ = JSONUtil.getStr(_loc6_,["numSign"]);
               _loc8_ = DynamicVars.systemVar.getIntVar(_loc7_);
               DiversityManager.setTextField(this["txtNum" + _loc4_],"rewardAllTaskBoxUI","txtNum",[_loc8_]);
            }
            _loc4_++;
         }
      }
      
      public function setColor(param1:int, param2:String) : String
      {
         if(param1 == 1)
         {
            return "<FONT COLOR=\'#FFFFFF\'>" + param2 + "</FONT>";
         }
         if(param1 == 2)
         {
            return "<FONT COLOR=\'#10A5E0\'>" + param2 + "</FONT>";
         }
         if(param1 == 3)
         {
            return "<FONT COLOR=\'#EDD78C\'>" + param2 + "</FONT>";
         }
         if(param1 == 4)
         {
            return "<FONT COLOR=\'#8F12BC\'>" + param2 + "</FONT>";
         }
         if(param1 == 5)
         {
            return "<FONT COLOR=\'#D25112\'>" + param2 + "</FONT>";
         }
         return "";
      }
      
      public function setStar(param1:int) : String
      {
         if(param1 == 1)
         {
            return "★";
         }
         if(param1 == 2)
         {
            return "★★";
         }
         if(param1 == 3)
         {
            return "★★★";
         }
         if(param1 == 4)
         {
            return "★★★★";
         }
         if(param1 == 5)
         {
            return "★★★★★";
         }
         return "";
      }
      
      public function onInfoLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
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
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

