package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
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
   import playerUI.RewardPlayerTaskBoxMC;
   
   public class obf_K_x_958 extends RewardPlayerTaskBoxMC implements IPlayerUI
   {
      
      public static var obf_F_Q_3660:int = 0;
      
      private var varList:Array;
      
      public function obf_K_x_958()
      {
         super();
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         this.varList = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = obf_Z_j_930.rewardPlayerTaskByStar(_loc1_);
            if(_loc2_)
            {
               _loc3_ = DiversityManager.getString("rewardPlayerTaskBoxUI","txtInName");
               this["txtInName" + _loc1_].htmlText = this.setColor(_loc1_,_loc3_);
               _loc4_ = JSONUtil.getStr(_loc2_,["totalSign"]);
               this.varList.push(_loc4_);
               _loc5_ = JSONUtil.getStr(_loc2_,["numSign"]);
               this.varList.push(_loc5_);
               this["cmdInButton" + _loc1_].label = DiversityManager.getString("rewardPlayerTaskBoxUI","cmdInButton");
               _loc6_ = DiversityManager.getString("rewardPlayerTaskBoxUI","txtOutName");
               this["txtOutName" + _loc1_].htmlText = this.setColor(_loc1_,_loc6_);
               _loc7_ = JSONUtil.getObject(_loc2_,["outItems"]);
               var _loc13_:int = 0;
               var _loc14_:* = _loc7_;
               for(_loc8_ in _loc14_)
               {
                  _loc10_ = int(_loc7_[_loc8_]);
                  _loc11_ = GameItemManager.getItemName(_loc8_);
                  _loc12_ = obf_Z_j_930.getItemLinkCode(_loc11_,_loc8_) + "x" + _loc10_;
                  DiversityManager.setTextField(this["txtItem" + _loc1_],"rewardPlayerTaskBoxUI","txtItem",[_loc12_],true);
               }
               _loc9_ = JSONUtil.getInt(_loc2_,["awardExp"]);
               DiversityManager.setTextField(this["txtExp" + _loc1_],"rewardPlayerTaskBoxUI","txtExp",[_loc9_]);
               this["cmdOutButton" + _loc1_].label = DiversityManager.getString("rewardPlayerTaskBoxUI","cmdOutButton");
            }
            _loc1_++;
         }
      }
      
      public function obf_p_9_2847() : void
      {
         var _loc1_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_q_9_2529);
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardPlayerInTask");
         var _loc3_:int = _loc2_ ? _loc2_.numOfDay : 0;
         DiversityManager.setTextField(txtInInfo,"rewardPlayerTaskBoxUI","txtInInfo",[_loc3_ + "/" + _loc1_]);
      }
      
      public function obf_Y_G_1757() : void
      {
         var _loc1_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_0_4_2_272);
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardPlayerOutTask");
         var _loc3_:int = _loc2_ ? _loc2_.numOfDay : 0;
         DiversityManager.setTextField(txtOutInfo,"rewardPlayerTaskBoxUI","txtOutInfo",[_loc3_ + "/" + _loc1_]);
      }
      
      public function refreshPlayerTask() : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = obf_Z_j_930.rewardPlayerTaskByStar(_loc1_);
            if(_loc2_)
            {
               _loc3_ = JSONUtil.getStr(_loc2_,["totalSign"]);
               _loc4_ = DynamicVars.systemVar.getIntVar(_loc3_);
               DiversityManager.setTextField(this["txtAllInfo" + _loc1_],"rewardPlayerTaskBoxUI","txtAllInfo",[_loc4_]);
               _loc5_ = JSONUtil.getStr(_loc2_,["numSign"]);
               _loc6_ = DynamicVars.systemVar.getIntVar(_loc5_);
               DiversityManager.setTextField(this["txtLastNum" + _loc1_],"rewardPlayerTaskBoxUI","txtLastNum",[_loc6_]);
            }
            _loc1_++;
         }
      }
      
      public function isValid(param1:String) : Boolean
      {
         if(!this.varList)
         {
            return false;
         }
         return this.varList.indexOf(param1) >= 0;
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
      
      private function addListener() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            this["cmdInButton" + _loc1_].addEventListener(MouseEvent.CLICK,this.cmdInButton);
            this["cmdOutButton" + _loc1_].addEventListener(MouseEvent.CLICK,this.cmdOutButton);
            this["txtItem" + _loc1_].addEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            this["cmdInButton" + _loc1_].removeEventListener(MouseEvent.CLICK,this.cmdInButton);
            this["cmdOutButton" + _loc1_].removeEventListener(MouseEvent.CLICK,this.cmdOutButton);
            this["txtItem" + _loc1_].removeEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      public function cmdInButton(param1:MouseEvent) : void
      {
         var _loc10_:Object = null;
         var _loc11_:int = 0;
         var _loc2_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_q_9_2529);
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardPlayerInTask");
         var _loc4_:int = _loc3_ ? _loc3_.numOfDay : 0;
         if(_loc4_ >= _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardPlayerTaskBoxUI","noNum"));
            return;
         }
         var _loc5_:int = 0;
         if(param1.currentTarget == cmdInButton1)
         {
            _loc5_ = 1;
         }
         else if(param1.currentTarget == cmdInButton2)
         {
            _loc5_ = 2;
         }
         else if(param1.currentTarget == cmdInButton3)
         {
            _loc5_ = 3;
         }
         else if(param1.currentTarget == cmdInButton4)
         {
            _loc5_ = 4;
         }
         else if(param1.currentTarget == cmdInButton5)
         {
            _loc5_ = 5;
         }
         var _loc6_:Object = obf_Z_j_930.rewardPlayerTaskByStar(_loc5_);
         var _loc7_:String = JSONUtil.getStr(_loc6_,["numSign"]);
         var _loc8_:int = DynamicVars.systemVar.getIntVar(_loc7_);
         if(_loc8_ <= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardPlayerTaskBoxUI","noTask"));
            return;
         }
         var _loc9_:Array = TaskManager.getDoingTask();
         for each(_loc10_ in obf_Z_j_930.obf_8_a_1746)
         {
            _loc11_ = JSONUtil.getInt(_loc10_,["allocatorId"]);
            if(TaskManager.isDoingAllocator(_loc11_))
            {
               WindowManager.showMessageBox(DiversityManager.getString("rewardAllTaskBoxUI","noNum"));
               return;
            }
         }
         if(_loc5_ > 0)
         {
            obf_Z_j_930.obf_U_c_3615(_loc5_);
         }
      }
      
      public function cmdOutButton(param1:MouseEvent) : void
      {
         var _loc8_:String = null;
         var _loc2_:int = obf_Z_j_930.getNum(obf_K_e_3075.obf_w_0_3587.getAllLevel,obf_Z_j_930.obf_0_4_2_272);
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardPlayerOutTask");
         var _loc4_:int = _loc3_ ? _loc3_.numOfDay : 0;
         if(_loc4_ >= _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardPlayerTaskBoxUI","noOutNum"));
            return;
         }
         var _loc5_:int = 0;
         if(param1.currentTarget == cmdOutButton1)
         {
            _loc5_ = 1;
         }
         else if(param1.currentTarget == cmdOutButton2)
         {
            _loc5_ = 2;
         }
         else if(param1.currentTarget == cmdOutButton3)
         {
            _loc5_ = 3;
         }
         else if(param1.currentTarget == cmdOutButton4)
         {
            _loc5_ = 4;
         }
         else if(param1.currentTarget == cmdOutButton5)
         {
            _loc5_ = 5;
         }
         var _loc6_:Object = obf_Z_j_930.rewardPlayerTaskByStar(_loc5_);
         var _loc7_:Object = JSONUtil.getObject(_loc6_,["outItems"]);
         if(_loc7_)
         {
            for(_loc8_ in _loc7_)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc8_) < _loc7_[_loc8_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("rewardShopBoxUI","noItem"));
                  return;
               }
            }
         }
         if(_loc5_ > 0)
         {
            obf_Z_j_930.obf_0_2_h_82(_loc5_);
         }
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

