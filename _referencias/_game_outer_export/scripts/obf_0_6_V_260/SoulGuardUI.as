package obf_0_6_V_260
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.soulGuard.SoulGuardInfo;
   import com.sunweb.game.rpg.soulGuard.obf_4_3841;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import playerUI.SoulGuardUIMC;
   
   public class SoulGuardUI extends SoulGuardUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var buttonsArr:Array;
      
      private var txtBuffNameArr:Array;
      
      private var obf_6_O_3686:Array;
      
      private var obf_p_0_2155:Array;
      
      private var _soulGuardList:Array;
      
      private var selectType:int;
      
      private var allBiHuLevel:int;
      
      private var obf_j_F_2142:TimeLimiter;
      
      private var _player:obf_9_c_4534;
      
      public function SoulGuardUI()
      {
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         this.obf_j_F_2142 = new TimeLimiter(2000);
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         bgBox3.mouseEnabled = false;
         txtStar.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtExplain.setTextFormat(_loc1_);
         this.bags = new Array();
         this.obf_6_O_3686 = [this.obf_n_p_1457,this.obf_D_4668,this.obf_5_T_3953,this.obf_1_P_1395,this.obf_B_r_1532,this.obf_t_2_3837,this.obf_r_S_1375];
         this.txtBuffNameArr = [this.txtBuffName1,this.txtBuffName2,this.txtBuffName3,this.txtBuffName4,this.txtBuffName5,this.txtBuffName6,this.txtBuffName7];
         var _loc2_:int = 0;
         while(_loc2_ < this.txtBuffNameArr.length)
         {
            (this.txtBuffNameArr[_loc2_] as TextField).text = DiversityManager.getString("SoulGuardUI","txtBiHu" + _loc2_,[0]);
            _loc2_++;
         }
         this.buttonsArr = [this.cmdUpgrade1,this.cmdUpgrade2,this.cmdUpgrade3,this.cmdUpgrade4,this.cmdUpgrade5,this.cmdUpgrade6,this.cmdUpgrade7];
         this.initDiversity();
         this.obf_p_0_2155 = [DiversityManager.getString("SoulGuardUI","txtName0"),DiversityManager.getString("SoulGuardUI","txtName1"),DiversityManager.getString("SoulGuardUI","txtName2"),DiversityManager.getString("SoulGuardUI","txtName3"),DiversityManager.getString("SoulGuardUI","txtName4"),DiversityManager.getString("SoulGuardUI","txtName5"),DiversityManager.getString("SoulGuardUI","txtName6")];
         listRole.dataProvider = new DataProvider(this.obf_p_0_2155);
         listRole.selectedIndex = 0;
         listRole.rowHeight = 50;
         var _loc3_:int = 1;
         while(_loc3_ < 3)
         {
            _loc4_ = this["upIcon" + _loc3_];
            if(_loc4_)
            {
               _loc5_ = new IconItemBag(_loc4_,this,_loc3_);
               _loc5_.lockDrag = true;
               _loc5_.addValidType(GameItemType.ALL);
               this.bags.push(_loc5_);
            }
            _loc3_++;
         }
         this.showBiHuIcon();
         this.obf_x_v_2806();
      }
      
      private function obf_x_v_2806() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.buttonsArr)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickButton);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.obf_e_r_1572);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.obf_c_h_3872);
         }
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_m_2457);
         listRole.addEventListener(Event.CHANGE,this.onSelectList);
         pointBuffIcon.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         pointBuffIcon.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"SoulGuardUIExplain");
      }
      
      private function removerLsiten() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.buttonsArr)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickButton);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_e_r_1572);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_c_h_3872);
         }
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_m_2457);
         listRole.removeEventListener(Event.CHANGE,this.onSelectList);
         pointBuffIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         pointBuffIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this._player) && this.obf_j_F_2142.checkTimeout())
         {
            this._player.onUpdate();
            this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.LEFT,true);
         }
      }
      
      private function obf_s_m_2457(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < this._soulGuardList.length)
            {
               if(this.selectType == this._soulGuardList[_loc7_].type)
               {
                  _loc2_ = int(this._soulGuardList[_loc7_].guardLevel);
                  _loc3_ = int(this._soulGuardList[_loc7_].blessLevel);
                  break;
               }
               _loc7_++;
            }
         }
         var _loc4_:Object = obf_4_3841.soulGuardJobList(this.selectType);
         var _loc5_:Object = _loc4_.levels[_loc2_].upItems;
         for(_loc6_ in _loc5_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc6_) < _loc5_[_loc6_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("SoulGuardUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc6_),_loc5_[_loc6_]]));
               return;
            }
         }
         obf_4_3841.sendSoulGuardUpReq(this.selectType);
      }
      
      private function onClickButton(param1:MouseEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.buttonsArr.length)
         {
            if(this.buttonsArr[_loc3_].name == param1.currentTarget.name)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < this._soulGuardList.length)
            {
               if(_loc2_ == this._soulGuardList[_loc8_].type)
               {
                  _loc4_ = int(this._soulGuardList[_loc8_].guardLevel);
                  _loc5_ = int(this._soulGuardList[_loc8_].blessLevel);
                  break;
               }
               _loc8_++;
            }
         }
         var _loc6_:String = obf_4_3841.soulGuardUpBlessItemCode();
         var _loc7_:int = obf_4_3841.soulGuardUpBlessItemNums(_loc5_);
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc6_) < _loc7_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("SoulGuardUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc6_),_loc7_]));
            return;
         }
         if(_loc4_ < 10 * _loc5_ + 10)
         {
            WindowManager.showMessageBox(DiversityManager.getString("SoulGuardUI","need_Condition",[this.obf_p_0_2155[_loc2_],_loc5_]));
            return;
         }
         obf_4_3841.sendSoulBlessUpReq(_loc2_);
      }
      
      private function onSelectList(param1:Event) : void
      {
         this.selectType = listRole.selectedIndex;
         this.showSoulGuardInfo(this.selectType);
      }
      
      public function clearContent() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
      }
      
      private function showUpItems(param1:Object) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:IconItemBag = null;
         var _loc7_:IconItem = null;
         for each(_loc2_ in this.bags)
         {
            _loc2_.dropIconItem();
         }
         if(!param1)
         {
            return;
         }
         var _loc3_:Array = new Array();
         for(_loc4_ in param1)
         {
            _loc3_.push({
               "itemCode":_loc4_,
               "itemCount":param1[_loc4_]
            });
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc5_ >= this.bags.length)
            {
               break;
            }
            _loc6_ = this.bags[_loc5_];
            _loc7_ = IconItemManager.getIconItemByCode(_loc3_[_loc5_].itemCode,"");
            _loc7_.itemCount = _loc3_[_loc5_].itemCount;
            _loc6_.pushIconItem(_loc7_);
            _loc5_++;
         }
      }
      
      private function obf_i_3473() : void
      {
         while(pointRoleModel.numChildren > 0)
         {
            pointRoleModel.removeChildAt(0);
         }
         if(this._player)
         {
            this._player.destroy();
         }
         this._player = null;
      }
      
      private function showRoleMode(param1:String) : void
      {
         this.obf_i_3473();
         this._player = new obf_9_c_4534(param1);
         this._player.moveToPixel(0,0);
         this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.LEFT,true);
         pointRoleModel.addChild(this._player);
      }
      
      private function setStart(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         var _loc4_:int = param1 / 10;
         _loc3_ = param1 % 10;
         if(_loc4_ > 0)
         {
            if(_loc3_ == 0)
            {
               _loc3_ = 10;
            }
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ += "★";
            _loc5_++;
         }
         var _loc6_:String = "";
         var _loc7_:int = _loc3_;
         while(_loc7_ < 10)
         {
            _loc6_ += "☆";
            _loc7_++;
         }
         txtStar.htmlText = _loc2_ + "<font color=\'#999999\'>" + _loc6_ + "</font>";
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc6_:* = undefined;
         var _loc2_:GameTipUI = new GameTipUI("SoulGuardIconTip");
         var _loc3_:int = 200;
         if(this.allBiHuLevel < 1)
         {
            _loc4_ = obf_4_3841.soulGuardSoulBlessAttrs(this.allBiHuLevel);
         }
         else
         {
            _loc4_ = obf_4_3841.soulGuardSoulBlessAttrs(this.allBiHuLevel - 1);
         }
         _loc2_.addTipInfo("<P align=\'center\'><FONT color=\'#FF0000\'>" + _loc4_.name + "</FONT></P>",_loc3_,_loc2_.maxRow + 1);
         var _loc5_:Object = _loc4_.attr;
         for(_loc6_ in _loc5_)
         {
            _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc6_) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
            _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc6_,_loc5_[_loc6_]) + "</FONT></P>",_loc3_,_loc2_.maxRow);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("SoulGuardIconTip");
      }
      
      private function obf_e_r_1572(param1:MouseEvent) : void
      {
         var _loc11_:int = 0;
         var _loc2_:GameTipUI = new GameTipUI("SoulGuardButtonTip");
         var _loc3_:int = 200;
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         while(_loc5_ < this.buttonsArr.length)
         {
            if(this.buttonsArr[_loc5_].name == param1.currentTarget.name)
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc11_ = 0;
            while(_loc11_ < this._soulGuardList.length)
            {
               if(_loc4_ == this._soulGuardList[_loc11_].type)
               {
                  _loc6_ = int(this._soulGuardList[_loc11_].guardLevel);
                  _loc7_ = int(this._soulGuardList[_loc11_].blessLevel);
                  break;
               }
               _loc11_++;
            }
         }
         var _loc8_:Array = JSONUtil.getObject(obf_4_3841.soulGuardConfig,["upBlessItemNums"]) as Array;
         if(_loc7_ >= _loc8_.length)
         {
            _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + DiversityManager.getString("SoulGuardUI","maxLevelBihu") + "</FONT>",_loc3_,_loc2_.maxRow + 1);
            return;
         }
         var _loc9_:String = obf_4_3841.soulGuardUpBlessItemCode();
         var _loc10_:int = obf_4_3841.soulGuardUpBlessItemNums(_loc7_);
         _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + DiversityManager.getString("SoulGuardUI","need_UpCondition") + "</FONT>",_loc3_,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + GameItemManager.getItemName(_loc9_) + " x " + _loc10_ + "</FONT>",_loc3_,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + DiversityManager.getString("SoulGuardUI","need_Condition",[this.obf_p_0_2155[_loc4_],_loc7_]) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_c_h_3872(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("SoulGuardButtonTip");
      }
      
      public function soulGuardInfo(param1:SoulGuardInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._soulGuardList.length)
            {
               if(this._soulGuardList[_loc3_].type == param1.type)
               {
                  this._soulGuardList[_loc3_].type = param1.type;
                  this._soulGuardList[_loc3_].guardLevel = param1.guardLevel;
                  this._soulGuardList[_loc3_].blessLevel = param1.blessLevel;
                  _loc2_ = false;
                  break;
               }
               _loc2_ = true;
               _loc3_++;
            }
         }
         else if(param1)
         {
            this._soulGuardList = [];
            this._soulGuardList.push(param1);
         }
         if(_loc2_)
         {
            this._soulGuardList.push(param1);
         }
      }
      
      public function showSoulGuardList(param1:Array) : void
      {
         this._soulGuardList = param1;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.showSoulGuardInfo(param1[_loc2_].type);
            this.showBiHuInfo(param1[_loc2_].type,param1[_loc2_].blessLevel);
            _loc2_++;
         }
      }
      
      public function showSoulGuardInfo(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc15_ = 0;
            while(_loc15_ < this._soulGuardList.length)
            {
               if(param1 == this._soulGuardList[_loc15_].type)
               {
                  _loc2_ = int(this._soulGuardList[_loc15_].guardLevel);
                  _loc3_ = int(this._soulGuardList[_loc15_].blessLevel);
                  break;
               }
               _loc15_++;
            }
         }
         txtCurrentName.text = "";
         txtCurrentAttrName.text = "";
         txtCurrentAttrValue.text = "";
         txtNextName.text = "";
         txtNextAttrName.text = "";
         txtNextAttrValue.text = "";
         var _loc4_:Object = obf_4_3841.soulGuardJobList(param1);
         if(!_loc4_)
         {
            return;
         }
         _loc6_ = _loc2_ % 10;
         if(_loc2_ > 10)
         {
            _loc5_ = (_loc2_ - 1) / 10;
         }
         else
         {
            _loc5_ = 0;
         }
         if(_loc2_ > 0 && _loc6_ == 0)
         {
            _loc6_ = 10;
         }
         txtCurrentName.text = DiversityManager.getString("SoulGuardUI","need_Cond",[this.obf_p_0_2155[param1],_loc5_,_loc6_]);
         var _loc7_:Object = _loc4_.levels[_loc2_];
         if(_loc7_)
         {
            if(_loc7_.model)
            {
               this.showRoleMode(_loc7_.model);
            }
            if(_loc7_.upRate)
            {
               DiversityManager.setTextField(txtChange,"SoulGuardUI","txtChange",[(_loc7_.upRate * 100).toFixed(2)]);
            }
            this.showUpItems(_loc7_.upItems);
         }
         this.setStart(_loc2_);
         if(_loc2_ >= _loc4_.levels.length - 1)
         {
            cmdUp.enabled = false;
            cmdUp.label = DiversityManager.getString("SoulGuardUI","maxLevel");
         }
         else
         {
            cmdUp.enabled = true;
            cmdUp.label = DiversityManager.getString("SoulGuardUI","cmdUp");
         }
         var _loc8_:String = "";
         var _loc9_:String = "";
         if(_loc7_.attr)
         {
            for(_loc16_ in _loc7_.attr)
            {
               _loc8_ += RoleAttributesModifierEnum.getAttributesName(_loc16_) + "\n";
               _loc9_ += RoleAttributesModifierEnum.getAttributesValueString(_loc16_,_loc7_.attr[_loc16_]) + "\n";
            }
         }
         txtCurrentAttrName.text = _loc8_;
         txtCurrentAttrValue.text = _loc9_;
         if(_loc2_ + 1 >= _loc4_.levels.length)
         {
            return;
         }
         _loc10_ = _loc2_ / 10;
         _loc11_ = (_loc2_ + 1) % 10;
         if(_loc2_ > 0)
         {
            if(_loc11_ == 0)
            {
               _loc11_ = 10;
            }
         }
         txtNextName.text = DiversityManager.getString("SoulGuardUI","need_Cond",[this.obf_p_0_2155[param1],_loc10_,_loc11_]);
         var _loc12_:Object = _loc4_.levels[_loc2_ + 1];
         var _loc13_:String = "";
         var _loc14_:String = "";
         if(_loc12_.attr)
         {
            for(_loc17_ in _loc12_.attr)
            {
               _loc13_ += RoleAttributesModifierEnum.getAttributesName(_loc17_) + "\n";
               _loc14_ += RoleAttributesModifierEnum.getAttributesValueString(_loc17_,_loc12_.attr[_loc17_]) + "\n";
            }
         }
         txtNextAttrName.text = _loc13_;
         txtNextAttrValue.text = _loc14_;
      }
      
      public function showAllBiHuInfo(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._soulGuardList.length)
            {
               if(param1 == this._soulGuardList[_loc3_].type)
               {
                  _loc2_ = int(this._soulGuardList[_loc3_].blessLevel);
                  break;
               }
               _loc3_++;
            }
         }
         this.showBiHuInfo(param1,_loc2_);
      }
      
      public function showBiHuInfo(param1:int, param2:int) : void
      {
         this.showBiHuIcon();
         (this.txtBuffNameArr[param1] as TextField).text = DiversityManager.getString("SoulGuardUI","txtBiHu" + param1,[param2]);
         this.buttonsArr[param1].bihuLevel = param2;
         var _loc3_:int = 0;
         while(_loc3_ < this.buttonsArr.length)
         {
            if(this.buttonsArr[_loc3_].bihuLevel > 0)
            {
               (this.obf_6_O_3686[_loc3_] as MovieClip).filters = [obf_9_V_1635.getHighLightFilter()];
            }
            else
            {
               (this.obf_6_O_3686[_loc3_] as MovieClip).filters = [obf_9_V_1635.getGrayFilter()];
            }
            _loc3_++;
         }
         var _loc4_:Array = JSONUtil.getObject(obf_4_3841.soulGuardConfig,["upBlessItemNums"]) as Array;
         if(param2 >= _loc4_.length)
         {
            this.buttonsArr[param1].enabled = false;
            this.buttonsArr[param1].label = DiversityManager.getString("SoulGuardUI","maxLevel");
         }
         else
         {
            this.buttonsArr[param1].enabled = true;
            this.buttonsArr[param1].label = DiversityManager.getString("SoulGuardUI","cmdUpgrade");
         }
      }
      
      private function showBiHuIcon() : void
      {
         var _loc6_:int = 0;
         while(pointBuffIcon.numChildren > 0)
         {
            pointBuffIcon.removeChildAt(0);
         }
         var _loc1_:Array = new Array();
         if(Boolean(this._soulGuardList) && this._soulGuardList.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < this._soulGuardList.length)
            {
               _loc1_.push(this._soulGuardList[_loc6_].blessLevel);
               _loc6_++;
            }
         }
         else
         {
            _loc1_ = [];
         }
         _loc1_.sort(Array.NUMERIC);
         var _loc2_:int = 0;
         if(_loc1_.length == 7)
         {
            _loc2_ = int(_loc1_[0]);
         }
         this.allBiHuLevel = _loc2_;
         var _loc3_:String = "c112@t21";
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         var _loc4_:Object = obf_4_3841.soulGuardSoulBlessAttrs(_loc2_ - 1);
         _loc3_ = _loc4_.pic;
         var _loc5_:DisplayObject = ResourceManager.instance.getDisplayObject(_loc3_);
         if(_loc5_)
         {
            if(this.allBiHuLevel < 1)
            {
               _loc5_.filters = [obf_9_V_1635.getGrayFilter()];
            }
            else
            {
               _loc5_.filters = [new GlowFilter(65280,1,2,2,1000,1)];
            }
            pointBuffIcon.addChild(_loc5_);
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"SoulGuardUI","txtDeyTitle");
         DiversityManager.setTextField(txtCurrent,"SoulGuardUI","txtCurrent");
         DiversityManager.setTextField(txtNext,"SoulGuardUI","txtNext");
         DiversityManager.setTextField(txtUpMaterial,"SoulGuardUI","txtUpMaterial");
         DiversityManager.setTextField(txtChange,"SoulGuardUI","txtChange",[0]);
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("SoulGuardUI","txtExplain") + "</a>";
         cmdUp.label = DiversityManager.getString("SoulGuardUI","cmdUp");
         var _loc1_:int = 0;
         while(_loc1_ < this.buttonsArr.length)
         {
            this.buttonsArr[_loc1_].label = DiversityManager.getString("SoulGuardUI","cmdUpgrade");
            _loc1_++;
         }
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showSoulGuardInfo(this.selectType);
         this.showAllBiHuInfo(this.selectType);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removerLsiten();
         this.bags = null;
         this.obf_i_3473();
      }
   }
}

