package obf_n_k_1384
{
   import obf_h_e_3633.IncubatorItem;
   import obf_h_e_3633.IncubatorItemConfig;
   import obf_h_e_3633.obf_3_T_877;
   import obf_h_e_3633.obf_8_m_2284;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.IncubatorUIMC;
   
   public class IncubatorUI extends IncubatorUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _bags:Array;
      
      private var _resultBag:IconItemBag;
      
      private var obf_M_x_3257:Array;
      
      private var obf_g_S_870:int = 1;
      
      private var _page:int = 1;
      
      private var itemCode:String = null;
      
      private var info:obf_3_T_877 = null;
      
      private var endTime:int = 0;
      
      private var haveItems:Object;
      
      private var list:Array;
      
      private var pressure:int;
      
      private var temp:int;
      
      private var power:int;
      
      private var time:TimeLimiter;
      
      public function IncubatorUI()
      {
         var _loc2_:IconItemBag = null;
         this._bags = new Array();
         this.obf_M_x_3257 = new Array();
         this.time = new TimeLimiter(1000);
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         pressureBar.gotoAndStop(1);
         tempBar.gotoAndStop(1);
         powerBar.gotoAndStop(1);
         this._resultBag = new IconItemBag(iconResult,this,0);
         this._resultBag.addValidType(GameItemType.ALL);
         this._resultBag.isLocked = false;
         this._bags.push(this._resultBag);
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new IconItemBag(this["icon" + _loc1_],this,0);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.isLocked = false;
            this.obf_M_x_3257.push(_loc2_);
            this._bags.push(_loc2_);
            _loc1_++;
         }
         this.addListener();
         this.initView();
      }
      
      public function initDiversity() : void
      {
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("IncubatorUI","txtInfo") + "</a>";
         DiversityManager.setTextField(txtTitle,"IncubatorUI","txtTitle");
         DiversityManager.setTextField(txtTitle1,"IncubatorUI","txtTitle1");
         DiversityManager.setTextField(txtType,"IncubatorUI","txtType");
         DiversityManager.setTextField(txtAttrName,"IncubatorUI","txtAttrName");
         DiversityManager.setTextField(txtAttr,"IncubatorUI","txtAttr");
         DiversityManager.setTextField(txtRank,"IncubatorUI","txtRank");
         DiversityManager.setTextField(txtTime,"IncubatorUI","txtTime");
         DiversityManager.setTextField(txtPressure,"IncubatorUI","txtPressure");
         DiversityManager.setTextField(txtTemp,"IncubatorUI","txtTemp");
         DiversityManager.setTextField(txtDif,"IncubatorUI","txtDif");
         DiversityManager.setTextField(txtPower,"IncubatorUI","txtPower");
         DiversityManager.setTextField(txtTitle2,"IncubatorUI","txtTitle2");
         DiversityManager.setTextField(txtCountdown,"IncubatorUI","txtCountdown");
         DiversityManager.setTextField(txtSuccess,"IncubatorUI","txtSuccess");
         DiversityManager.setTextField(txtThisPressure,"IncubatorUI","txtThisPressure");
         DiversityManager.setTextField(txtThisTemp,"IncubatorUI","txtThisTemp");
         DiversityManager.setTextField(txtThisPower,"IncubatorUI","txtThisPower");
         DiversityManager.setTextField(txtTitle3,"IncubatorUI","txtTitle3");
         cmdTake.label = DiversityManager.getString("IncubatorUI","cmdTake");
         cmdNo.label = DiversityManager.getString("IncubatorUI","cmdNo");
         cmdDo.label = DiversityManager.getString("IncubatorUI","cmdDo");
         cmdOver.label = DiversityManager.getString("IncubatorUI","cmdOver");
         cmdSave.label = DiversityManager.getString("IncubatorUI","cmdSave");
         cmdPressure.label = DiversityManager.getString("IncubatorUI","cmdPressure");
         cmdTemp.label = DiversityManager.getString("IncubatorUI","cmdTemp");
         cmdPower.label = DiversityManager.getString("IncubatorUI","cmdPower");
         cmdPre.label = DiversityManager.getString("IncubatorUI","cmdPre");
         cmdNext.label = DiversityManager.getString("IncubatorUI","cmdNext");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdTake.addEventListener(MouseEvent.CLICK,this.obf_V_g_2936);
         cmdNo.addEventListener(MouseEvent.CLICK,this.obf_w_m_1309);
         cmdDo.addEventListener(MouseEvent.CLICK,this.obf_U_B_1332);
         cmdOver.addEventListener(MouseEvent.CLICK,this.obf_0_6_K_247);
         cmdSave.addEventListener(MouseEvent.CLICK,this.obf_o_C_1963);
         cmdPressure.addEventListener(MouseEvent.CLICK,this.onCmdPressure);
         cmdTemp.addEventListener(MouseEvent.CLICK,this.onCmdTemp);
         cmdPower.addEventListener(MouseEvent.CLICK,this.obf_0_5_0_638);
         cmdPre.addEventListener(MouseEvent.CLICK,this.obf_H_a_807);
         cmdNext.addEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"incubatorInfo");
         cmdOver.addEventListener(MouseEvent.MOUSE_OVER,this.showOverTip);
         cmdOver.addEventListener(MouseEvent.MOUSE_OUT,this.closeOverTip);
         cmdPressure.addEventListener(MouseEvent.MOUSE_OVER,this.showPressureTip);
         cmdPressure.addEventListener(MouseEvent.MOUSE_OUT,this.closePressureTip);
         cmdTemp.addEventListener(MouseEvent.MOUSE_OVER,this.showTempTip);
         cmdTemp.addEventListener(MouseEvent.MOUSE_OUT,this.closeTempTip);
         cmdPower.addEventListener(MouseEvent.MOUSE_OVER,this.showPowerTip);
         cmdPower.addEventListener(MouseEvent.MOUSE_OUT,this.closePowerTip);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdTake.removeEventListener(MouseEvent.CLICK,this.obf_V_g_2936);
         cmdNo.removeEventListener(MouseEvent.CLICK,this.obf_w_m_1309);
         cmdDo.removeEventListener(MouseEvent.CLICK,this.obf_U_B_1332);
         cmdOver.removeEventListener(MouseEvent.CLICK,this.obf_0_6_K_247);
         cmdSave.removeEventListener(MouseEvent.CLICK,this.obf_o_C_1963);
         cmdPressure.removeEventListener(MouseEvent.CLICK,this.onCmdPressure);
         cmdTemp.removeEventListener(MouseEvent.CLICK,this.onCmdTemp);
         cmdPower.removeEventListener(MouseEvent.CLICK,this.obf_0_5_0_638);
         cmdPre.removeEventListener(MouseEvent.CLICK,this.obf_H_a_807);
         cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         cmdOver.removeEventListener(MouseEvent.MOUSE_OVER,this.showOverTip);
         cmdOver.removeEventListener(MouseEvent.MOUSE_OUT,this.closeOverTip);
         cmdPressure.removeEventListener(MouseEvent.MOUSE_OVER,this.showPressureTip);
         cmdPressure.removeEventListener(MouseEvent.MOUSE_OUT,this.closePressureTip);
         cmdTemp.removeEventListener(MouseEvent.MOUSE_OVER,this.showTempTip);
         cmdTemp.removeEventListener(MouseEvent.MOUSE_OUT,this.closeTempTip);
         cmdPower.removeEventListener(MouseEvent.MOUSE_OVER,this.showPowerTip);
         cmdPower.removeEventListener(MouseEvent.MOUSE_OUT,this.closePowerTip);
      }
      
      private function showOverTip(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("overTip");
         var _loc3_:int = 100;
         var _loc4_:String = obf_8_m_2284.overNeed + DiversityManager.getString("IncubatorUI","money");
         _loc2_.addTipInfo(_loc4_,_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function closeOverTip(param1:Event) : void
      {
         GameTipManager.closeTip("overTip");
      }
      
      private function showPressureTip(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("pressureTip");
         var _loc3_:int = 100;
         var _loc4_:int = 1;
         for(_loc5_ in obf_8_m_2284.pressureItems)
         {
            _loc6_ = int(obf_8_m_2284.pressureItems[_loc5_]);
            _loc7_ = GameItemManager.getItemName(_loc5_);
            _loc2_.addTipInfo(_loc7_ + "*" + _loc6_,_loc3_,_loc4_);
            _loc4_++;
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function closePressureTip(param1:Event) : void
      {
         GameTipManager.closeTip("pressureTip");
      }
      
      private function showTempTip(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("tempTip");
         var _loc3_:int = 100;
         var _loc4_:int = 1;
         for(_loc5_ in obf_8_m_2284.tempItems)
         {
            _loc6_ = int(obf_8_m_2284.tempItems[_loc5_]);
            _loc7_ = GameItemManager.getItemName(_loc5_);
            _loc2_.addTipInfo(_loc7_ + "*" + _loc6_,_loc3_,_loc4_);
            _loc4_++;
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function closeTempTip(param1:Event) : void
      {
         GameTipManager.closeTip("tempTip");
      }
      
      private function showPowerTip(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("powerTip");
         var _loc3_:int = 100;
         var _loc4_:int = 1;
         for(_loc5_ in obf_8_m_2284.powerItems)
         {
            _loc6_ = int(obf_8_m_2284.powerItems[_loc5_]);
            _loc7_ = GameItemManager.getItemName(_loc5_);
            _loc2_.addTipInfo(_loc7_ + "*" + _loc6_,_loc3_,_loc4_);
            _loc4_++;
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function closePowerTip(param1:Event) : void
      {
         GameTipManager.closeTip("powerTip");
      }
      
      public function setState(param1:int) : void
      {
         this.obf_g_S_870 = param1;
         if(param1 == 1)
         {
            this.beforeIncubator();
         }
         else if(param1 == 2)
         {
            this.obf_P_N_2811();
         }
         else if(param1 == 3)
         {
            this.startIncubator();
         }
         else if(param1 == 4)
         {
            this.obf_F_T_784();
         }
         else if(param1 == 5)
         {
            this.obf_4_s_4514();
         }
      }
      
      public function initView() : void
      {
         this.beforeIncubator();
         var _loc1_:int = obf_8_m_2284.takeGold / 10000;
         txtNeedGold.text = _loc1_ + DiversityManager.getString("IncubatorUI","gold");
      }
      
      private function obf_0_5_P_102(param1:String, param2:int, param3:String = "") : String
      {
         var _loc4_:String = "";
         if(param2 == 1)
         {
            _loc4_ += "<font color=\'#0000ff\'>" + param1 + param3 + "</font>";
         }
         else if(param2 == 2)
         {
            _loc4_ += "<font color=\'#9900cc\'>" + param1 + param3 + "</font>";
         }
         else if(param2 == 3)
         {
            _loc4_ += "<font color=\'#ff9900\'>" + param1 + param3 + "</font>";
         }
         return _loc4_;
      }
      
      public function setItemCode(param1:String) : void
      {
         var _loc2_:obf_3_T_877 = null;
         var _loc3_:PeriodCounterItemInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc2_ = obf_8_m_2284.getIncubatorInfoByItemCode(param1);
            if(!_loc2_)
            {
               return;
            }
            this.itemCode = param1;
            this.info = _loc2_;
            this.obf_P_N_2811();
            txtTypeValue.htmlText = this.obf_0_5_P_102(_loc2_.typeName,_loc2_.rankColor);
            txtAttrNameValue.htmlText = this.obf_0_5_P_102(_loc2_.typeAttr,_loc2_.rankColor);
            txtAttrValue.htmlText = this.obf_0_5_P_102(_loc2_.typeAttrValue + "",_loc2_.rankColor);
            txtRankValue.htmlText = this.obf_0_5_P_102(_loc2_.rankName,_loc2_.rankColor);
            txtTimeValue.htmlText = this.obf_0_5_P_102(_loc2_.needTime + "",_loc2_.rankColor,DiversityManager.getString("IncubatorUI","unit"));
            txtPressureValue.htmlText = this.obf_0_5_P_102(_loc2_.pressure + "",_loc2_.rankColor,"MPa");
            txtTempValue.htmlText = this.obf_0_5_P_102(_loc2_.temp + "",_loc2_.rankColor,"℃");
            txtDifValue.htmlText = this.obf_0_5_P_102(_loc2_.dif * 100 + "",_loc2_.rankColor,"%");
            txtPowerValue.htmlText = this.obf_0_5_P_102(_loc2_.power + "",_loc2_.rankColor);
            _loc3_ = obf_Y_F_1424.getCounter("$incubator");
            _loc4_ = JSONUtil.getInt(_loc3_,["numOfDay"]);
            if(_loc4_ >= obf_8_m_2284.incubateNeeds.length)
            {
               txtNeedMoney.text = DiversityManager.getString("IncubatorUI","noTimes");
               cmdDo.enabled = false;
            }
            else
            {
               _loc5_ = int(obf_8_m_2284.incubateNeeds[_loc4_]);
               if(_loc5_ == 0)
               {
                  txtNeedMoney.text = DiversityManager.getString("IncubatorUI","free");
               }
               else
               {
                  txtNeedMoney.text = _loc5_ + DiversityManager.getString("IncubatorUI","money");
               }
            }
         }
         else
         {
            this.itemCode = null;
         }
      }
      
      public function setEndTime(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.endTime = param1;
         if(param1 > 0)
         {
            _loc2_ = "00";
            _loc3_ = "00";
            _loc4_ = "00";
            if(param1 > 3600)
            {
               _loc6_ = param1 / 3600;
               if(_loc6_ == 0)
               {
                  _loc2_ = "00";
               }
               else if(_loc6_ < 10)
               {
                  _loc2_ = "0" + _loc6_;
               }
               else
               {
                  _loc2_ = _loc6_ + "";
               }
            }
            if(param1 > 60)
            {
               _loc7_ = param1 % 3600 / 60;
               if(_loc7_ == 0)
               {
                  _loc3_ = "00";
               }
               else if(_loc7_ < 10)
               {
                  _loc3_ = "0" + _loc7_;
               }
               else
               {
                  _loc3_ = _loc7_ + "";
               }
            }
            _loc5_ = param1 % 3600 % 60;
            if(_loc5_ == 0)
            {
               _loc4_ = "00";
            }
            else if(_loc5_ < 10)
            {
               _loc4_ = "0" + _loc5_;
            }
            else
            {
               _loc4_ = _loc5_ + "";
            }
            txtCountdownValue.text = _loc2_ + ":" + _loc3_ + ":" + _loc4_;
            this.startIncubator();
            txtResult.htmlText = DiversityManager.getString("IncubatorUI","txtResult0");
         }
         else
         {
            txtCountdownValue.text = "--:--:--";
         }
      }
      
      public function setHaveItems(param1:Object) : void
      {
         var _loc3_:IncubatorItemConfig = null;
         var _loc4_:IncubatorItem = null;
         var _loc5_:int = 0;
         this.haveItems = param1;
         this.list = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < obf_8_m_2284.itemsConfig.length)
         {
            _loc3_ = obf_8_m_2284.itemsConfig[_loc2_];
            if(_loc3_)
            {
               _loc4_ = new IncubatorItem(_loc3_);
               _loc5_ = int(param1[_loc3_.itemCode]);
               if(_loc5_ > 0)
               {
                  _loc4_.obf_Z_O_1926 = _loc5_;
               }
               this.list.push(_loc4_);
            }
            _loc2_++;
         }
         this.list.sort(this.obf_0_1_7_534);
         this.showPageBag(1);
         this.obf_x_j_3753();
      }
      
      public function obf_0_1_7_534(param1:IncubatorItem, param2:IncubatorItem) : Number
      {
         if(param1.obf_Z_O_1926 > 0 && param2.obf_Z_O_1926 > 0)
         {
            if(param1.rank > param2.rank)
            {
               return -1;
            }
            if(param1.rank < param2.rank)
            {
               return 1;
            }
            if(param1.rank == param2.rank)
            {
               return 0;
            }
         }
         if(param1.obf_Z_O_1926 > 0 && param2.obf_Z_O_1926 == 0)
         {
            return -1;
         }
         if(param1.obf_Z_O_1926 == 0 && param2.obf_Z_O_1926 > 0)
         {
            return 1;
         }
         if(param1.obf_Z_O_1926 == 0 && param2.obf_Z_O_1926 == 0)
         {
            if(param1.rank > param2.rank)
            {
               return -1;
            }
            if(param1.rank < param2.rank)
            {
               return 1;
            }
            if(param1.rank == param2.rank)
            {
               return 0;
            }
         }
         return 0;
      }
      
      public function showPageBag(param1:int) : void
      {
         var _loc6_:IncubatorItem = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItem = null;
         if(param1 != 1 && this._page == param1)
         {
            return;
         }
         this._page = param1;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            this.obf_M_x_3257[_loc2_].dropIconItem();
            this["txtMax" + _loc2_].text = "";
            _loc2_++;
         }
         var _loc3_:int = (this.list.length - 1) / 10 + 1;
         var _loc4_:int = (param1 - 1) * 10;
         var _loc5_:int = 0;
         while(_loc5_ < 10)
         {
            _loc6_ = this.list[_loc4_ + _loc5_];
            if(_loc6_)
            {
               _loc7_ = this.obf_M_x_3257[_loc5_];
               _loc8_ = IconItemManager.getIconItemByCode(_loc6_.itemCode,"");
               _loc8_.itemCount = _loc6_.obf_Z_O_1926;
               _loc7_.pushIconItem(_loc8_);
               this["txtMax" + _loc5_].text = _loc6_.maxTimes;
            }
            _loc5_++;
         }
         txtPage.text = param1 + "/" + _loc3_;
      }
      
      public function obf_H_a_807(param1:Event) : void
      {
         if(this._page == 1)
         {
            return;
         }
         this.showPageBag(this._page - 1);
      }
      
      public function obf_j_l_1190(param1:Event) : void
      {
         var _loc2_:int = (this.list.length - 1) / 10 + 1;
         if(this._page == _loc2_)
         {
            return;
         }
         this.showPageBag(this._page + 1);
      }
      
      public function obf_x_j_3753() : void
      {
         var _loc5_:IncubatorItem = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < this.list.length)
         {
            _loc5_ = this.list[_loc3_];
            if(_loc5_.obf_Z_O_1926 > 0)
            {
               for(_loc6_ in _loc5_.attr)
               {
                  _loc7_ = int(_loc6_);
                  _loc8_ = int(_loc5_.attr[_loc7_]);
                  _loc9_ = int(_loc2_[_loc7_]);
                  if(_loc9_)
                  {
                     _loc2_[_loc7_] = _loc9_ + _loc8_ * _loc5_.obf_Z_O_1926;
                  }
                  else
                  {
                     _loc2_[_loc7_] = _loc8_ * _loc5_.obf_Z_O_1926;
                     _loc1_.push(_loc7_);
                  }
               }
            }
            _loc3_++;
         }
         _loc1_.sort();
         var _loc4_:int = 0;
         while(_loc4_ < 12)
         {
            if(_loc4_ < _loc1_.length)
            {
               this["txtAllAttr" + _loc4_].text = RoleAttributesModifierEnum.getAttributesName(_loc1_[_loc4_]);
               this["txtAllAttrValue" + _loc4_].text = "+" + _loc2_[_loc1_[_loc4_]];
            }
            else
            {
               this["txtAllAttr" + _loc4_].text = "";
               this["txtAllAttrValue" + _loc4_].text = "";
            }
            _loc4_++;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.obf_g_S_870 != 3)
         {
            return;
         }
         if(this.time.checkTimeout())
         {
            --this.endTime;
            if(this.endTime > 0)
            {
               _loc2_ = "00";
               _loc3_ = "00";
               _loc4_ = "00";
               if(this.endTime > 3600)
               {
                  _loc6_ = this.endTime / 3600;
                  if(_loc6_ == 0)
                  {
                     _loc2_ = "00";
                  }
                  else if(_loc6_ < 10)
                  {
                     _loc2_ = "0" + _loc6_;
                  }
                  else
                  {
                     _loc2_ = _loc6_ + "";
                  }
               }
               if(this.endTime > 60)
               {
                  _loc7_ = this.endTime % 3600 / 60;
                  if(_loc7_ == 0)
                  {
                     _loc3_ = "00";
                  }
                  else if(_loc7_ < 10)
                  {
                     _loc3_ = "0" + _loc7_;
                  }
                  else
                  {
                     _loc3_ = _loc7_ + "";
                  }
               }
               _loc5_ = this.endTime % 3600 % 60;
               if(_loc5_ == 0)
               {
                  _loc4_ = "00";
               }
               else if(_loc5_ < 10)
               {
                  _loc4_ = "0" + _loc5_;
               }
               else
               {
                  _loc4_ = _loc5_ + "";
               }
               txtCountdownValue.text = _loc2_ + ":" + _loc3_ + ":" + _loc4_;
               this.startIncubator();
               txtResult.htmlText = DiversityManager.getString("IncubatorUI","txtResult0");
            }
            else
            {
               txtCountdownValue.text = "--:--:--";
            }
         }
      }
      
      private function obf_z_4_4611() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc1_:obf_3_T_877 = obf_8_m_2284.getIncubatorInfoByItemCode(this.itemCode);
         if(!_loc1_)
         {
            return;
         }
         if(this.power < _loc1_.power)
         {
            txtSuccessValue.text = "0%";
         }
         else
         {
            _loc2_ = 0;
            _loc3_ = _loc1_.pressure * (1 - _loc1_.dif);
            _loc4_ = _loc1_.pressure * (1 + _loc1_.dif);
            if(this.pressure >= _loc3_ && this.pressure <= _loc4_)
            {
               _loc2_ = 1;
            }
            else
            {
               _loc2_ = (obf_8_m_2284.maxPressure - Math.abs(this.pressure - _loc1_.pressure)) / obf_8_m_2284.maxPressure * obf_8_m_2284.successMul;
            }
            _loc5_ = 0;
            _loc6_ = _loc1_.temp * (1 - _loc1_.dif);
            _loc7_ = _loc1_.temp * (1 + _loc1_.dif);
            if(this.temp >= _loc6_ && this.temp <= _loc7_)
            {
               _loc5_ = 1;
            }
            else
            {
               _loc5_ = (obf_8_m_2284.maxTemp - Math.abs(this.temp - _loc1_.temp)) / obf_8_m_2284.maxTemp * obf_8_m_2284.successMul;
            }
            _loc8_ = Math.round(_loc2_ * _loc5_ * 10000) / 100;
            txtSuccessValue.text = _loc8_ + "%";
         }
      }
      
      public function changeValue(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         if(param2 == 1)
         {
            this.pressure = param1;
            _loc3_ = Math.round(this.pressure / obf_8_m_2284.maxPressure * 100);
            txtThisPressureValue.text = this.pressure + "MPa";
            pressureBar.gotoAndStop(_loc3_);
         }
         else if(param2 == 2)
         {
            this.temp = param1;
            _loc3_ = Math.round(this.temp / obf_8_m_2284.maxTemp * 100);
            txtThisTempValue.text = this.temp + "℃";
            tempBar.gotoAndStop(_loc3_);
         }
         else if(param2 == 3)
         {
            this.power = param1;
            _loc3_ = Math.round(this.power / obf_8_m_2284.maxPower * 100);
            txtThisPowerValue.text = this.power + "";
            powerBar.gotoAndStop(_loc3_);
         }
         this.obf_z_4_4611();
      }
      
      public function incubatorResult(param1:Boolean) : void
      {
         if(param1)
         {
            this.obf_F_T_784();
            txtResult.htmlText = "<font color=\'#00ff00\'>" + DiversityManager.getString("IncubatorUI","txtResult1") + "</font>";
            this._resultBag.pushIconItem(IconItemManager.getIconItemByCode(this.itemCode,""));
            this.setState(4);
         }
         else
         {
            this.obf_4_s_4514();
            txtResult.htmlText = "<font color=\'#ff0000\'>" + DiversityManager.getString("IncubatorUI","txtResult2") + "</font>";
            cmdSave.enabled = false;
            this.itemCode = null;
            this.setState(5);
         }
      }
      
      public function obf_y_U_4137() : void
      {
         this.setState(1);
         this.beforeIncubator();
         var _loc1_:int = obf_8_m_2284.takeGold / 10000;
         txtNeedGold.text = _loc1_ + DiversityManager.getString("IncubatorUI","gold");
         this.itemCode = null;
      }
      
      private function obf_V_g_2936(param1:Event) : void
      {
         if(this.obf_g_S_870 != 1 && this.obf_g_S_870 != 5)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.gold < obf_8_m_2284.takeGold)
         {
            WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noGold"));
            return;
         }
         obf_8_m_2284.sendTakeRequest();
      }
      
      private function obf_w_m_1309(param1:Event) : void
      {
         if(this.obf_g_S_870 != 2)
         {
            return;
         }
         obf_8_m_2284.sendNoRequest();
         this.obf_y_U_4137();
      }
      
      private function obf_U_B_1332(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:obf_3_T_877 = null;
         if(this.obf_g_S_870 != 2)
         {
            return;
         }
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$incubator");
         var _loc3_:int = int(obf_8_m_2284.incubateNeeds[JSONUtil.getInt(_loc2_,["numOfDay"])]);
         if(GameContext.localPlayer.fullInfo.money < _loc3_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noMoney"));
            return;
         }
         if(Boolean(this.haveItems) && Boolean(this.itemCode))
         {
            _loc4_ = int(this.haveItems[this.itemCode]);
            _loc5_ = obf_8_m_2284.getIncubatorInfoByItemCode(this.itemCode);
            if(_loc4_ >= _loc5_.maxTimes)
            {
               WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","maxHave"));
               return;
            }
         }
         obf_8_m_2284.sendDoRequest();
      }
      
      private function obf_0_6_K_247(param1:Event) : void
      {
         if(this.obf_g_S_870 != 3)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.money < obf_8_m_2284.overNeed)
         {
            WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noMoney"));
            return;
         }
         obf_8_m_2284.sendOverRequest();
      }
      
      private function obf_o_C_1963(param1:Event) : void
      {
         if(this.obf_g_S_870 != 4)
         {
            return;
         }
         obf_8_m_2284.sendSaveRequest();
      }
      
      private function onCmdPressure(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.obf_g_S_870 != 3)
         {
            return;
         }
         if(this.pressure >= obf_8_m_2284.maxPressure)
         {
            return;
         }
         for(_loc2_ in obf_8_m_2284.pressureItems)
         {
            _loc3_ = int(obf_8_m_2284.pressureItems[_loc2_]);
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noItem"));
               return;
            }
         }
         obf_8_m_2284.sendPressureRequest();
      }
      
      private function onCmdTemp(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.obf_g_S_870 != 3)
         {
            return;
         }
         if(this.temp >= obf_8_m_2284.maxTemp)
         {
            return;
         }
         for(_loc2_ in obf_8_m_2284.tempItems)
         {
            _loc3_ = int(obf_8_m_2284.tempItems[_loc2_]);
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noItem"));
               return;
            }
         }
         obf_8_m_2284.sendTempRequest();
      }
      
      private function obf_0_5_0_638(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.obf_g_S_870 != 3)
         {
            return;
         }
         if(this.power >= obf_8_m_2284.maxPower)
         {
            return;
         }
         for(_loc2_ in obf_8_m_2284.powerItems)
         {
            _loc3_ = int(obf_8_m_2284.powerItems[_loc2_]);
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("IncubatorUI","noItem"));
               return;
            }
         }
         obf_8_m_2284.sendPowerRequest();
      }
      
      private function beforeIncubator() : void
      {
         txtType.visible = false;
         txtAttrName.visible = false;
         txtAttr.visible = false;
         txtRank.visible = false;
         txtTime.visible = false;
         txtPressure.visible = false;
         txtTemp.visible = false;
         txtDif.visible = false;
         txtPower.visible = false;
         txtTypeValue.visible = false;
         txtAttrNameValue.visible = false;
         txtAttrValue.visible = false;
         txtRankValue.visible = false;
         txtTimeValue.visible = false;
         txtPressureValue.visible = false;
         txtTempValue.visible = false;
         txtDifValue.visible = false;
         txtPowerValue.visible = false;
         cmdNo.visible = false;
         cmdDo.visible = false;
         txtNeedMoney.visible = false;
         cmdTake.visible = true;
         txtNeedGold.visible = true;
         txtCountdownValue.text = "";
         txtSuccessValue.text = "";
         txtResult.visible = false;
         this._resultBag.dropIconItem();
         cmdOver.enabled = false;
         cmdSave.enabled = false;
         cmdPressure.enabled = false;
         cmdTemp.enabled = false;
         cmdPower.enabled = false;
      }
      
      private function obf_P_N_2811() : void
      {
         txtType.visible = true;
         txtAttrName.visible = true;
         txtAttr.visible = true;
         txtRank.visible = true;
         txtTime.visible = true;
         txtPressure.visible = true;
         txtTemp.visible = true;
         txtDif.visible = true;
         txtPower.visible = true;
         txtTypeValue.visible = true;
         txtAttrNameValue.visible = true;
         txtAttrValue.visible = true;
         txtRankValue.visible = true;
         txtTimeValue.visible = true;
         txtPressureValue.visible = true;
         txtTempValue.visible = true;
         txtDifValue.visible = true;
         txtPowerValue.visible = true;
         cmdNo.visible = true;
         cmdDo.visible = true;
         txtNeedMoney.visible = true;
         cmdTake.visible = false;
         txtNeedGold.visible = false;
         txtCountdownValue.text = "";
         txtSuccessValue.text = "";
         txtResult.visible = false;
         this._resultBag.dropIconItem();
         cmdOver.enabled = false;
         cmdSave.enabled = false;
         cmdPressure.enabled = false;
         cmdTemp.enabled = false;
         cmdPower.enabled = false;
      }
      
      private function startIncubator() : void
      {
         cmdNo.visible = false;
         cmdDo.visible = false;
         txtNeedMoney.visible = false;
         txtResult.visible = true;
         cmdOver.enabled = true;
         cmdSave.enabled = false;
         cmdPressure.enabled = true;
         cmdTemp.enabled = true;
         cmdPower.enabled = true;
      }
      
      private function obf_F_T_784() : void
      {
         txtSuccessValue.text = "";
         txtResult.visible = true;
         cmdOver.enabled = false;
         cmdSave.enabled = true;
         cmdPressure.enabled = false;
         cmdTemp.enabled = false;
         cmdPower.enabled = false;
      }
      
      private function obf_4_s_4514() : void
      {
         txtType.visible = false;
         txtAttrName.visible = false;
         txtAttr.visible = false;
         txtRank.visible = false;
         txtTime.visible = false;
         txtPressure.visible = false;
         txtTemp.visible = false;
         txtDif.visible = false;
         txtPower.visible = false;
         txtTypeValue.visible = false;
         txtAttrNameValue.visible = false;
         txtAttrValue.visible = false;
         txtRankValue.visible = false;
         txtTimeValue.visible = false;
         txtPressureValue.visible = false;
         txtTempValue.visible = false;
         txtDifValue.visible = false;
         txtPowerValue.visible = false;
         cmdNo.visible = false;
         cmdDo.visible = false;
         txtNeedMoney.visible = false;
         cmdTake.visible = true;
         txtNeedGold.visible = true;
         txtCountdownValue.text = "";
         txtSuccessValue.text = "";
         txtResult.visible = true;
         this._resultBag.dropIconItem();
         cmdOver.enabled = false;
         cmdSave.enabled = false;
         cmdPressure.enabled = false;
         cmdTemp.enabled = false;
         cmdPower.enabled = false;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
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
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
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

