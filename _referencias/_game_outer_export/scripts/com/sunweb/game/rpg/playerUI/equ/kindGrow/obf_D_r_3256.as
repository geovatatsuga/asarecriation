package com.sunweb.game.rpg.playerUI.equ.kindGrow
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.equipKindGrowUIMC;
   
   public class obf_D_r_3256 extends equipKindGrowUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var obf_D_X_2535:Object;
      
      private var obf_a_W_798:Object;
      
      private var _kindConfig:Object;
      
      private var _bags:Array;
      
      public function obf_D_r_3256()
      {
         var _loc3_:IconItemBag = null;
         this.obf_a_W_798 = new Object();
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         kind0.gotoAndStop(2);
         var _loc1_:int = 1;
         while(_loc1_ < 8)
         {
            this["kind" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         growBarExp.gotoAndStop(1);
         this._bags = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 7)
         {
            _loc3_ = new IconItemBag(this["icon" + _loc2_],this,_loc2_);
            _loc3_.addValidType(GameItemType.EQUIPMENT);
            _loc3_.lockDrag = true;
            this._bags.push(_loc3_);
            _loc2_++;
         }
         this.initDiversity();
         this.addListener();
      }
      
      public function get kindInfoMap() : Object
      {
         return this.obf_a_W_798;
      }
      
      public function setKindInfoMap(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         this.obf_a_W_798 = param1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc3_:Object = null;
         DiversityManager.setTextField(txtTitle,"equipKindGrowUI","txtTitle");
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("equipKindGrowUI","txtInfo") + "</a>";
         var _loc1_:Array = EquipKindGrowManager.kindConfig;
         if(!_loc1_)
         {
            return;
         }
         this.obf_D_X_2535 = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = _loc1_[_loc2_];
            this.obf_D_X_2535["kind" + _loc2_] = _loc3_;
            this["kind" + _loc2_].txtLabel.htmlText = EquipmentKind.getKindName(JSONUtil.getInt(_loc3_,["kind"]));
            this["kind" + _loc2_].txtLevel.htmlText = DiversityManager.getString("equipKindGrowUI","txtLv",[JSONUtil.getInt(_loc3_,["openLevel"])]);
            _loc2_++;
         }
         DiversityManager.setTextField(txtLevel0,"equipKindGrowUI","txtLevel0");
         DiversityManager.setTextField(txtThisLv0,"equipKindGrowUI","txtThisLv0");
         DiversityManager.setTextField(txtNextLv0,"equipKindGrowUI","txtNextLv0");
         cmdBreach.label = DiversityManager.getString("equipKindGrowUI","cmdBreach");
         cmdBless.label = DiversityManager.getString("equipKindGrowUI","cmdBless");
         DiversityManager.setTextField(txtTip0,"equipKindGrowUI","txtTip0");
         DiversityManager.setTextField(txtTip1,"equipKindGrowUI","txtTip1");
         cmdAuto.label = DiversityManager.getString("equipKindGrowUI","cmdAuto");
         cmdAddExp.label = DiversityManager.getString("equipKindGrowUI","cmdAddExp");
         DiversityManager.setTextField(txtThisTitle,"equipKindGrowUI","txtThisTitle");
         DiversityManager.setTextField(txtNextTitle,"equipKindGrowUI","txtNextTitle");
         cmdTemper.label = DiversityManager.getString("equipKindGrowUI","cmdTemper");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"txtEquipKindGrowInfo");
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            this["kind" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_0_7_612);
            _loc1_++;
         }
         cmdBreach.addEventListener(MouseEvent.CLICK,this.onBreach);
         cmdBreach.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdBreach.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdAuto.addEventListener(MouseEvent.CLICK,this.obf_x_n_2899);
         cmdAddExp.addEventListener(MouseEvent.CLICK,this.obf_6_L_3767);
         cmdTemper.addEventListener(MouseEvent.CLICK,this.onTemper);
      }
      
      public function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            this["kind" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_0_7_612);
            _loc1_++;
         }
         cmdBreach.removeEventListener(MouseEvent.CLICK,this.onBreach);
         cmdBreach.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdBreach.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdAuto.removeEventListener(MouseEvent.CLICK,this.obf_x_n_2899);
         cmdAddExp.removeEventListener(MouseEvent.CLICK,this.obf_6_L_3767);
         cmdTemper.removeEventListener(MouseEvent.CLICK,this.onTemper);
      }
      
      public function obf_6_L_3767(param1:MouseEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         if(cmdBreach.visible && growBarExp.currentFrame == 100)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("equipKindGrowUI","onBreach"));
            return;
         }
         var _loc2_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc3_:Array = new Array();
         for each(_loc4_ in this._bags)
         {
            if(_loc4_.haveIconItem)
            {
               _loc5_ = _loc4_.haveIconItem.itemId;
               if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(_loc5_))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
                  return;
               }
               _loc3_.push(_loc5_);
            }
         }
         EquipKindGrowManager.onKindGrowAddExpRequest(_loc2_,_loc3_);
      }
      
      public function obf_x_n_2899(param1:MouseEvent) : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:IconItem = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Array = new Array();
         for each(_loc3_ in obf_K_e_3075.playerBagUI.allBags)
         {
            _loc4_ = _loc3_.haveIconItem;
            if((Boolean(_loc4_)) && _loc4_ is IconItemEquip)
            {
               _loc5_ = GameItemManager.getItemConfig(_loc4_.itemCode);
               if(_loc5_)
               {
                  _loc6_ = JSONUtil.getInt(this._kindConfig,["kind"]);
                  _loc7_ = JSONUtil.getInt(_loc5_,["properties","kind"]);
                  if(_loc6_ == _loc7_)
                  {
                     _loc8_ = JSONUtil.getInt(_loc5_,["rank"]);
                     if(_loc8_ >= 1)
                     {
                        _loc2_.push(_loc4_.clone());
                     }
                  }
               }
            }
         }
         if(_loc2_)
         {
            _loc2_.sortOn("iconItemRank",Array.NUMERIC);
            _loc9_ = 0;
            while(_loc9_ < 7)
            {
               if(_loc9_ >= _loc2_.length)
               {
                  break;
               }
               this._bags[_loc9_].pushIconItem(_loc2_[_loc9_]);
               _loc9_++;
            }
         }
      }
      
      public function onTemper(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:obf_0_1_e_423 = obf_K_e_3075.equipKindGrowTemperUI;
         if(_loc2_.visible)
         {
            obf_K_e_3075.closeUI(_loc2_);
         }
         else
         {
            _loc2_.setParam(JSONUtil.getInt(this._kindConfig,["kind"]),JSONUtil.getValue(this._kindConfig,["addAttr"]) as Array);
            _loc2_.obf_V_i_4058();
            _loc2_.refresh();
            _loc2_.x = this.x;
            _loc2_.y = this.y;
            obf_K_e_3075.showUI(_loc2_);
         }
      }
      
      public function obf_K_t_1144(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:EquipKindGrowBlessUI = obf_K_e_3075.equipKindGrowBlessUI;
         if(_loc2_.visible)
         {
            obf_K_e_3075.closeUI(_loc2_);
         }
         else
         {
            _loc2_.setKind(JSONUtil.getInt(this._kindConfig,["kind"]));
            _loc2_.refresh();
            _loc2_.x = this.x;
            _loc2_.y = this.y;
            obf_K_e_3075.showUI(_loc2_);
         }
      }
      
      public function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("cmdBreach");
         var _loc3_:int = 120;
         var _loc4_:String = "";
         var _loc5_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc6_:EquipKindGrowInfo = this.obf_a_W_798[_loc5_];
         if(!_loc6_)
         {
            _loc6_ = new EquipKindGrowInfo();
            _loc6_.init(_loc5_);
         }
         var _loc7_:Object = EquipKindGrowManager.breachMap[_loc6_.level];
         if(!_loc7_)
         {
            return;
         }
         for(_loc8_ in _loc7_)
         {
            _loc10_ = int(_loc7_[_loc8_]);
            if(_loc10_ > 0)
            {
               _loc11_ = GameItemManager.getItemName(_loc8_);
               _loc4_ += "\n" + _loc11_ + "x" + _loc10_;
            }
         }
         _loc9_ = DiversityManager.getString("equipKindGrowUI","tipBreach",[_loc4_]);
         _loc2_.addTipInfo(_loc9_,_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      public function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("cmdBreach");
      }
      
      public function onBreach(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc3_:EquipKindGrowInfo = this.obf_a_W_798[_loc2_];
         if(!_loc3_)
         {
            _loc3_ = new EquipKindGrowInfo();
            _loc3_.init(_loc2_);
         }
         var _loc4_:Object = EquipKindGrowManager.breachMap[_loc3_.level];
         if(!_loc4_)
         {
            return;
         }
         for(_loc5_ in _loc4_)
         {
            _loc6_ = int(_loc4_[_loc5_]);
            if(_loc6_ > obf_K_e_3075.playerBagUI.getItemCount(_loc5_))
            {
               WindowManager.showMessageBox(DiversityManager.getString("equipKindGrowUI","noItem"));
               return;
            }
         }
         EquipKindGrowManager.onKindGrowBreachRequest(_loc2_);
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         if(!this._kindConfig)
         {
            this._kindConfig = this.obf_D_X_2535[kind0.name];
            this.obf_r_g_3499();
            this.obf_v_Y_799();
         }
         this.visible = true;
         obf_K_e_3075.playerBagUI.x = this.x + 500;
         obf_K_e_3075.playerBagUI.y = this.y;
         obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_0_8_7_127();
         obf_K_e_3075.closeUI(obf_K_e_3075.playerBagUI);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(param1.haveIconItem)
         {
            param1.dropIconItem();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(this._bags.indexOf(param1) > -1 && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      private function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc4_:int = JSONUtil.getInt(_loc2_,["properties","kind"]);
         if(_loc3_ != _loc4_)
         {
            return;
         }
         var _loc5_:int = JSONUtil.getInt(_loc2_,["rank"]);
         if(_loc5_ < 1)
         {
            return;
         }
         var _loc6_:int = 0;
         while(_loc6_ < 7)
         {
            if(Boolean(this._bags[_loc6_].haveIconItem) && this._bags[_loc6_].haveIconItem.itemId == param1.itemId)
            {
               return;
            }
            _loc6_++;
         }
         var _loc7_:IconItemBag = this.getNextBag();
         if(_loc7_)
         {
            _loc7_.pushIconItem(param1);
         }
      }
      
      private function getNextBag() : IconItemBag
      {
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            if(!this._bags[_loc1_].haveIconItem)
            {
               return this._bags[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function obf_0_8_7_127() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            if(this._bags[_loc1_].haveIconItem)
            {
               this._bags[_loc1_].dropIconItem();
            }
            _loc1_++;
         }
      }
      
      public function obf_0_7_612(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == 2)
         {
            return;
         }
         var _loc3_:Object = this.obf_D_X_2535[_loc2_.name];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:obf_U_6_3454 = GameContext.localPlayer;
         if(_loc4_.level < JSONUtil.getInt(_loc3_,["openLevel"]))
         {
            return;
         }
         this._kindConfig = _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ < 8)
         {
            if(this["kind" + _loc5_] == _loc2_)
            {
               _loc2_.gotoAndStop(2);
            }
            else
            {
               this["kind" + _loc5_].gotoAndStop(1);
            }
            _loc5_++;
         }
         this.obf_r_g_3499();
         this.obf_v_Y_799();
         this.obf_0_8_7_127();
      }
      
      public function obf_r_g_3499() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         cmdBreach.visible = false;
         var _loc1_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc2_:EquipKindGrowInfo = this.obf_a_W_798[_loc1_];
         if(!_loc2_)
         {
            _loc2_ = new EquipKindGrowInfo();
            _loc2_.init(_loc1_);
         }
         if(EquipKindGrowManager.breachMap[_loc2_.level])
         {
            cmdBreach.visible = true;
         }
         txtKindTitle.text = DiversityManager.getString("equipKindGrowUI","txtKindTitle",[EquipmentKind.getKindName(_loc1_)]);
         txtLevel.text = _loc2_.level + "/" + EquipKindGrowManager.expList.length;
         if(_loc2_.level >= EquipKindGrowManager.expList.length)
         {
            growBarExp.gotoAndStop(100);
            txtExp.text = DiversityManager.getString("equipKindGrowUI","maxLv");
         }
         else
         {
            _loc4_ = int(EquipKindGrowManager.expList[_loc2_.level]);
            _loc5_ = _loc2_.exp / _loc4_ * 100;
            growBarExp.gotoAndStop(_loc5_);
            txtExp.text = _loc2_.exp + "/" + _loc4_;
         }
         var _loc3_:Array = JSONUtil.getValue(this._kindConfig,["addRates"]) as Array;
         if(_loc3_)
         {
            _loc6_ = Number(_loc3_[_loc2_.level]);
            txtThisLv1.htmlText = "<font color=\'#00FF00\'>" + Math.round(_loc6_ * 100) + "%</font>";
            if(_loc2_.level >= _loc3_.length - 1)
            {
               txtNextLv1.htmlText = "<font color=\'#00FF00\'>" + Math.round(_loc6_ * 100) + "%</font>";
            }
            else
            {
               _loc7_ = Number(_loc3_[_loc2_.level + 1]);
               txtNextLv1.htmlText = "<font color=\'#00FF00\'>" + Math.round(_loc7_ * 100) + "%</font>";
            }
         }
      }
      
      public function obf_v_Y_799() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc1_:int = JSONUtil.getInt(this._kindConfig,["kind"]);
         var _loc2_:Array = JSONUtil.getValue(this._kindConfig,["addAttr"]);
         _loc2_.sortOn("attr",Array.NUMERIC);
         var _loc3_:EquipKindGrowInfo = this.obf_a_W_798[_loc1_];
         if(!_loc3_)
         {
            _loc3_ = new EquipKindGrowInfo();
            _loc3_.init(_loc1_);
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = int(_loc2_[_loc4_].attr);
            _loc6_ = _loc2_[_loc4_].value * _loc3_.level;
            _loc7_ = _loc2_[_loc4_].value * (_loc3_.level + 1);
            _loc8_ = 0;
            _loc9_ = 0;
            if(_loc3_.temper)
            {
               _loc10_ = Number(_loc3_.temper[_loc5_]);
               _loc8_ = Math.round(_loc6_ * _loc10_);
               _loc9_ = Math.round(_loc7_ * _loc10_);
            }
            this["txtThisAttr" + _loc4_].htmlText = "<font color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc5_) + "</font>";
            this["txtThisAttrNum" + _loc4_].htmlText = "<font color=\'#00FF00\'>+" + _loc6_ + "</font><font color=\'#FF0000\'>(" + _loc8_ + ")</font>";
            this["txtNextAttr" + _loc4_].htmlText = "<font color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc5_) + "</font>";
            this["txtNextAttrNum" + _loc4_].htmlText = "<font color=\'#00FF00\'>+" + _loc7_ + "</font><font color=\'#FF0000\'>(" + _loc9_ + ")</font>";
            _loc4_++;
         }
      }
   }
}

