package com.sunweb.game.rpg.playerUI.manual
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.manual.obf_V_C_3520;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.ManualUIMC;
   
   public class ManualUI extends ManualUIMC implements IIconItemUI
   {
      
      private var iconBag0:IconItemBag;
      
      private var iconBag1:IconItemBag;
      
      private var obf_D_G_2655:obf_9_c_4534;
      
      private var manualMap:Object;
      
      private var obf_6_h_4262:obf_q_I_2479;
      
      private var petImageActiveTimeInv:TimeLimiter = new TimeLimiter(2000);
      
      public function ManualUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.iconBag0 = new IconItemBag(iconBar0,this,0);
         this.iconBag0.addValidType(GameItemType.ALL);
         this.iconBag0.lockDrag = true;
         this.iconBag1 = new IconItemBag(iconBar1,this,0);
         this.iconBag1.addValidType(GameItemType.ALL);
         this.iconBag1.lockDrag = true;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtIntro.setTextFormat(_loc1_);
         this.manualMap = new Object();
         this.initManual();
         manualEffectMC.visible = false;
         this.obf_k_6_978();
         noSeal.visible = false;
         noSeal.alpha = 0.7;
      }
      
      private function obf_k_6_978() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdAbsorb.addEventListener(MouseEvent.CLICK,this.obf_0_1_Z_646);
         cmdCoerceAbsorb.addEventListener(MouseEvent.CLICK,this.obf_P_A_1094);
         cmdCoerceAbsorb.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_0_2657);
         cmdCoerceAbsorb.addEventListener(MouseEvent.MOUSE_OUT,this.obf_w_T_3782);
         obf_K_e_3075.addUIMouseToolTip(txtIntro,"txtIntro");
      }
      
      private function removerListen() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdAbsorb.removeEventListener(MouseEvent.CLICK,this.obf_0_1_Z_646);
         cmdCoerceAbsorb.removeEventListener(MouseEvent.CLICK,this.obf_P_A_1094);
         cmdCoerceAbsorb.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_0_2657);
         cmdCoerceAbsorb.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_w_T_3782);
         obf_K_e_3075.removeUIMouseToolTip(txtIntro);
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function initManual() : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_q_I_2479 = null;
         while(obf_v_b_1158.numChildren > 0)
         {
            obf_v_b_1158.removeChildAt(0);
         }
         var _loc1_:int = 0;
         for each(_loc2_ in obf_V_C_3520.getManual)
         {
            if(_loc2_)
            {
               _loc3_ = new obf_q_I_2479(_loc2_.iconCode);
               if(_loc3_)
               {
                  _loc3_._code = _loc2_.code;
                  _loc3_.obf_4_3_816 = _loc2_.absorbByMoney;
                  _loc3_.obf_s_w_989 = _loc2_.moudleCode;
                  _loc3_._name = _loc2_.name;
                  _loc3_._rank = _loc2_.rank;
                  _loc3_.obf_w_B_3992 = _loc2_.tolltip;
                  _loc3_._absorbItems = _loc2_.absorbItems;
                  _loc3_.obf_0_c_2225 = _loc2_.allowTimes;
                  _loc3_._absorbTimes = 0;
                  _loc3_._baseAttr = _loc2_.baseAttr;
                  this.manualMap[_loc2_.code] = _loc3_;
                  _loc3_.addEventListener(obf_q_I_2479.obf_U_A_3305,this.obf_R_5_1834);
                  _loc3_.rankMask = GameItemRank.getRankIcon(_loc2_.rank);
                  obf_v_b_1158.addChild(_loc3_);
                  _loc3_.x = _loc1_ % 5 * (_loc3_.width + 10);
                  _loc3_.y = int(_loc1_ / 5) * (_loc3_.height + 20);
                  _loc1_++;
               }
            }
         }
      }
      
      private function obf_Z_0_2657(param1:MouseEvent) : void
      {
         if(!this.obf_6_h_4262)
         {
            return;
         }
         var _loc2_:GameTipUI = new GameTipUI("coerceAbsorb");
         _loc2_.addTipInfo(DiversityManager.getString("ManualUI","coerceAbsorb",[this.obf_6_h_4262.obf_4_3_816]),180,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_w_T_3782(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("coerceAbsorb");
      }
      
      private function obf_R_5_1834(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:IconItem = null;
         var _loc2_:obf_q_I_2479 = param1.target as obf_q_I_2479;
         if(!_loc2_)
         {
            return;
         }
         this.obf_E_j_2700();
         this.obf_6_h_4262 = _loc2_;
         txtName.text = _loc2_._name;
         txtName.textColor = GameItemRank.getRankColor(_loc2_._rank);
         txtLv.text = GameItemRank.getRankName(_loc2_._rank,true);
         DiversityManager.setTextField(txtRemainTimes,"ManualUI","txtRemainTimes",[_loc2_.obf_0_c_2225 - _loc2_._absorbTimes]);
         DiversityManager.setTextField(txtAllTimes,"ManualUI","txtAllTimes",[obf_V_C_3520.getHaveAllTimes(_loc2_._code)]);
         this.obf_D_G_2655 = new obf_9_c_4534(_loc2_.obf_s_w_989);
         if(this.obf_D_G_2655)
         {
            this.obf_D_G_2655.x = 0;
            pointImage.addChild(this.obf_D_G_2655);
         }
         var _loc3_:int = 0;
         for(_loc4_ in _loc2_._absorbItems)
         {
            if(_loc3_ <= 1)
            {
               _loc10_ = IconItemManager.getIconItemByCode(_loc4_,"");
               if(_loc10_)
               {
                  _loc10_.itemCount = _loc2_._absorbItems[_loc4_];
                  this["iconBag" + _loc3_].pushIconItem(_loc10_);
                  _loc3_++;
               }
            }
         }
         _loc5_ = "";
         _loc6_ = "";
         _loc7_ = new Array();
         for(_loc8_ in _loc2_._baseAttr)
         {
            _loc7_.push({
               "at":int(_loc8_),
               "va":_loc2_._baseAttr[_loc8_]
            });
         }
         _loc7_.sortOn("at",Array.NUMERIC);
         for each(_loc9_ in _loc7_)
         {
            _loc5_ += RoleAttributesModifierEnum.getAttributesName(_loc9_["at"]) + ":" + _loc9_["va"] + "\r";
            _loc6_ += RoleAttributesModifierEnum.getAttributesName(_loc9_["at"]) + ":" + _loc9_["va"] * _loc2_._absorbTimes + "\r";
         }
         txtAttr.text = _loc5_;
         txtAllAttr.text = _loc6_;
         if(_loc2_.isRavel)
         {
            cmdAbsorb.enabled = true;
            cmdCoerceAbsorb.enabled = true;
            noSeal.visible = false;
            if(this.obf_D_G_2655)
            {
               this.obf_D_G_2655.filters = [];
            }
         }
         else
         {
            cmdAbsorb.enabled = false;
            cmdCoerceAbsorb.enabled = false;
            noSeal.visible = true;
            if(this.obf_D_G_2655)
            {
               this.obf_D_G_2655.filters = [obf_9_V_1635.getGrayFilter()];
            }
         }
         manualEffectMC.visible = true;
         manualEffectMC.gotoAndPlay(1);
         manualEffectMC.x = obf_v_b_1158.x + _loc2_.x;
         manualEffectMC.y = obf_v_b_1158.y + _loc2_.y;
      }
      
      private function obf_E_j_2700() : void
      {
         this.obf_0_4_O_703();
         txtName.text = "";
         txtLv.text = "";
         txtAttr.text = txtAllAttr.text = "";
         DiversityManager.setTextField(txtRemainTimes,"ManualUI","txtRemainTimes",[0]);
         DiversityManager.setTextField(txtAllTimes,"ManualUI","txtAllTimes",[0]);
         this.iconBag0.dropIconItem();
         this.iconBag1.dropIconItem();
         this.obf_6_h_4262 = null;
         cmdAbsorb.enabled = false;
         cmdCoerceAbsorb.enabled = false;
         manualEffectMC.visible = false;
         noSeal.visible = false;
      }
      
      public function spareTimes(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(!obf_L_l_4100.isEmpty(param1))
         {
            for each(_loc4_ in obf_V_C_3520.getManual)
            {
               if(_loc4_.code == param1)
               {
                  _loc3_ = _loc4_.name + "";
                  _loc2_ = int(_loc4_.allowTimes);
                  if(this.manualMap[param1].isRavel)
                  {
                     _loc2_ = _loc4_.allowTimes - this.manualMap[param1]._absorbTimes;
                  }
               }
            }
         }
         return _loc3_ + ":" + _loc2_ + "";
      }
      
      public function obf_A_W_3451(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:obf_q_I_2479 = null;
         if(!param1)
         {
            return;
         }
         this.obf_E_j_2700();
         for(_loc2_ in param1)
         {
            _loc3_ = this.manualMap[_loc2_] as obf_q_I_2479;
            if(_loc3_)
            {
               _loc3_._absorbTimes = param1[_loc2_];
               _loc3_.isRavel = true;
               _loc3_.setGray(_loc3_.isRavel);
            }
         }
      }
      
      public function obf_S_D_3371(param1:String, param2:int) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc3_:obf_q_I_2479 = this.manualMap[param1] as obf_q_I_2479;
         if(_loc3_)
         {
            _loc3_._absorbTimes = param2;
         }
         if(!this.obf_6_h_4262 || param1 != this.obf_6_h_4262._code)
         {
            return;
         }
         DiversityManager.setTextField(txtRemainTimes,"ManualUI","txtRemainTimes",[this.obf_6_h_4262.obf_0_c_2225 - param2]);
         DiversityManager.setTextField(txtAllTimes,"ManualUI","txtAllTimes",[obf_V_C_3520.getHaveAllTimes(this.obf_6_h_4262._code)]);
         var _loc4_:String = "";
         var _loc5_:Array = new Array();
         for(_loc6_ in this.obf_6_h_4262._baseAttr)
         {
            _loc5_.push({
               "at":int(_loc6_),
               "va":this.obf_6_h_4262._baseAttr[_loc6_]
            });
         }
         _loc5_.sortOn("at",Array.NUMERIC);
         for each(_loc7_ in _loc5_)
         {
            _loc4_ += RoleAttributesModifierEnum.getAttributesName(_loc7_["at"]) + ":" + _loc7_["va"] * this.obf_6_h_4262._absorbTimes + "\r";
         }
         txtAllAttr.text = _loc4_;
      }
      
      private function obf_0_4_O_703() : void
      {
         while(pointImage.numChildren > 0)
         {
            pointImage.removeChildAt(0);
         }
         if(this.obf_D_G_2655)
         {
            this.obf_D_G_2655.destroy();
         }
         this.obf_D_G_2655 = null;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_D_G_2655) && this.petImageActiveTimeInv.checkTimeout())
         {
            this.obf_D_G_2655.onUpdate();
            this.obf_D_G_2655.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
      }
      
      private function obf_0_1_Z_646(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!this.obf_6_h_4262)
         {
            return;
         }
         if(obf_V_C_3520.getHaveAllTimes(this.obf_6_h_4262._code) <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","dayManual"));
            return;
         }
         if(!this.obf_6_h_4262.isRavel)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","canNotManual"));
            return;
         }
         if(this.obf_6_h_4262.obf_0_c_2225 <= this.obf_6_h_4262._absorbTimes)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","maxManual"));
            return;
         }
         if(!this.obf_6_h_4262._absorbItems)
         {
            return;
         }
         for(_loc2_ in this.obf_6_h_4262._absorbItems)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < this.obf_6_h_4262._absorbItems[_loc2_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","noItemCount"));
               return;
            }
         }
         obf_V_C_3520.sendManualAbsorb(this.obf_6_h_4262._code);
      }
      
      private function obf_P_A_1094(param1:MouseEvent) : void
      {
         if(!this.obf_6_h_4262)
         {
            return;
         }
         if(!this.obf_6_h_4262.isRavel)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","canNotManual"));
            return;
         }
         if(this.obf_6_h_4262.obf_0_c_2225 <= this.obf_6_h_4262._absorbTimes)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ManualUI","maxManual"));
            return;
         }
         if(this.obf_6_h_4262.obf_4_3_816 < 1)
         {
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("ManualUI","areYouSure",[this.obf_6_h_4262.obf_4_3_816]),this.obf_o_T_1638);
      }
      
      private function obf_o_T_1638(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < this.obf_6_h_4262.obf_4_3_816)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreMoney"));
               return;
            }
            obf_V_C_3520.sendManualAbsorb(this.obf_6_h_4262._code,true);
         }
      }
      
      public function getIconItemBags() : Array
      {
         return [this.iconBag0,this.iconBag1];
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
         DiversityManager.setTextField(txtDeyTitle,"ManualUI","txtDeyTitle");
         txtIntro.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("ManualUI","txtIntro") + "</a>";
         DiversityManager.setTextField(txtdeyLv,"ManualUI","txtdeyLv");
         DiversityManager.setTextField(txtDeyAttr,"ManualUI","txtDeyAttr");
         DiversityManager.setTextField(txtDeyAllAttr,"ManualUI","txtDeyAllAttr");
         DiversityManager.setTextField(txtRemainTimes,"ManualUI","txtRemainTimes",[0]);
         cmdAbsorb.label = DiversityManager.getString("ManualUI","cmdAbsorb");
         cmdCoerceAbsorb.label = DiversityManager.getString("ManualUI","cmdCoerceAbsorb");
         DiversityManager.setTextField(txtAllTimes,"ManualUI","txtAllTimes",[0]);
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_V_C_3520.sendShowUI();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removerListen();
      }
   }
}

