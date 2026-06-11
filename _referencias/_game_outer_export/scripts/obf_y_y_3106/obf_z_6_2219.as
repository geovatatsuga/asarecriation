package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.data.DataProvider;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.RewardSuccessBoxMC;
   
   public class obf_z_6_2219 extends RewardSuccessBoxMC implements IPlayerUI
   {
      
      private var obf_W_0_1373:Array = new Array();
      
      private var obf_a_5_2880:Array = new Array();
      
      private var _kind:String;
      
      public function obf_z_6_2219()
      {
         super();
         this.initDiversity();
         playerBar.gotoAndStop(1);
         allBar.gotoAndStop(1);
         this._kind = JSONUtil.getStr(obf_j_Y_1351.types,[3]);
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("rewardSuccessBoxUI","listName"));
         _loc2_.width = 100;
         _loc2_.dataField = "name";
         _loc2_.editable = false;
         _loc2_.sortable = false;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("rewardSuccessBoxUI","listDoneTimes"));
         _loc3_.dataField = "name";
         _loc3_.labelFunction = this.listSuccessSitLabel;
         _loc3_.editable = false;
         _loc3_.sortable = false;
         _loc1_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("rewardSuccessBoxUI","listAddSp"));
         _loc4_.dataField = "name";
         _loc4_.labelFunction = this.listSuccessSpLabel;
         _loc4_.editable = false;
         _loc4_.sortable = false;
         _loc1_.push(_loc4_);
         var _loc5_:DataGridColumn = new DataGridColumn(DiversityManager.getString("rewardSuccessBoxUI","listComplete"));
         _loc5_.dataField = "name";
         _loc5_.labelFunction = this.listSuccessDoneLabel;
         _loc5_.editable = false;
         _loc5_.sortable = false;
         _loc1_.push(_loc5_);
         listSuccess.columns = _loc1_;
         this.addListener();
      }
      
      public function get playerSpArray() : Array
      {
         return this.obf_W_0_1373;
      }
      
      public function setPlayerSpArray(param1:Array) : void
      {
         this.obf_W_0_1373 = param1;
      }
      
      public function get allSpArray() : Array
      {
         return this.obf_a_5_2880;
      }
      
      public function setAllSpArray(param1:Array) : void
      {
         this.obf_a_5_2880 = param1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtConTitle,"rewardSuccessBoxUI","txtConTitle");
         DiversityManager.setTextField(txtPlayerTitle,"rewardSuccessBoxUI","txtPlayerTitle");
         DiversityManager.setTextField(txtAllTitle,"rewardSuccessBoxUI","txtAllTitle");
         DiversityManager.setTextField(txtLeftP0,"rewardSuccessBoxUI","listSp");
         DiversityManager.setTextField(txtRightP0,"rewardSuccessBoxUI","listAward");
         DiversityManager.setTextField(txtLeftA0,"rewardSuccessBoxUI","listSp");
         DiversityManager.setTextField(txtRightA0,"rewardSuccessBoxUI","listAward");
         cmdPlayer.label = DiversityManager.getString("rewardSuccessBoxUI","cmdPlayer");
         cmdAll.label = DiversityManager.getString("rewardSuccessBoxUI","cmdAll");
      }
      
      public function obf_V_T_3922() : void
      {
         var _loc15_:Object = null;
         var _loc16_:Object = null;
         var _loc17_:int = 0;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:Object = null;
         var _loc21_:int = 0;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc1_:Array = obf_j_Y_1351.getSuccessConfigByType(this._kind);
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc15_ = _loc1_[_loc3_];
            if(_loc15_.subKind != _loc2_)
            {
               _loc1_.splice(_loc3_,0,{
                  "name":DiversityManager.getString("SuccessUI","listSubTypeShow",[_loc15_.subKind]),
                  "isNone":true
               });
               _loc2_ = _loc15_.subKind;
            }
            _loc3_++;
         }
         listSuccess.dataProvider = new DataProvider(_loc1_);
         listSuccess.invalidateList();
         var _loc4_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc5_:Array = this.getArrayByObject(JSONUtil.getObject(_loc4_,["playerItems"]));
         var _loc6_:int = 1;
         while(_loc6_ < 18)
         {
            if(_loc6_ > _loc5_.length)
            {
               break;
            }
            _loc16_ = _loc5_[_loc6_ - 1];
            _loc17_ = int(_loc16_["needSp"]);
            _loc18_ = _loc16_["itemCode"];
            if(Boolean(this.playerSpArray) && this.playerSpArray.indexOf(_loc17_) >= 0)
            {
               this["txtLeftP" + _loc6_].text = "√" + _loc17_;
            }
            else
            {
               this["txtLeftP" + _loc6_].text = _loc17_ + "";
            }
            _loc19_ = GameItemManager.getItemName(_loc18_);
            this["txtRightP" + _loc6_].htmlText = obf_Z_j_930.getItemLinkCode(_loc19_,_loc18_);
            _loc6_++;
         }
         var _loc7_:int = int(_loc5_[_loc5_.length - 1]["needSp"]);
         var _loc8_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(_loc4_,["playerSpSign"]));
         var _loc9_:int = _loc8_ * 100 / _loc7_;
         playerBar.gotoAndStop(_loc9_);
         var _loc10_:Array = this.getArrayByObject(JSONUtil.getObject(_loc4_,["allItems"]));
         var _loc11_:int = 1;
         while(_loc11_ < 18)
         {
            if(_loc11_ > _loc10_.length)
            {
               break;
            }
            _loc20_ = _loc10_[_loc11_ - 1];
            _loc21_ = int(_loc20_["needSp"]);
            _loc22_ = _loc20_["itemCode"];
            if(Boolean(this.allSpArray) && this.allSpArray.indexOf(_loc21_) >= 0)
            {
               this["txtLeftA" + _loc11_].text = "√" + _loc21_;
            }
            else
            {
               this["txtLeftA" + _loc11_].text = _loc21_ + "";
            }
            _loc23_ = GameItemManager.getItemName(_loc22_);
            this["txtRightA" + _loc11_].htmlText = obf_Z_j_930.getItemLinkCode(_loc23_,_loc22_);
            _loc11_++;
         }
         var _loc12_:int = int(_loc10_[_loc10_.length - 1]["needSp"]);
         var _loc13_:int = DynamicVars.systemVar.getIntVar(JSONUtil.getStr(_loc4_,["allSpSign"]));
         var _loc14_:int = _loc13_ * 100 / _loc12_;
         allBar.gotoAndStop(_loc14_);
      }
      
      public function obf_H_j_1911() : void
      {
         var _loc1_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc2_:Array = this.getArrayByObject(JSONUtil.getObject(_loc1_,["playerItems"]));
         var _loc3_:int = int(_loc2_[_loc2_.length - 1]["needSp"]);
         var _loc4_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(_loc1_,["playerSpSign"]));
         var _loc5_:int = _loc4_ * 100 / _loc3_;
         playerBar.gotoAndStop(_loc5_);
      }
      
      public function obf_h_X_832() : void
      {
         var _loc1_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc2_:Array = this.getArrayByObject(JSONUtil.getObject(_loc1_,["allItems"]));
         var _loc3_:int = int(_loc2_[_loc2_.length - 1]["needSp"]);
         var _loc4_:int = DynamicVars.systemVar.getIntVar(JSONUtil.getStr(_loc1_,["allSpSign"]));
         var _loc5_:int = _loc4_ * 100 / _loc3_;
         allBar.gotoAndStop(_loc5_);
      }
      
      public function getArrayByObject(param1:Object) : Array
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = new Object();
            _loc5_["needSp"] = _loc3_;
            _loc5_["itemCode"] = _loc4_;
            _loc2_.push(_loc5_);
         }
         _loc2_.sortOn("needSp",Array.NUMERIC);
         return _loc2_;
      }
      
      private function addListener() : void
      {
         listSuccess.addEventListener(Event.CHANGE,this.obf_f_O_1450);
         cmdPlayer.addEventListener(MouseEvent.CLICK,this.obf_M_O_4004);
         cmdAll.addEventListener(MouseEvent.CLICK,this.obf_q_d_2200);
         playerBar.addEventListener(MouseEvent.MOUSE_OVER,this.obf_l_K_3204);
         playerBar.addEventListener(MouseEvent.MOUSE_OUT,this.obf_E_o_2105);
         allBar.addEventListener(MouseEvent.MOUSE_OVER,this.obf_P_w_2944);
         allBar.addEventListener(MouseEvent.MOUSE_OUT,this.obf_P_t_2055);
         var _loc1_:int = 1;
         while(_loc1_ < 18)
         {
            this["txtRightP" + _loc1_].addEventListener(TextEvent.LINK,this.onInfoLink);
            this["txtRightA" + _loc1_].addEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         listSuccess.removeEventListener(Event.CHANGE,this.obf_f_O_1450);
         cmdPlayer.removeEventListener(MouseEvent.CLICK,this.obf_M_O_4004);
         cmdAll.removeEventListener(MouseEvent.CLICK,this.obf_q_d_2200);
         playerBar.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_l_K_3204);
         playerBar.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_E_o_2105);
         allBar.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_P_w_2944);
         allBar.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_P_t_2055);
         var _loc1_:int = 1;
         while(_loc1_ < 18)
         {
            this["txtRightP" + _loc1_].removeEventListener(TextEvent.LINK,this.onInfoLink);
            this["txtRightA" + _loc1_].removeEventListener(TextEvent.LINK,this.onInfoLink);
            _loc1_++;
         }
      }
      
      private function obf_l_K_3204(param1:MouseEvent) : void
      {
         var _loc2_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc3_:Array = this.getArrayByObject(JSONUtil.getObject(_loc2_,["playerItems"]));
         var _loc4_:int = int(_loc3_[_loc3_.length - 1]["needSp"]);
         var _loc5_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(_loc2_,["playerSpSign"]));
         var _loc6_:GameTipUI = new GameTipUI("tipPlayerBar");
         var _loc7_:String = _loc5_ + "/" + _loc4_;
         _loc6_.addTipInfo(_loc7_,120,1);
         GameTipManager.showTip(_loc6_);
      }
      
      private function obf_E_o_2105(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("tipPlayerBar");
      }
      
      private function obf_P_w_2944(param1:MouseEvent) : void
      {
         var _loc2_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc3_:Array = this.getArrayByObject(JSONUtil.getObject(_loc2_,["allItems"]));
         var _loc4_:int = int(_loc3_[_loc3_.length - 1]["needSp"]);
         var _loc5_:int = DynamicVars.systemVar.getIntVar(JSONUtil.getStr(_loc2_,["allSpSign"]));
         var _loc6_:GameTipUI = new GameTipUI("tipAllBar");
         var _loc7_:String = _loc5_ + "/" + _loc4_;
         _loc6_.addTipInfo(_loc7_,120,1);
         GameTipManager.showTip(_loc6_);
      }
      
      private function obf_P_t_2055(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("tipAllBar");
      }
      
      public function onInfoLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function listSuccessSitLabel(param1:Object) : String
      {
         if(param1.isNone)
         {
            return "-------";
         }
         return JSONUtil.getInt(obf_j_Y_1351.getWorldSuccessDoneMap,[param1.successId]) + "";
      }
      
      private function listSuccessSpLabel(param1:Object) : String
      {
         var _loc3_:Object = null;
         if(param1.isNone)
         {
            return "-------";
         }
         var _loc2_:Array = obf_Z_j_930.obf_5_J_1995;
         if(!_loc2_)
         {
            return "";
         }
         for each(_loc3_ in _loc2_)
         {
            if(JSONUtil.getInt(_loc3_,["id"]) == param1.successId)
            {
               return JSONUtil.getInt(_loc3_,["addSp"]) + "";
            }
         }
         return "";
      }
      
      private function listSuccessDoneLabel(param1:Object) : String
      {
         if(param1.isNone)
         {
            return "-------";
         }
         return DiversityManager.getString("SuccessUI",obf_j_Y_1351.successIsDone(param1.successId) ? "successDone" : "successNotDone");
      }
      
      private function obf_f_O_1450(param1:Event) : void
      {
         this.obf_g_d_2160();
      }
      
      public function obf_g_d_2160() : void
      {
         listSuccess.invalidateList();
         txtCondition.htmlText = "";
         var _loc1_:Object = listSuccess.selectedItem;
         if(!_loc1_ || Boolean(_loc1_.isNone))
         {
            return;
         }
         txtCondition.htmlText = ChatDecoder.decode(JSONUtil.getStr(_loc1_,["detail"])) + "\n";
         txtCondition.htmlText += ChatDecoder.decode(ConditionScript.getConditionsHTML(JSONUtil.getObject(_loc1_,["condition"])));
         obf_X_d_2366.update();
      }
      
      private function obf_0_Z_4426() : int
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc1_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc2_:Array = this.getArrayByObject(JSONUtil.getObject(_loc1_,["playerItems"]));
         var _loc3_:int = 1;
         while(_loc3_ < 18)
         {
            _loc4_ = _loc2_[_loc3_ - 1];
            _loc5_ = int(_loc4_["needSp"]);
            if(!this.playerSpArray || this.playerSpArray.length <= 0)
            {
               return _loc5_;
            }
            if(this.playerSpArray.indexOf(_loc5_) < 0)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function obf_n_Q_2769() : int
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc1_:Object = obf_Z_j_930.rewardSuccessConfig;
         var _loc2_:Array = this.getArrayByObject(JSONUtil.getObject(_loc1_,["allItems"]));
         var _loc3_:int = 1;
         while(_loc3_ < 18)
         {
            _loc4_ = _loc2_[_loc3_ - 1];
            _loc5_ = int(_loc4_["needSp"]);
            if(!this.allSpArray || this.allSpArray.length <= 0)
            {
               return _loc5_;
            }
            if(this.allSpArray.indexOf(_loc5_) < 0)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function obf_M_O_4004(param1:MouseEvent) : void
      {
         var _loc2_:int = this.obf_0_Z_4426();
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(obf_Z_j_930.rewardSuccessConfig,["playerSpSign"]));
         if(_loc3_ < _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardSuccessBoxUI","noSp"));
            return;
         }
         if(this.playerSpArray.indexOf(_loc2_) >= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardSuccessBoxUI","done"));
            return;
         }
         obf_Z_j_930.obf_U_S_3574(_loc2_);
      }
      
      public function obf_q_d_2200(param1:MouseEvent) : void
      {
         var _loc2_:int = this.obf_n_Q_2769();
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:int = DynamicVars.systemVar.getIntVar(JSONUtil.getStr(obf_Z_j_930.rewardSuccessConfig,["allSpSign"]));
         if(_loc3_ < _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardSuccessBoxUI","noSp"));
            return;
         }
         if(this.allSpArray.indexOf(_loc2_) >= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardSuccessBoxUI","done"));
            return;
         }
         obf_Z_j_930.obf_B_h_4055(_loc2_);
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
         obf_j_Y_1351.sendViewWorldSuccessTimes();
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

