package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.legend.LegendAttrKind;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import playerUI.RewardInfoBoxMC;
   
   public class obf_H_F_3333 extends RewardInfoBoxMC implements IIconItemUI
   {
      
      private var _rank:int;
      
      private var _level:int;
      
      private var _exp:int;
      
      private var obf_8_Z_2351:int;
      
      private var _allExp:int;
      
      private var iconBag1:IconItemBag;
      
      private var iconBag2:IconItemBag;
      
      private var iconOver1:IconItemBag;
      
      private var iconOver2:IconItemBag;
      
      private var iconOver3:IconItemBag;
      
      private var iconOver4:IconItemBag;
      
      private var iconOver5:IconItemBag;
      
      private var overTimes:Array;
      
      private var overToObject:Object;
      
      private var showTasks:Array = new Array();
      
      private var bags:Array = new Array();
      
      private var refreshTaskShowTime:TimeLimiter = new TimeLimiter(2000);
      
      public function obf_H_F_3333()
      {
         super();
         this.initDiversity();
         growBarExp.gotoAndStop(1);
         growBarAllExp.gotoAndStop(1);
         growBar.gotoAndStop(1);
         growBar.currentFrame;
         this.visible = false;
         this.iconBag1 = new IconItemBag(obf_I_i_2086,this,0);
         this.iconBag1.addValidType(GameItemType.ALL);
         this.iconBag1.lockDrag = true;
         this.iconBag2 = new IconItemBag(obf_k_8_3007,this,0);
         this.iconBag2.addValidType(GameItemType.ALL);
         this.iconBag2.lockDrag = true;
         cmdOver1.gotoAndStop(1);
         cmdOver2.gotoAndStop(1);
         cmdOver3.gotoAndStop(1);
         cmdOver4.gotoAndStop(1);
         cmdOver5.gotoAndStop(1);
         this.addListener();
         txtTaskDetail.wordWrap = true;
         taskList.labelFunction = this.taskListLabel;
         taskList.iconFunction = this.taskListIcon;
         scrollTaskAward.pageSize = scrollTaskAward.height;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function get getRank() : int
      {
         return this._rank;
      }
      
      public function setRank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get getLevel() : int
      {
         return this._level;
      }
      
      public function setLevel(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get getExp() : int
      {
         return this._exp;
      }
      
      public function setExp(param1:int) : void
      {
         this._exp = param1;
      }
      
      public function get getAllLevel() : int
      {
         return this.obf_8_Z_2351;
      }
      
      public function setAllLevel(param1:int) : void
      {
         this.obf_8_Z_2351 = param1;
      }
      
      public function get getAllExp() : int
      {
         return this._allExp;
      }
      
      public function setAllExp(param1:int) : void
      {
         this._allExp = param1;
      }
      
      public function initDiversity() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         DiversityManager.setTextField(txtPlayerInfo,"rewardInfoBoxUI","txtPlayerInfo");
         DiversityManager.setTextField(txtRank,"rewardInfoBoxUI","txtRank");
         DiversityManager.setTextField(txtLevel,"rewardInfoBoxUI","txtLevel");
         DiversityManager.setTextField(txtAward,"rewardInfoBoxUI","txtAward");
         cmdPlayerAward.label = DiversityManager.getString("rewardInfoBoxUI","cmdPlayerAward");
         DiversityManager.setTextField(txtAllInfo,"rewardInfoBoxUI","txtAllInfo");
         DiversityManager.setTextField(txtAllInfo1,"rewardInfoBoxUI","txtAllInfo1");
         DiversityManager.setTextField(txtInAllNum,"rewardInfoBoxUI","txtInAllNum");
         DiversityManager.setTextField(txtInPlayerNum,"rewardInfoBoxUI","txtInPlayerNum");
         DiversityManager.setTextField(txtOutPlayerNum,"rewardInfoBoxUI","txtOutPlayerNum");
         cmdAddAllExp.label = DiversityManager.getString("rewardInfoBoxUI","cmdAddAllExp");
         if(obf_Z_j_930.obf_b_V_2840)
         {
            var _loc9_:int = 0;
            var _loc10_:* = obf_Z_j_930.obf_b_V_2840;
            for(_loc3_ in _loc10_)
            {
               _loc4_ = int(obf_Z_j_930.obf_b_V_2840[_loc3_]);
               _loc5_ = GameItemManager.getItemName(_loc3_);
               _loc6_ = obf_Z_j_930.getItemLinkCode(_loc5_,_loc3_) + "x" + _loc4_;
               DiversityManager.setTextField(txtAllAward,"rewardInfoBoxUI","txtAllAward",[_loc6_],true);
            }
         }
         DiversityManager.setTextField(txtOverTitle,"rewardInfoBoxUI","txtOverTitle");
         this.overTimes = new Array();
         this.overToObject = new Object();
         for(_loc1_ in obf_Z_j_930.rewardOverItems)
         {
            _loc7_ = _loc1_ as int;
            this.overTimes.push(_loc7_);
         }
         this.overTimes.sort(Array.NUMERIC);
         _loc2_ = 0;
         while(_loc2_ < this.overTimes.length)
         {
            _loc8_ = int(this.overTimes[_loc2_]);
            DiversityManager.setTextField(this["txtOver" + (_loc2_ + 1)],"rewardInfoBoxUI","txtOver",[_loc8_]);
            this.overToObject[_loc8_] = this["cmdOver" + (_loc2_ + 1)];
            _loc2_++;
         }
         DiversityManager.setTextField(txtThisTask,"rewardInfoBoxUI","txtThisTask");
         DiversityManager.setTextField(txtReward,"rewardInfoBoxUI","txtReward");
         cmdOver.label = DiversityManager.getString("rewardInfoBoxUI","cmdOver");
         cmdGiveUp.label = DiversityManager.getString("rewardInfoBoxUI","cmdGiveUp");
      }
      
      private function addListener() : void
      {
         cmdPlayerAward.addEventListener(MouseEvent.CLICK,this.obf_M_O_4004);
         cmdAddAllExp.addEventListener(MouseEvent.CLICK,this.obf_L_X_3394);
         cmdAddAllExp.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdAddAllExp.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         txtAllAward.addEventListener(TextEvent.LINK,this.onInfoLink);
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            this["cmdOver" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_E_H_2664);
            this["cmdOver" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.obf_k_h_3093);
            this["cmdOver" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.obf_r_5_3043);
            _loc1_++;
         }
         taskList.addEventListener(MouseEvent.CLICK,this.onClickTask);
         cmdOver.addEventListener(MouseEvent.CLICK,this.obf_N_N_1987);
         cmdGiveUp.addEventListener(MouseEvent.CLICK,this.obf_Z_h_2120);
      }
      
      private function removeListener() : void
      {
         cmdPlayerAward.removeEventListener(MouseEvent.CLICK,this.obf_M_O_4004);
         cmdAddAllExp.removeEventListener(MouseEvent.CLICK,this.obf_L_X_3394);
         cmdAddAllExp.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdAddAllExp.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         txtAllAward.removeEventListener(TextEvent.LINK,this.onInfoLink);
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            this["cmdOver" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_E_H_2664);
            this["cmdOver" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.obf_k_h_3093);
            this["cmdOver" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.obf_r_5_3043);
            _loc1_++;
         }
         taskList.removeEventListener(MouseEvent.CLICK,this.onClickTask);
         cmdOver.removeEventListener(MouseEvent.CLICK,this.obf_N_N_1987);
         cmdGiveUp.removeEventListener(MouseEvent.CLICK,this.obf_Z_h_2120);
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("addAllExpTip");
         var _loc3_:int = 120;
         var _loc4_:String = "";
         for(_loc5_ in obf_Z_j_930.rewardAddAllExpItems)
         {
            _loc7_ = int(obf_Z_j_930.rewardAddAllExpItems[_loc5_]);
            if(_loc7_ > 0)
            {
               _loc8_ = GameItemManager.getItemName(_loc5_);
               _loc4_ += "\n" + _loc8_ + "x" + _loc7_;
            }
         }
         _loc6_ = DiversityManager.getString("rewardInfoBoxUI","txtAddAllExp",[_loc4_]);
         _loc2_.addTipInfo(_loc6_,_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("addAllExpTip");
      }
      
      private function onInfoLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_k_h_3093(param1:MouseEvent) : void
      {
         if(!this.overTimes)
         {
            return;
         }
         var _loc2_:int = 0;
         if(param1.currentTarget == cmdOver1)
         {
            _loc2_ = 0;
         }
         else if(param1.currentTarget == cmdOver2)
         {
            _loc2_ = 1;
         }
         else if(param1.currentTarget == cmdOver3)
         {
            _loc2_ = 2;
         }
         else if(param1.currentTarget == cmdOver4)
         {
            _loc2_ = 3;
         }
         else if(param1.currentTarget == cmdOver5)
         {
            _loc2_ = 4;
         }
         var _loc3_:int = int(this.overTimes[_loc2_]);
         var _loc4_:String = obf_Z_j_930.rewardOverItems[_loc3_];
         this.onShowItemTip(_loc4_,null);
      }
      
      private function obf_r_5_3043(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("rewardOverItem");
      }
      
      private function onShowItemTip(param1:String, param2:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 220;
         var _loc5_:GameTipUI = new GameTipUI("rewardOverItem");
         GameItemManager.obf_4_G_4299(_loc3_.name,_loc3_.rank,_loc5_,_loc4_);
         GameItemManager.obf_o_l_1634(_loc3_,_loc5_,_loc4_);
         if(_loc3_.subtype == GameItemSubtype.COLLECTION_GEM)
         {
            _loc6_ = GameItemRank.getRankColor(JSONUtil.getInt(_loc3_,["rank"])).toString(16);
            _loc5_.addTipInfo(DiversityManager.getString("ItemTip","gemType"),_loc4_,_loc5_.maxRow + 1);
            _loc5_.addTipInfo("<P align=\'right\'>" + obf_A_V_935.getGemTypeName(JSONUtil.getInt(_loc3_,["properties","gemType"])) + "</P>",_loc4_,_loc5_.maxRow);
            _loc5_.addTipInfo(DiversityManager.getString("ItemTip","gemLevel"),_loc4_,_loc5_.maxRow + 1);
            _loc5_.addTipInfo("<P align=\'right\'>" + DiversityManager.getString("ItemTip","gemLevelValue",[JSONUtil.getInt(_loc3_,["properties","gemLevel"])]) + "</P>",_loc4_,_loc5_.maxRow);
            _loc5_.addTipInfo("<P align=\'center\'><font color=\'#" + _loc6_ + "\'>" + DiversityManager.getString("ItemTip","gemAttr") + "</font></P>",_loc4_,_loc5_.maxRow + 2);
            _loc7_ = JSONUtil.getObject(_loc3_,["properties","gemAttr"]);
            if(!JSONUtil.getBoolean(_loc3_,["properties","isLegend"]))
            {
               if(_loc7_)
               {
                  for(_loc8_ in _loc7_)
                  {
                     _loc5_.addTipInfo("<font color=\'#" + _loc6_ + "\'>" + RoleAttributesModifierEnum.getAttributesName(int(_loc8_)) + "</font>",_loc4_,_loc5_.maxRow + 1);
                     _loc5_.addTipInfo("<P align=\'right\'><font color=\'#" + _loc6_ + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(_loc8_),_loc7_[_loc8_]) + "</font></P>",_loc4_,_loc5_.maxRow);
                  }
               }
            }
            else
            {
               _loc5_.addTipInfo("<font color=\'#" + _loc6_ + "\'>" + LegendAttrKind.getViewKindString(JSONUtil.getInt(_loc3_,["properties","attrType"])) + "</font>",_loc4_,_loc5_.maxRow + 1);
               _loc5_.addTipInfo("<P align=\'right\'><font color=\'#" + _loc6_ + "\'>" + JSONUtil.getInt(_loc3_,["properties","attrValue"]) + "</font></P>",_loc4_,_loc5_.maxRow);
            }
         }
         _loc5_.addTipInfo(_loc3_.remark,_loc4_,_loc5_.maxRow + 2);
         GameItemManager.obf_7_0_2420(_loc3_,_loc5_,_loc4_);
         GameItemManager.obf_J_l_4537(_loc3_,_loc5_,_loc4_);
         GameItemManager.setItemTipValidTime(param1,param2,_loc5_,_loc4_);
         GameTipManager.showTip(_loc5_);
      }
      
      public function obf_4_j_1878() : void
      {
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:IconItem = null;
         var _loc1_:obf_U_6_3454 = GameContext.localPlayer;
         this.headIconChange(_loc1_.fullInfo.headIconIndex);
         var _loc2_:Array = obf_Z_j_930.obf_0_y_1225;
         var _loc3_:Object = _loc2_[this._rank - 1];
         var _loc4_:String = JSONUtil.getStr(_loc3_,["name"]);
         txtRank.text = DiversityManager.getString("rewardInfoBoxUI","txtRank",[_loc4_]);
         txtLevel.text = DiversityManager.getString("rewardInfoBoxUI","txtLevel",[this._level]);
         if(this._rank >= _loc2_.length)
         {
            txtExp.text = DiversityManager.getString("rewardInfoBoxUI","txtMaxLv");
            growBarExp.gotoAndStop(100);
         }
         else
         {
            _loc9_ = JSONUtil.getValue(_loc3_,["exps"]) as Array;
            _loc10_ = int(_loc9_[this._level]);
            txtExp.text = this._exp + "/" + _loc10_;
            _loc11_ = this._exp * 100 / _loc10_;
            growBarExp.gotoAndStop(_loc11_);
         }
         this.attrChange(_loc3_);
         var _loc5_:String = JSONUtil.getStr(_loc3_,["pic"]);
         obf_0_P_4381.obf_m_X_1194(_loc5_,badgeIconPoint);
         this.iconBag1.dropIconItem();
         this.iconBag2.dropIconItem();
         var _loc6_:Object = JSONUtil.getObject(_loc3_,["items"]);
         var _loc7_:int = 1;
         for(_loc8_ in _loc6_)
         {
            if(_loc7_ > 2)
            {
               break;
            }
            _loc12_ = int(_loc6_[_loc8_]);
            _loc13_ = IconItemManager.getIconItemByCode(_loc8_,"");
            if(_loc13_)
            {
               _loc13_.itemCount = _loc12_;
               this["iconBag" + _loc7_].pushIconItem(_loc13_);
               _loc7_++;
            }
         }
         this.refreshPlayerAwardButton();
      }
      
      public function refreshPlayerAwardButton() : void
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$rewardPlayerAward");
         if(Boolean(_loc1_) && _loc1_.numOfDay > 0)
         {
            cmdPlayerAward.enabled = false;
         }
         else
         {
            cmdPlayerAward.enabled = true;
         }
      }
      
      public function headIconChange(param1:int) : void
      {
         while(headIconPoint.numChildren > 0)
         {
            headIconPoint.removeChildAt(0);
         }
         var _loc2_:DisplayObject = HeadIconCode.getHeadIconByInt(param1);
         headIconPoint.addChild(_loc2_);
      }
      
      public function attrChange(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = JSONUtil.getValue(param1,["attr"]) as Array;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.sortOn("attr");
         var _loc3_:int = 1;
         while(_loc3_ <= _loc2_.length)
         {
            if(_loc3_ > 8)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_ - 1];
            _loc5_ = RoleAttributesModifierEnum.getAttributesName(JSONUtil.getInt(_loc4_,["attr"]));
            this["txtAttr" + _loc3_].text = _loc5_ + ":";
            this["txtAttrValue" + _loc3_].text = "+" + JSONUtil.getInt(_loc4_,["value"]);
            _loc3_++;
         }
      }
      
      public function obf_v_z_4602() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         txtLv.text = DiversityManager.getString("rewardInfoBoxUI","txtLv",[this.obf_8_Z_2351]);
         if(this.obf_8_Z_2351 >= obf_Z_j_930.obf_K_M_4503.length)
         {
            txtAllExp.text = DiversityManager.getString("rewardInfoBoxUI","txtMaxLv");
            growBarAllExp.gotoAndStop(100);
         }
         else
         {
            _loc4_ = int(obf_Z_j_930.obf_K_M_4503[this.obf_8_Z_2351]);
            txtAllExp.text = this._allExp + "/" + _loc4_;
            _loc5_ = this._allExp * 100 / _loc4_;
            growBarAllExp.gotoAndStop(_loc5_);
         }
         var _loc1_:int = obf_Z_j_930.getNum(this.obf_8_Z_2351,obf_Z_j_930.obf_R_O_1021);
         txtInAllNum.text = DiversityManager.getString("rewardInfoBoxUI","txtInAllNum",[_loc1_]);
         var _loc2_:int = obf_Z_j_930.getNum(this.obf_8_Z_2351,obf_Z_j_930.obf_q_9_2529);
         txtInPlayerNum.text = DiversityManager.getString("rewardInfoBoxUI","txtInPlayerNum",[_loc2_]);
         var _loc3_:int = obf_Z_j_930.getNum(this.obf_8_Z_2351,obf_Z_j_930.obf_0_4_2_272);
         txtOutPlayerNum.text = DiversityManager.getString("rewardInfoBoxUI","txtOutPlayerNum",[_loc3_]);
      }
      
      public function obf_c_l_a_s_s_99() : void
      {
         var _loc4_:* = undefined;
         var _loc5_:PeriodCounterItemInfo = null;
         var _loc6_:int = 0;
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(obf_Z_j_930.obf_Q_X_1278);
         var _loc2_:int = _loc1_ ? _loc1_.numOfDay : 0;
         var _loc3_:int = 0;
         for each(_loc4_ in this.overTimes)
         {
            if(_loc4_ <= _loc2_)
            {
               _loc3_++;
            }
            _loc5_ = obf_Y_F_1424.getCounter("$rewardOver" + _loc4_);
            _loc6_ = _loc5_ ? _loc5_.numOfDay : 0;
            if(_loc6_ > 0)
            {
               this.overToObject[_loc4_].gotoAndStop(2);
            }
         }
         growBar.gotoAndStop(_loc3_ * 20);
      }
      
      public function isRewardTask(param1:int) : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         if(Boolean(this.showTasks) && this.showTasks.length > 0)
         {
            for each(_loc4_ in this.showTasks)
            {
               if(_loc4_.taskId == param1)
               {
                  return true;
               }
            }
         }
         for each(_loc2_ in obf_Z_j_930.obf_8_a_1746)
         {
            _loc5_ = JSONUtil.getInt(_loc2_,["allocatorId"]);
            if(TaskManager.isDoingAllocator(_loc5_))
            {
               return true;
            }
         }
         _loc3_ = obf_Z_j_930.rewardAllTaskConfig(param1);
         if(_loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function refreshDoingTask() : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         this.showTasks.length = 0;
         var _loc1_:Object = taskList.selectedItem;
         var _loc2_:Array = TaskManager.getDoingTask();
         var _loc3_:int = 0;
         for each(_loc4_ in obf_Z_j_930.obf_8_a_1746)
         {
            _loc6_ = JSONUtil.getInt(_loc4_,["allocatorId"]);
            if(TaskManager.isDoingAllocator(_loc6_))
            {
               _loc3_ = _loc6_;
            }
         }
         for each(_loc5_ in _loc2_)
         {
            if(_loc3_ > 0)
            {
               _loc8_ = TaskManager.getAllocatorByTaskId(_loc5_.taskId);
               if(_loc8_ == _loc3_)
               {
                  this.showTasks.push(_loc5_);
               }
            }
            _loc7_ = obf_Z_j_930.rewardAllTaskConfig(_loc5_.taskId);
            if(_loc7_)
            {
               this.showTasks.push(_loc5_);
            }
         }
         taskList.dataProvider = new DataProvider(this.showTasks);
         taskList.sortItemsOn("kind",Array.NUMERIC);
         this.clearTaskContent();
         if(!_loc1_ || this.showTasks.indexOf(_loc1_) == -1)
         {
            taskList.selectedIndex = this.showTasks.length - 1;
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
      
      public function refreshTaskShow() : void
      {
         if(!taskList.selectedItem)
         {
            return;
         }
         var _loc1_:Object = taskList.selectedItem;
         this.setTaskDetail(_loc1_);
         this.setTaskAward(_loc1_.finishRule.onFinished);
      }
      
      private function setTaskDetail(param1:Object) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc2_:String = obf_K_e_3075.getSwitchString(param1.detail);
         var _loc3_:String = "";
         if(taskList.selectedItem)
         {
            _loc8_ = "";
            for each(_loc9_ in taskList.selectedItem.receiveRule.atAnyNpc)
            {
               _loc10_ = _loc9_.split("@");
               if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc10_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
               {
                  _loc3_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcFullBriefName(_loc9_),_loc10_[1],_loc10_[0]));
               }
               _loc8_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc9_) + "-" + WorldMapManager.getMapName(_loc10_[1]),_loc10_[1],_loc10_[0]);
            }
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ = _loc8_;
            }
            _loc3_ = DiversityManager.getString("TaskUI","recevieNPC") + _loc3_;
         }
         var _loc4_:String = "";
         if(taskList.selectedItem)
         {
            _loc11_ = "";
            for each(_loc12_ in taskList.selectedItem.finishRule.atAnyNpc)
            {
               _loc13_ = _loc12_.split("@");
               if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc13_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
               {
                  _loc4_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc12_) + "-" + WorldMapManager.getMapName(_loc13_[1]),_loc13_[1],_loc13_[0]));
               }
               _loc11_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc12_) + "-" + WorldMapManager.getMapName(_loc13_[1]),_loc13_[1],_loc13_[0]);
            }
            if(obf_L_l_4100.isEmpty(_loc4_))
            {
               _loc4_ = _loc11_;
            }
            _loc4_ = "\n" + DiversityManager.getString("TaskUI","finishNPC") + _loc4_;
         }
         txtTaskDetail.htmlText = ChatDecoder.decode(_loc2_ + "\n");
         var _loc5_:Object = param1.finishRule.condition;
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:String = "";
         for(_loc7_ in _loc5_)
         {
            txtTaskDetail.htmlText += ConditionScript.getConditionHTML(_loc7_,_loc5_[_loc7_]);
         }
         scrollTaskDetail.update();
         scrollTaskDetail.visible = scrollTaskDetail.enabled;
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
      
      private function onClickTask(param1:Event) : void
      {
         this.refreshTaskShow();
      }
      
      public function obf_M_O_4004(param1:Event) : void
      {
         obf_Z_j_930.obf_b_o_3822();
      }
      
      public function obf_L_X_3394(param1:Event) : void
      {
         var _loc3_:String = null;
         if(Boolean(obf_K_e_3075.playerBagUI) && !obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardInfoBoxUI","txtNoRoom"));
            return;
         }
         var _loc2_:Object = obf_Z_j_930.rewardAddAllExpItems;
         if(_loc2_)
         {
            for(_loc3_ in _loc2_)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_[_loc3_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("rewardShopBoxUI","noItem"));
                  return;
               }
            }
         }
         obf_Z_j_930.obf_0_2_T_701();
      }
      
      public function obf_E_H_2664(param1:Event) : void
      {
         if(param1.currentTarget.currentFrame == 2)
         {
            WindowManager.showMessageBox(DiversityManager.getString("rewardInfoBoxUI","msgPlayerAward"));
            return;
         }
         var _loc2_:int = 0;
         if(param1.currentTarget == cmdOver1)
         {
            _loc2_ = int(this.overTimes[0]);
         }
         else if(param1.currentTarget == cmdOver2)
         {
            _loc2_ = int(this.overTimes[1]);
         }
         else if(param1.currentTarget == cmdOver3)
         {
            _loc2_ = int(this.overTimes[2]);
         }
         else if(param1.currentTarget == cmdOver4)
         {
            _loc2_ = int(this.overTimes[3]);
         }
         else if(param1.currentTarget == cmdOver5)
         {
            _loc2_ = int(this.overTimes[4]);
         }
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(obf_Z_j_930.obf_Q_X_1278);
         var _loc4_:int = _loc3_ ? _loc3_.numOfDay : 0;
         if(_loc4_ < _loc2_)
         {
            return;
         }
         obf_Z_j_930.obf_7_3_2334(_loc2_);
      }
      
      public function obf_N_N_1987(param1:Event) : void
      {
         if(!taskList.selectedItem)
         {
            return;
         }
         var _loc2_:Object = taskList.selectedItem;
         obf_Z_j_930.onPlayerFinishTaskRequest(_loc2_.taskId);
      }
      
      public function obf_Z_h_2120(param1:Event) : void
      {
         if(!taskList.selectedItem)
         {
            return;
         }
         var _loc2_:Object = taskList.selectedItem;
         obf_Z_j_930.obf_7_Z_4139(_loc2_.taskId);
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!taskList.selectedItem)
         {
            return;
         }
         var _loc2_:Object = taskList.selectedItem;
         if(Boolean(this.refreshTaskShowTime && this.visible) && Boolean(_loc2_) && this.refreshTaskShowTime.checkTimeout())
         {
            this.setTaskDetail(_loc2_);
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(this.iconBag1,this.iconBag2);
         if(this.bags)
         {
            _loc1_.concat(this.bags);
         }
         return _loc1_;
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

