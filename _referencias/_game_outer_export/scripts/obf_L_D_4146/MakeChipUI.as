package obf_L_D_4146
{
   import obf_H_I_939.obf_u_Z_4014;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
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
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import playerUI.MakeChipUIMC;
   
   public class MakeChipUI extends MakeChipUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var allBags:Array;
      
      private var obf_0_5_B_120:Array;
      
      private var obf_B_Z_3459:Array;
      
      private var obf_G_f_2680:Array;
      
      private var obf_0_6_w_695:Array;
      
      private var obf_I_7_2083:Array;
      
      private var clickBaoXiangIndex:int = -1;
      
      private var obf_G_n_3349:Array;
      
      private var obf_F_m_3541:Array;
      
      private var clickBadKeyIndex:int = -1;
      
      private var isClickKeyButt:Boolean = false;
      
      private var allMC:Array;
      
      private var obf_0___A_347:Array;
      
      private var makeMaterialIconBag:IconItemBag;
      
      private var makeGoodsIconBag:IconItemBag;
      
      private var obf_0_6_x_528:Array;
      
      private var iconComSuiPianIconBag:IconItemBag;
      
      private var obf_R_n_2303:IconItemBag;
      
      private var powerArr:Array;
      
      private var buttonTips:Array;
      
      public var chipBoxs:Object;
      
      public var chipKeys:Object;
      
      public var chips:Object;
      
      public var chipSupers:Object;
      
      public var chipAttrs:Object;
      
      public var chipBadKeys:Object;
      
      private var obf_q_p_3637:Array;
      
      public var clickSunIndex:int = 0;
      
      private var boxId:String;
      
      private var obf_b_u_2548:String = "";
      
      private var obf_7_L_882:int = 0;
      
      public function MakeChipUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         bgBox1.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         this.init();
         this.initBox();
         this.addListener();
      }
      
      private function init() : void
      {
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         var _loc10_:MovieClip = null;
         var _loc11_:IconItemBag = null;
         var _loc12_:MovieClip = null;
         var _loc13_:IconItemBag = null;
         this.obf_0_5_B_120 = [this.cmdTable1,this.cmdTable2,this.cmdTable3];
         this.obf_B_Z_3459 = [this.txtKeyNum1,this.txtKeyNum2,this.txtKeyNum3,this.txtKeyNum4];
         var _loc1_:Array = obf_u_Z_4014.makeChipKeys;
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_B_Z_3459.length)
         {
            this.obf_B_Z_3459[_loc2_].text = 0 + "";
            _loc2_++;
         }
         this.obf_G_f_2680 = [this.txtJingNum1,this.txtJingNum2,this.txtJingNum3];
         var _loc3_:Array = obf_u_Z_4014.makeChipSupers;
         var _loc4_:int = 0;
         while(_loc4_ < this.obf_G_f_2680.length)
         {
            this.obf_G_f_2680[_loc4_].text = 0 + "";
            _loc4_++;
         }
         this.allBags = new Array();
         this.obf_0___A_347 = new Array();
         var _loc5_:int = 1;
         while(_loc5_ <= 20)
         {
            _loc8_ = this["suiPianMC1"]["suiIcon" + _loc5_];
            if(_loc8_ != null)
            {
               _loc9_ = new IconItemBag(_loc8_,this,_loc5_);
               _loc9_.addValidType(GameItemType.ALL);
               this.obf_0___A_347.push(_loc9_);
               this.allBags.push(_loc9_);
            }
            _loc5_++;
         }
         this.obf_0_6_x_528 = new Array();
         var _loc6_:int = 1;
         while(_loc6_ <= 20)
         {
            _loc10_ = this["decomposeMC"]["decIcon" + _loc6_];
            if(_loc10_ != null)
            {
               _loc11_ = new IconItemBag(_loc10_,this,_loc6_);
               _loc11_.addValidType(GameItemType.ALL);
               this.obf_0_6_x_528.push(_loc11_);
               this.allBags.push(_loc11_);
            }
            _loc6_++;
         }
         this.iconComSuiPianIconBag = new IconItemBag(obf_W_C_3703.iconComSuiPian,this,0);
         this.iconComSuiPianIconBag.lockDrag = true;
         this.iconComSuiPianIconBag.addValidType(GameItemType.ALL);
         this.allBags.push(this.iconComSuiPianIconBag);
         this.obf_R_n_2303 = new IconItemBag(obf_W_C_3703.comIconGoods,this,0);
         this.obf_R_n_2303.lockDrag = true;
         this.obf_R_n_2303.showInfoTip = true;
         this.obf_R_n_2303.addValidType(GameItemType.ALL);
         this.allBags.push(this.obf_R_n_2303);
         this.powerArr = new Array();
         var _loc7_:int = 1;
         while(_loc7_ <= 10)
         {
            _loc12_ = this["powerMC"]["powerMCIcon" + _loc7_];
            if(_loc12_ != null)
            {
               _loc13_ = new IconItemBag(_loc12_,this,_loc7_);
               _loc13_.showInfoTip = true;
               _loc13_.addValidType(GameItemType.ALL);
               this.powerArr.push(_loc13_);
               this.allBags.push(_loc13_);
            }
            _loc7_++;
         }
      }
      
      private function initBox() : void
      {
         this.hideComDec();
         this.hideShowSubButt(false);
         this.obf_0_6_w_695 = [this.boxKeyButtonMC.cmdBaoXiang1,this.boxKeyButtonMC.cmdBaoXiang2,this.boxKeyButtonMC.cmdBaoXiang3,this.boxKeyButtonMC.cmdBaoXiang4];
         var _loc1_:Array = obf_u_Z_4014.makeChipBox;
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_6_w_695.length)
         {
            (this.obf_0_6_w_695[_loc2_] as MovieClip).gotoAndStop(1);
            this.obf_0_6_w_695[_loc2_].count = 0;
            if(_loc1_)
            {
               this.obf_0_6_w_695[_loc2_].conf = _loc1_[_loc2_];
            }
            _loc2_++;
         }
         this.obf_I_7_2083 = [this.boxKeyButtonMC.txtNum1,this.boxKeyButtonMC.txtNum2,this.boxKeyButtonMC.txtNum3,this.boxKeyButtonMC.txtNum4];
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_I_7_2083.length)
         {
            this.obf_I_7_2083[_loc3_].text = this.obf_0_6_w_695[_loc3_].count + "";
            _loc3_++;
         }
         this.obf_G_n_3349 = [this.boxKeyButtonMC.cmdYaoshi1,this.boxKeyButtonMC.cmdYaoshi2,this.boxKeyButtonMC.cmdYaoshi3,this.boxKeyButtonMC.cmdYaoshi4];
         var _loc4_:Array = obf_u_Z_4014.makeChipBadKeys;
         var _loc5_:int = 0;
         while(_loc5_ < this.obf_G_n_3349.length)
         {
            (this.obf_G_n_3349[_loc5_] as MovieClip).gotoAndStop(1);
            if(_loc4_)
            {
               this.obf_G_n_3349[_loc5_].badId = _loc4_[_loc5_];
            }
            _loc5_++;
         }
         this.obf_F_m_3541 = [this.boxKeyButtonMC.txtNum5,this.boxKeyButtonMC.txtNum6,this.boxKeyButtonMC.txtNum7,this.boxKeyButtonMC.txtNum8];
         var _loc6_:int = 0;
         while(_loc6_ < this.obf_F_m_3541.length)
         {
            this.obf_F_m_3541[_loc6_].text = 0 + "";
            _loc6_++;
         }
         this.obf_b_n_1143();
         this.setChildIndex(boxKeyButtonMC,this.numChildren - 1);
         this.setChildIndex(openMC,this.numChildren - 1);
         this.showOpenBoxPic();
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdMaterial.addEventListener(MouseEvent.CLICK,this.obf_h_b_1509);
         cmdOwn.addEventListener(MouseEvent.CLICK,this.obf_f_V_775);
         cmdPower.addEventListener(MouseEvent.CLICK,this.obf_D_1_4003);
         cmdCompound.addEventListener(MouseEvent.CLICK,this.obf_Z_8_2868);
         cmdDecompose.addEventListener(MouseEvent.CLICK,this.onClickDecompose);
         for each(_loc1_ in this.obf_0_5_B_120)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_0_4_p_531);
         }
         for each(_loc2_ in this.obf_0_6_w_695)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.obf_T_P_3542);
         }
         for each(_loc3_ in this.obf_G_n_3349)
         {
            _loc3_.addEventListener(MouseEvent.CLICK,this.obf_0_7_C_236);
         }
         openMC.cmdOpen1.addEventListener(MouseEvent.CLICK,this.obf_E_B_2708);
         openMC.cmdOpen10.addEventListener(MouseEvent.CLICK,this.onClickCmdOpen10);
         makeMC.cmdMake1.addEventListener(MouseEvent.CLICK,this.obf_u_k_4016);
         makeMC.cmdMake10.addEventListener(MouseEvent.CLICK,this.onClickCmdMake10);
         obf_W_C_3703.cmdRefine.addEventListener(MouseEvent.CLICK,this.obf_0_6_u_650);
         decomposeMC.cmdSeparate.addEventListener(MouseEvent.CLICK,this.obf_0_3_3_445);
         decomposeMC.cmdDec.addEventListener(MouseEvent.CLICK,this.obf_4_y_1789);
         this.obf_R_n_2303.addEventListener(MouseEvent.MOUSE_OVER,this.obf_W_J_3527);
         this.obf_R_n_2303.addEventListener(MouseEvent.MOUSE_OUT,this.obf_4_2_4213);
         _loc4_ = 0;
         while(_loc4_ < this.obf_0_6_w_695.length)
         {
            obf_K_e_3075.addUIMouseToolTip(this.obf_0_6_w_695[_loc4_],"MakeChipUI_BaoXiangTips_" + _loc4_);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.obf_G_n_3349.length)
         {
            obf_K_e_3075.addUIMouseToolTip(this.obf_G_n_3349[_loc5_],"MakeChipUI_BadKeyTips");
            _loc5_++;
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdMaterial.removeEventListener(MouseEvent.CLICK,this.obf_h_b_1509);
         cmdOwn.removeEventListener(MouseEvent.CLICK,this.obf_f_V_775);
         cmdPower.removeEventListener(MouseEvent.CLICK,this.obf_D_1_4003);
         cmdCompound.removeEventListener(MouseEvent.CLICK,this.obf_Z_8_2868);
         cmdDecompose.removeEventListener(MouseEvent.CLICK,this.onClickDecompose);
         for each(_loc1_ in this.obf_0_5_B_120)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_0_4_p_531);
         }
         for each(_loc2_ in this.obf_0_6_w_695)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.obf_T_P_3542);
         }
         for each(_loc3_ in this.obf_G_n_3349)
         {
            _loc3_.removeEventListener(MouseEvent.CLICK,this.obf_0_7_C_236);
         }
         openMC.cmdOpen1.removeEventListener(MouseEvent.CLICK,this.obf_E_B_2708);
         openMC.cmdOpen10.removeEventListener(MouseEvent.CLICK,this.onClickCmdOpen10);
         makeMC.cmdMake1.removeEventListener(MouseEvent.CLICK,this.obf_u_k_4016);
         makeMC.cmdMake10.removeEventListener(MouseEvent.CLICK,this.onClickCmdMake10);
         obf_W_C_3703.cmdRefine.removeEventListener(MouseEvent.CLICK,this.obf_0_6_u_650);
         decomposeMC.cmdSeparate.removeEventListener(MouseEvent.CLICK,this.obf_0_3_3_445);
         decomposeMC.cmdDec.removeEventListener(MouseEvent.CLICK,this.obf_4_y_1789);
         this.obf_R_n_2303.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_W_J_3527);
         this.obf_R_n_2303.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_4_2_4213);
         _loc4_ = 0;
         while(_loc4_ < this.obf_0_6_w_695.length)
         {
            obf_K_e_3075.removeUIMouseToolTip(this.obf_0_6_w_695[_loc4_]);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.obf_G_n_3349.length)
         {
            obf_K_e_3075.removeUIMouseToolTip(this.obf_G_n_3349[_loc5_]);
            _loc5_++;
         }
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
      
      private function obf_h_b_1509(param1:Event) : void
      {
         this.hideClickBaoXiang();
         this.hideComDec();
         this.hideClickBadKey();
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_5_B_120.length)
         {
            (this.obf_0_5_B_120[_loc2_] as MovieClip).gotoAndStop(1);
            (this.obf_0_5_B_120[_loc2_] as MovieClip).visible = false;
            _loc2_++;
         }
         this.obf_b_n_1143();
         this.setChildIndex(boxKeyButtonMC,this.numChildren - 1);
         this.setChildIndex(openMC,this.numChildren - 1);
         this.clickBaoXiangIndex = -1;
         this.clickBadKeyIndex = -1;
         this.showOpenBoxPic(1);
      }
      
      private function obf_f_V_775(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_5_B_120.length)
         {
            (this.obf_0_5_B_120[_loc2_] as MovieClip).gotoAndStop(1);
            (this.obf_0_5_B_120[_loc2_] as MovieClip).visible = true;
            _loc2_++;
         }
         this.obf_b_n_1143();
         this.obf_P_p_3048();
         this.hideComDec(true);
         (this.obf_0_5_B_120[0] as MovieClip).gotoAndStop(2);
         this.showSubIncons(1);
         this.obf_Z_8_2868(null);
         this.setChildIndex(suiPianMC1,this.numChildren - 1);
      }
      
      private function obf_D_1_4003(param1:Event) : void
      {
         this.obf_0_8_n_484();
         this.obf_b_n_1143();
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_5_B_120.length)
         {
            (this.obf_0_5_B_120[_loc2_] as MovieClip).gotoAndStop(1);
            (this.obf_0_5_B_120[_loc2_] as MovieClip).visible = false;
            _loc2_++;
         }
         this.hideComDec();
         this.setChildIndex(powerMC,this.numChildren - 1);
         this.obf_S_n_891();
      }
      
      private function obf_0_8_n_484() : void
      {
         powerMC.powerMCName.text = "";
         powerMC.powerMCCurrent.visible = false;
         powerMC.powerMCCurrentAttrName.text = "";
         powerMC.powerMCCurrentAttrValue.text = "";
         powerMC.powerMCNext.visible = false;
         powerMC.powerMCNextAttrName.text = "";
         powerMC.powerMCNextAttrValue.text = "";
      }
      
      private function obf_N_c_4315(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc5_:Object = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         this.obf_0_8_n_484();
         var _loc2_:Array = obf_u_Z_4014.makeChipMakeChipConfig;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            if(param1.currentTarget.par.comId == _loc2_[_loc6_].id)
            {
               _loc4_ = int(param1.currentTarget.par.value);
               _loc5_ = _loc2_[_loc6_];
               _loc3_ = _loc2_[_loc6_].name;
               break;
            }
            _loc6_++;
         }
         if(_loc4_ < 1)
         {
            DiversityManager.setTextField(powerMC.powerMCName,"MakeChipUI","powerMC_powerMCActName");
            return;
         }
         powerMC.powerMCCurrent.visible = true;
         powerMC.powerMCName.text = _loc3_ + "Lv." + _loc4_;
         var _loc7_:String = "";
         var _loc8_:String = "";
         var _loc9_:Object = _loc5_.levels[_loc4_];
         if(_loc9_.attr)
         {
            for(_loc13_ in _loc9_.attr)
            {
               _loc7_ += RoleAttributesModifierEnum.getAttributesName(_loc13_) + "\n";
               _loc8_ += RoleAttributesModifierEnum.getAttributesValueString(_loc13_,_loc9_.attr[_loc13_]) + "\n";
            }
         }
         powerMC.powerMCCurrentAttrName.text = _loc7_;
         powerMC.powerMCCurrentAttrValue.text = _loc8_;
         if(_loc4_ + 1 >= _loc5_.levels.length)
         {
            return;
         }
         powerMC.powerMCNext.visible = true;
         var _loc10_:Object = _loc5_.levels[_loc4_ + 1];
         var _loc11_:String = "";
         var _loc12_:String = "";
         if(_loc10_.attr)
         {
            for(_loc14_ in _loc10_.attr)
            {
               _loc11_ += RoleAttributesModifierEnum.getAttributesName(_loc14_) + "\n";
               _loc12_ += RoleAttributesModifierEnum.getAttributesValueString(_loc14_,_loc10_.attr[_loc14_]) + "\n";
            }
         }
         powerMC.powerMCNextAttrName.text = _loc11_;
         powerMC.powerMCNextAttrValue.text = _loc12_;
      }
      
      private function obf_Z_8_2868(param1:Event) : void
      {
         this.obf_P_p_3048();
         this.showComJingSuiPic();
         this.setChildIndex(obf_W_C_3703,this.numChildren - 1);
      }
      
      private function onClickDecompose(param1:Event) : void
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_0_6_x_528)
         {
            _loc2_.dropIconItem();
         }
         this.setChildIndex(decomposeMC,this.numChildren - 1);
      }
      
      private function obf_0_4_p_531(param1:Event) : void
      {
         var _loc2_:int = this.obf_0_5_B_120.indexOf(param1.currentTarget) + 1;
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_0_5_B_120.length)
         {
            (this.obf_0_5_B_120[_loc3_] as MovieClip).gotoAndStop(_loc3_ + 1 == _loc2_ ? 2 : 1);
            _loc3_++;
         }
         this.showSubIncons(_loc2_);
         this.obf_Z_8_2868(null);
      }
      
      public function showSubIncons(param1:int = 1) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:IconItemBag = null;
         var _loc9_:IconItem = null;
         this.clickSunIndex = param1;
         this.setChildIndex(suiPianMC1,this.numChildren - 1);
         var _loc2_:Array = obf_u_Z_4014.makeChipChips;
         var _loc3_:int = 0;
         for each(_loc4_ in this.obf_0___A_347)
         {
            _loc4_.dropIconItem();
         }
         for each(_loc5_ in this.obf_0_6_x_528)
         {
            _loc5_.dropIconItem();
         }
         this.iconComSuiPianIconBag.dropIconItem();
         this.obf_R_n_2303.dropIconItem();
         obf_W_C_3703.txtName.text = "";
         for(_loc6_ in this.chips)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               if(_loc6_ == _loc2_[_loc7_].id)
               {
                  if(param1 == _loc2_[_loc7_].type)
                  {
                     if(_loc3_ >= this.obf_0___A_347.length)
                     {
                        break;
                     }
                     _loc8_ = this.obf_0___A_347[_loc3_];
                     _loc9_ = IconItemManager.getIconItemByCode(_loc2_[_loc7_].pic,"");
                     if(!_loc9_)
                     {
                        return;
                     }
                     if(this.chips[_loc6_] > 0)
                     {
                        _loc9_.itemCount = this.chips[_loc6_];
                        _loc8_.pushIconItem(_loc9_);
                        _loc3_++;
                     }
                  }
               }
               _loc7_++;
            }
         }
      }
      
      private function obf_T_P_3542(param1:Event) : void
      {
         this.isClickKeyButt = false;
         this.clickBaoXiangIndex = this.obf_0_6_w_695.indexOf(param1.currentTarget);
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_6_w_695.length)
         {
            (this.obf_0_6_w_695[_loc2_] as MovieClip).gotoAndStop(_loc2_ == this.clickBaoXiangIndex ? 2 : 1);
            if(_loc2_ == this.clickBaoXiangIndex)
            {
               this.obf_0_6_w_695[_loc2_].filters = [new GlowFilter(65280,1,2,2,1000,1)];
            }
            else
            {
               this.obf_0_6_w_695[_loc2_].filters = [];
            }
            _loc2_++;
         }
         this.hideClickBadKey();
         this.openBaoXiangKey(this.isClickKeyButt);
         this.showOpenBoxPic(this.clickBaoXiangIndex + 1);
      }
      
      private function hideClickBadKey() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_G_n_3349.length)
         {
            (this.obf_G_n_3349[_loc1_] as MovieClip).gotoAndStop(1);
            this.obf_G_n_3349[_loc1_].filters = [];
            _loc1_++;
         }
      }
      
      private function hideClickBaoXiang() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_0_6_w_695.length)
         {
            (this.obf_0_6_w_695[_loc1_] as MovieClip).gotoAndStop(1);
            this.obf_0_6_w_695[_loc1_].filters = [];
            _loc1_++;
         }
      }
      
      private function hideComDec(param1:Boolean = false) : void
      {
         cmdCompound.visible = param1;
         cmdDecompose.visible = param1;
      }
      
      private function hideShowSubButt(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_0_5_B_120.length)
         {
            (this.obf_0_5_B_120[_loc2_] as MovieClip).gotoAndStop(1);
            if(param1)
            {
               (this.obf_0_5_B_120[_loc2_] as MovieClip).visible = true;
            }
            else
            {
               (this.obf_0_5_B_120[_loc2_] as MovieClip).visible = false;
            }
            _loc2_++;
         }
      }
      
      private function showOpenBoxPic(param1:int = 1) : void
      {
         openMC.openBoxMC.gotoAndStop(param1);
      }
      
      private function showMakeKeyPic(param1:int = 1) : void
      {
         makeMC.badKeyPic.gotoAndStop(param1);
         makeMC.goodKeyPic.gotoAndStop(param1);
      }
      
      private function showComJingSuiPic(param1:int = 1) : void
      {
         obf_W_C_3703.jingSuiPicMC.gotoAndStop(param1);
      }
      
      public function showOpenEffect() : void
      {
         while(openMC.effectPoint.numChildren > 0)
         {
            openMC.effectPoint.removeChildAt(0);
         }
         obf_0_P_4381.obf_q_h_1296("a00@f33",openMC.effectPoint,null,true,0,0,null);
      }
      
      private function openBaoXiangKey(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.setChildIndex(makeMC,this.numChildren - 1);
         }
         else
         {
            this.setChildIndex(openMC,this.numChildren - 1);
         }
      }
      
      private function obf_0_7_C_236(param1:Event) : void
      {
         this.hideClickBaoXiang();
         this.isClickKeyButt = true;
         this.clickBadKeyIndex = this.obf_G_n_3349.indexOf(param1.currentTarget);
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_G_n_3349.length)
         {
            (this.obf_G_n_3349[_loc2_] as MovieClip).gotoAndStop(_loc2_ == this.clickBadKeyIndex ? 2 : 1);
            if(_loc2_ == this.clickBadKeyIndex)
            {
               this.obf_G_n_3349[_loc2_].filters = [new GlowFilter(65280,1,2,2,1000,1)];
            }
            else
            {
               this.obf_G_n_3349[_loc2_].filters = [];
            }
            _loc2_++;
         }
         this.openBaoXiangKey(this.isClickKeyButt);
         this.showMakeKeyPic(this.clickBadKeyIndex + 1);
      }
      
      private function obf_E_B_2708(param1:Event) : void
      {
         if(this.clickBaoXiangIndex == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_selectOpen"));
            return;
         }
         if(int(this.obf_I_7_2083[this.clickBaoXiangIndex].text) < 1)
         {
            return;
         }
         var _loc2_:String = this.obf_0_6_w_695[this.clickBaoXiangIndex].conf.need;
         var _loc3_:int = obf_u_Z_4014.makeChipKeys.indexOf(_loc2_);
         if(_loc3_ < 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotYaoShi"));
            return;
         }
         if(int(this.obf_B_Z_3459[_loc3_].text) < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotGoodKey"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("MakeChipUI","warn_selectOpened",[1,1]),this.obf_b_t_3470,{"type":1});
      }
      
      private function obf_b_t_3470(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_u_Z_4014.sendOpenBoxReq(param1.par.type,this.obf_0_6_w_695[this.clickBaoXiangIndex].conf.id);
         }
      }
      
      private function onClickCmdOpen10(param1:Event) : void
      {
         if(this.clickBaoXiangIndex == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_selectOpen"));
            return;
         }
         if(int(this.obf_I_7_2083[this.clickBaoXiangIndex].text) < 10)
         {
            return;
         }
         var _loc2_:String = this.obf_0_6_w_695[this.clickBaoXiangIndex].conf.need;
         var _loc3_:int = obf_u_Z_4014.makeChipKeys.indexOf(_loc2_);
         if(_loc3_ < 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotYaoShi"));
            return;
         }
         if(int(this.obf_B_Z_3459[_loc3_].text) < 10)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotGoodKey"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("MakeChipUI","warn_selectOpened",[10,10]),this.obf_b_t_3470,{"type":2});
      }
      
      private function obf_u_k_4016(param1:Event) : void
      {
         if(this.clickBadKeyIndex == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_selectMake"));
            return;
         }
         if(int(this.obf_F_m_3541[this.clickBadKeyIndex].text) < 3)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotBadKey"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("MakeChipUI","warn_selectMaked",[3,1]),this.obf_o_T_1638,{"type":1});
      }
      
      private function onClickCmdMake10(param1:Event) : void
      {
         if(this.clickBadKeyIndex == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_selectMake"));
            return;
         }
         if(int(this.obf_F_m_3541[this.clickBadKeyIndex].text) < 3 * 10)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_NotBadKey"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("MakeChipUI","warn_selectMaked",[30,10]),this.obf_o_T_1638,{"type":2});
      }
      
      private function obf_o_T_1638(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_u_Z_4014.sendMakeKeyReq(param1.par.type,obf_u_Z_4014.makeChipKeys[this.clickBadKeyIndex]);
         }
      }
      
      private function showComInfo() : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         obf_W_C_3703.txtJingNum.text = "";
         obf_W_C_3703.txtName.text = "";
         var _loc1_:int = 1;
         if(!this.iconComSuiPianIconBag.haveIconItem)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc7_:Object = new Object();
         var _loc8_:String = this.iconComSuiPianIconBag.haveIconItem.itemCode;
         var _loc9_:String = "";
         var _loc11_:Array = obf_u_Z_4014.makeChipChips;
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_.length)
         {
            if(_loc8_ == _loc11_[_loc12_].pic)
            {
               _loc9_ = _loc11_[_loc12_].id;
               _loc10_ = int(_loc11_[_loc12_].type);
               break;
            }
            _loc12_++;
         }
         if(obf_L_l_4100.isEmpty(_loc9_))
         {
            return;
         }
         var _loc13_:Array = obf_u_Z_4014.makeChipMakeChipConfig;
         if(_loc10_ == 1)
         {
            _loc14_ = 0;
            while(_loc14_ < _loc13_.length)
            {
               if(_loc13_[_loc14_].type == 1)
               {
                  _loc15_ = _loc13_[_loc14_].levels;
                  if(!_loc15_)
                  {
                     WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_compound_not"));
                     return;
                  }
                  if(!this.chipAttrs[_loc13_[_loc14_].id] || this.chipAttrs[_loc13_[_loc14_].id] == 0)
                  {
                     if(_loc9_ == _loc13_[_loc14_].levels[0].chipId)
                     {
                        _loc2_ = _loc13_[_loc14_].id;
                        _loc3_ = int(_loc13_[_loc14_].levels[0].superNum);
                        _loc4_ = _loc13_[_loc14_].pic;
                        _loc5_ = _loc13_[_loc14_].name;
                        _loc6_ = 0;
                        break;
                     }
                  }
                  else if(this.chipAttrs[_loc13_[_loc14_].id] > 0)
                  {
                     _loc16_ = int(this.chipAttrs[_loc13_[_loc14_].id]);
                     if(Boolean(_loc15_) && _loc9_ == _loc15_[_loc16_].chipId)
                     {
                        if(_loc16_ >= _loc15_.length - 1)
                        {
                           this.iconComSuiPianIconBag.dropIconItem();
                           WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_compound_max"));
                           return;
                        }
                        _loc2_ = _loc13_[_loc14_].id;
                        _loc3_ = int(_loc15_[_loc16_].superNum);
                        _loc4_ = _loc13_[_loc14_].pic;
                        _loc5_ = _loc13_[_loc14_].name;
                        _loc6_ = _loc16_;
                        break;
                     }
                  }
               }
               _loc14_++;
            }
         }
         else
         {
            _loc17_ = 0;
            while(_loc17_ < _loc13_.length)
            {
               if(_loc9_ == _loc13_[_loc17_].chipId)
               {
                  _loc2_ = _loc13_[_loc17_].id;
                  _loc3_ = int(_loc13_[_loc17_].superNum);
                  _loc4_ = _loc13_[_loc17_].itemCode;
                  _loc5_ = _loc13_[_loc17_].name;
               }
               _loc17_++;
            }
         }
         obf_W_C_3703.txtJingNum.text = _loc3_ + "/" + this.obf_G_f_2680[_loc10_ - 1].text;
         this.showComJingSuiPic(_loc10_);
         this.obf_R_n_2303.dropIconItem();
         if(obf_L_l_4100.isEmpty(_loc4_))
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_compound_not_target"));
            this.iconComSuiPianIconBag.dropIconItem();
            return;
         }
         this.obf_b_u_2548 = _loc2_;
         if(_loc10_ == 1)
         {
            this.obf_7_L_882 = _loc6_;
            obf_W_C_3703.txtName.text = _loc5_ + "lv." + _loc6_;
         }
         else
         {
            obf_W_C_3703.txtName.text = _loc5_;
         }
         this.obf_R_n_2303.pushIconItem(IconItemManager.getIconItemByCode(_loc4_,""));
      }
      
      private function obf_0_6_u_650(param1:Event) : void
      {
         var _loc8_:int = 0;
         if(!this.iconComSuiPianIconBag.haveIconItem)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_compound_not_suiPian"));
            return;
         }
         var _loc2_:String = obf_W_C_3703.txtJingNum.text;
         var _loc3_:Array = _loc2_.split("/");
         var _loc4_:int = int(_loc3_[0]);
         var _loc5_:int = int(_loc3_[1]);
         if(_loc4_ > _loc5_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_compound_not_jingSui"));
            return;
         }
         var _loc6_:String = this.iconComSuiPianIconBag.haveIconItem.itemCode;
         var _loc7_:String = "";
         var _loc9_:Array = obf_u_Z_4014.makeChipChips;
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_.length)
         {
            if(_loc6_ == _loc9_[_loc10_].pic)
            {
               _loc7_ = _loc9_[_loc10_].id;
               _loc8_ = int(_loc9_[_loc10_].type);
               break;
            }
            _loc10_++;
         }
         if(obf_L_l_4100.isEmpty(_loc7_) || obf_L_l_4100.isEmpty(this.obf_b_u_2548))
         {
            return;
         }
         obf_u_Z_4014.sendMakeChipReq(this.obf_b_u_2548);
      }
      
      private function obf_0_3_3_445(param1:Event) : void
      {
      }
      
      private function obf_4_y_1789(param1:Event) : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:Boolean = false;
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc2_:Object = {};
         for each(_loc3_ in this.obf_0_6_x_528)
         {
            if(Boolean(_loc3_.haveIconItem) && Boolean(_loc3_.haveIconItem.itemCode))
            {
               _loc6_ = obf_u_Z_4014.makeChipChips;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  if(_loc6_[_loc7_].pic == _loc3_.haveIconItem.itemCode)
                  {
                     _loc2_[_loc6_[_loc7_].id] = _loc3_.haveIconItem.itemCount;
                     break;
                  }
                  _loc7_++;
               }
            }
         }
         _loc4_ = false;
         for(_loc5_ in _loc2_)
         {
            _loc4_ = true;
         }
         if(!_loc4_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("MakeChipUI","warn_decompose_not"));
            return;
         }
         if(_loc2_)
         {
            obf_u_Z_4014.sendBreakChipReq(_loc2_);
         }
      }
      
      private function obf_W_J_3527(param1:Event) : void
      {
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         if(obf_L_l_4100.isEmpty(this.obf_b_u_2548))
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc3_:Array = obf_u_Z_4014.makeChipMakeChipConfig;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(this.obf_b_u_2548 == _loc3_[_loc4_].id)
            {
               _loc2_ = int(_loc3_[_loc4_].type);
               break;
            }
            _loc4_++;
         }
         if(_loc2_ != 1)
         {
            return;
         }
         var _loc5_:GameTipUI = new GameTipUI("MakeChipUI_AttrTips");
         var _loc6_:int = 200;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.length)
         {
            if(this.obf_b_u_2548 == _loc3_[_loc7_].id)
            {
               if(this.obf_7_L_882 > 0)
               {
                  _loc5_.addTipInfo("<P align=\'center\'><FONT color=\'#00FF00\'>" + _loc3_[_loc7_].name + "Lv." + this.obf_7_L_882 + "</FONT></P>",_loc6_,_loc5_.maxRow);
                  _loc5_.addTipInfo("<P align=\'center\'><FONT color=\'#FFFFFF\'>" + DiversityManager.getString("MakeChipUI","currentAttr") + "</FONT></P>",_loc6_,_loc5_.maxRow + 1);
                  _loc8_ = _loc3_[_loc7_].levels[this.obf_7_L_882].attr;
                  if(_loc8_)
                  {
                     for(_loc10_ in _loc8_)
                     {
                        _loc5_.addTipInfo("<FONT color=\'#FFFFFF\'>" + RoleAttributesModifierEnum.getAttributesName(_loc10_) + "</FONT>",_loc6_,_loc5_.maxRow + 1);
                        _loc5_.addTipInfo("<P align=\'right\'><FONT color=\'#FFFFFF\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc10_,_loc8_[_loc10_]) + "</FONT></P>",_loc6_,_loc5_.maxRow);
                     }
                  }
                  if(this.obf_7_L_882 + 1 >= _loc3_[_loc7_].levels.length)
                  {
                     return;
                  }
                  _loc5_.addTipInfo("<P align=\'center\'><FONT color=\'#FF0000\'>" + DiversityManager.getString("MakeChipUI","nextAttr") + "</FONT></P>",_loc6_,_loc5_.maxRow + 1);
                  _loc9_ = _loc3_[_loc7_].levels[this.obf_7_L_882 + 1].attr;
                  if(_loc9_)
                  {
                     for(_loc11_ in _loc9_)
                     {
                        _loc5_.addTipInfo("<FONT color=\'#FF0000\'>" + RoleAttributesModifierEnum.getAttributesName(_loc11_) + "</FONT>",_loc6_,_loc5_.maxRow + 1);
                        _loc5_.addTipInfo("<P align=\'right\'><FONT color=\'#FF0000\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc11_,_loc9_[_loc11_]) + "</FONT></P>",_loc6_,_loc5_.maxRow);
                     }
                  }
               }
               else
               {
                  _loc5_.addTipInfo("<P align=\'center\'><FONT color=\'#00FF00\'>" + _loc3_[_loc7_].name + "</FONT></P>",_loc6_,_loc5_.maxRow);
               }
            }
            _loc7_++;
         }
         GameTipManager.showTip(_loc5_);
      }
      
      private function obf_4_2_4213(param1:Event) : void
      {
         GameTipManager.closeTip("MakeChipUI_AttrTips");
      }
      
      private function obf_P_p_3048() : void
      {
         this.iconComSuiPianIconBag.dropIconItem();
         this.obf_R_n_2303.dropIconItem();
         obf_W_C_3703.txtJingNum.text = "";
         obf_W_C_3703.txtName.text = "";
      }
      
      private function obf_b_n_1143() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.allBags)
         {
            _loc1_.dropIconItem();
         }
      }
      
      private function obf_J_s_3643(param1:String) : Boolean
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_0_6_x_528)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function obf_M_2_2679(param1:Object) : void
      {
         var _loc4_:String = null;
         this.chipBoxs = param1;
         var _loc2_:Array = obf_u_Z_4014.makeChipBox;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            for(_loc4_ in param1)
            {
               if(_loc4_ == _loc2_[_loc3_].id)
               {
                  this.obf_I_7_2083[_loc3_].text = param1[_loc4_] + "";
               }
            }
            _loc3_++;
         }
      }
      
      public function obf_2_i_2654(param1:Object) : void
      {
         var _loc4_:String = null;
         this.chipBadKeys = param1;
         var _loc2_:Array = obf_u_Z_4014.makeChipBadKeys;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            for(_loc4_ in param1)
            {
               if(_loc4_ == _loc2_[_loc3_])
               {
                  this.obf_F_m_3541[_loc3_].text = param1[_loc4_] + "";
               }
            }
            _loc3_++;
         }
      }
      
      public function obf_0_E_2196(param1:Object) : void
      {
         var _loc4_:String = null;
         this.chipKeys = param1;
         var _loc2_:Array = obf_u_Z_4014.makeChipKeys;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            for(_loc4_ in param1)
            {
               if(_loc4_ == _loc2_[_loc3_])
               {
                  this.obf_B_Z_3459[_loc3_].text = param1[_loc4_] + "";
               }
            }
            _loc3_++;
         }
      }
      
      public function chipsInfo(param1:Object) : void
      {
         this.chips = param1;
      }
      
      public function obf_x_8_3005(param1:Object) : void
      {
         var _loc4_:String = null;
         this.chipSupers = param1;
         var _loc2_:Array = obf_u_Z_4014.makeChipSupers;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            for(_loc4_ in param1)
            {
               if(_loc4_ == _loc2_[_loc3_])
               {
                  this.obf_G_f_2680[_loc3_].text = param1[_loc4_] + "";
               }
            }
            _loc3_++;
         }
      }
      
      private function obf_S_n_891() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:IconItemBag = null;
         var _loc10_:IconItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = obf_u_Z_4014.makeChipMakeChipConfig;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].type == 1)
            {
               _loc5_ = _loc2_[_loc3_].id;
               _loc6_ = _loc2_[_loc3_].pic;
               _loc7_ = "";
               if(this.chipAttrs[_loc5_])
               {
                  _loc8_ = int(this.chipAttrs[_loc5_]);
               }
               else
               {
                  _loc8_ = 0;
               }
               if(_loc8_ == 0)
               {
                  _loc7_ = "";
               }
               else
               {
                  _loc7_ = _loc2_[_loc3_].levels[_loc8_ - 1].chipId;
               }
               _loc1_.push({
                  "comId":_loc5_,
                  "code":_loc6_,
                  "value":_loc8_,
                  "suiPianId":_loc7_
               });
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc9_ = this.powerArr[_loc4_];
            _loc9_.dropIconItem();
            _loc10_ = IconItemManager.getIconItemByCode(_loc1_[_loc4_].code,"");
            if(_loc10_)
            {
               _loc10_.par = _loc1_[_loc4_];
               _loc10_.addEventListener(MouseEvent.CLICK,this.obf_N_c_4315);
               _loc9_.pushIconItem(_loc10_);
               if(_loc1_[_loc4_].value > 0)
               {
                  _loc10_.filters = [];
               }
               else
               {
                  _loc10_.filters = [obf_9_V_1635.getGrayFilter()];
               }
            }
            _loc4_++;
         }
      }
      
      public function obf_E_i_2949(param1:Object) : void
      {
         this.chipAttrs = param1;
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
         DiversityManager.setTextField(txtDeyTitle,"MakeChipUI","txtDeyTitle");
         DiversityManager.setTextField(boxKeyButtonMC.txtBox,"MakeChipUI","boxKeyButtonMC_txtBox");
         DiversityManager.setTextField(boxKeyButtonMC.txtYaoshi,"MakeChipUI","boxKeyButtonMC_txtYaoshi");
         DiversityManager.setTextField(txtJing,"MakeChipUI","txtJing");
         DiversityManager.setTextField(txtKey,"MakeChipUI","txtKey");
         DiversityManager.setTextField(powerMC.powerMCCurrent,"MakeChipUI","powerMC_powerMCCurrent");
         DiversityManager.setTextField(powerMC.powerMCNext,"MakeChipUI","powerMC_powerMCNext");
         makeMC.cmdMake1.label = DiversityManager.getString("MakeChipUI","makeMC_cmdMake1");
         makeMC.cmdMake10.label = DiversityManager.getString("MakeChipUI","makeMC_cmdMake10");
         openMC.cmdOpen1.label = DiversityManager.getString("MakeChipUI","openMC_cmdOpen1");
         openMC.cmdOpen10.label = DiversityManager.getString("MakeChipUI","openMC_cmdOpen10");
         DiversityManager.setTextField(decomposeMC.txtDecompose,"MakeChipUI","txtDecompose");
         DiversityManager.setTextField(obf_W_C_3703.txtSui,"MakeChipUI","txtSui");
         DiversityManager.setTextField(obf_W_C_3703.txtJing,"MakeChipUI","compoundMC_txtJing");
         DiversityManager.setTextField(obf_W_C_3703.txtCompound,"MakeChipUI","compoundMC_txtCompound");
         obf_W_C_3703.cmdRefine.label = DiversityManager.getString("MakeChipUI","compoundMC_cmdRefine");
         DiversityManager.setTextField(powerMC.powerMCTxtSee,"MakeChipUI","powerMC_powerMCTxtSee");
         cmdMaterial.label = DiversityManager.getString("MakeChipUI","cmdMaterial");
         cmdOwn.label = DiversityManager.getString("MakeChipUI","cmdOwn");
         cmdPower.label = DiversityManager.getString("MakeChipUI","cmdPower");
         cmdCompound.label = DiversityManager.getString("MakeChipUI","cmdCompound");
         decomposeMC.cmdDec.label = cmdDecompose.label = DiversityManager.getString("MakeChipUI","cmdDecompose");
         DiversityManager.setTextField(cmdTable1.txtLabel,"MakeChipUI","cmdTable1",null,true);
         DiversityManager.setTextField(cmdTable2.txtLabel,"MakeChipUI","cmdTable2",null,true);
         DiversityManager.setTextField(cmdTable3.txtLabel,"MakeChipUI","cmdTable3",null,true);
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
      
      public function getIconItemBags() : Array
      {
         return this.allBags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IconItemBag = null;
         if(!param1)
         {
            return;
         }
         if(param1 == this.iconComSuiPianIconBag && Boolean(param2))
         {
            this.iconComSuiPianIconBag.dropIconItem();
            this.obf_R_n_2303.dropIconItem();
            param2.itemCount = 1;
            this.iconComSuiPianIconBag.pushIconItem(param2);
            this.showComInfo();
         }
         if(param1.parent.name == "decomposeMC")
         {
            _loc4_ = 0;
            while(_loc4_ < this.obf_0_6_x_528.length)
            {
               _loc5_ = this.obf_0_6_x_528[_loc4_];
               if(!(Boolean(_loc5_.haveIconItem) || this.obf_J_s_3643(param2.itemCode)))
               {
                  _loc5_.pushIconItem(param2);
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

