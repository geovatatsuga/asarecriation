package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.rideEquip.RideEquipSoulType;
   import com.sunweb.game.rpg.rideEquip.obf_Y_7_1544;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.RideEquRecreateUIMC;
   
   public class obf_5_t_2132 extends RideEquRecreateUIMC implements IPlayerUI
   {
      
      private var obf_0_3_k_543:int;
      
      private var obf_L_v_4211:GameItemFullInfo;
      
      private var tempArr:Dictionary;
      
      public var isSave:Boolean;
      
      public var isShowSoulTip:Boolean = true;
      
      public var isShowAttTip:Boolean = true;
      
      private var infoTimeInv:TimeLimiter = new TimeLimiter(300);
      
      public function obf_5_t_2132()
      {
         super();
         this.visible = false;
         cmdOK.mouseEnabled = false;
         cmdOK.enabled = false;
         this.tempArr = new Dictionary();
         this.tempArr[1] = [];
         this.tempArr[2] = [];
         this.tempArr[3] = [];
         this.tempArr[4] = [];
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         soulRecreate.addEventListener(MouseEvent.CLICK,this.obf_x_s_1262);
         attributeRecreate.addEventListener(MouseEvent.CLICK,this.obf_L_y_1405);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onOk);
      }
      
      private function removeListener() : void
      {
         soulRecreate.removeEventListener(MouseEvent.CLICK,this.obf_x_s_1262);
         attributeRecreate.removeEventListener(MouseEvent.CLICK,this.obf_L_y_1405);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onOk);
      }
      
      private function onShowSoul() : int
      {
         return JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["soulMoney"]);
      }
      
      private function obf_E_m_4207() : int
      {
         return JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["attMoney"]);
      }
      
      private function obf_x_s_1262(param1:Event) : void
      {
         if(this.isShowSoulTip)
         {
            WindowManager.showDragonWin(DiversityManager.getString("RideBoxUI","moneyPay",[this.onShowSoul()]),this.sureToSoul,6);
         }
         else
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["soulMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
               return;
            }
            obf_Y_7_1544.sendEquipCommand(obf_K_e_3075.rideBoxUI.selectedRideId,false,this.obf_0_3_k_543,4);
         }
      }
      
      private function sureToSoul(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["soulMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
               return;
            }
            obf_Y_7_1544.sendEquipCommand(obf_K_e_3075.rideBoxUI.selectedRideId,false,this.obf_0_3_k_543,4);
         }
      }
      
      private function obf_L_y_1405(param1:Event) : void
      {
         if(this.isShowAttTip)
         {
            WindowManager.showDragonWin(DiversityManager.getString("RideBoxUI","moneyPay",[this.obf_E_m_4207()]),this.sureToRecreate,7);
         }
         else
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["attMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
               return;
            }
            obf_Y_7_1544.sendEquipCommand(obf_K_e_3075.rideBoxUI.selectedRideId,false,this.obf_0_3_k_543,5);
         }
      }
      
      private function sureToRecreate(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRecreateCon(),["attMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
               return;
            }
            obf_Y_7_1544.sendEquipCommand(obf_K_e_3075.rideBoxUI.selectedRideId,false,this.obf_0_3_k_543,5);
         }
      }
      
      private function onOk(param1:Event) : void
      {
         if(txtSouling1.text == null || txtSouling1.text == "")
         {
            WindowManager.showMessageBox(DiversityManager.getString("RideBoxUI","MLGB"));
         }
         else
         {
            WindowManager.showConfirmBox(DiversityManager.getString("RideBoxUI","areYouSure"),this.isSure);
         }
      }
      
      private function isSure(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Y_7_1544.sendSaveInfo(obf_K_e_3075.rideBoxUI.selectedRideId,this.obf_0_3_k_543,2);
            obf_K_e_3075.rideEquipRefineUI.obf_x_X_2953();
            obf_K_e_3075.rideEquipRefineUI.tempAttrFinal[this.obf_0_3_k_543] = [];
         }
      }
      
      public function recreateOverShow(param1:Array, param2:Array, param3:Array) : void
      {
         this.isSave = true;
         this.tempArr[this.obf_0_3_k_543][0] = param1;
         this.tempArr[this.obf_0_3_k_543][1] = param2;
         this.tempArr[this.obf_0_3_k_543][2] = param3;
         var _loc4_:int = 1;
         while(_loc4_ < 4)
         {
            this["txtSouling" + _loc4_].text = "(" + RideEquipSoulType.getSoulName(param1[_loc4_ - 1]) + ")";
            this["txtAtcing" + _loc4_].text = RoleAttributesModifierEnum.getAttributesName(param2[_loc4_ - 1]);
            this["txtAtted" + _loc4_].text = param3[_loc4_ - 1] + "";
            _loc4_++;
         }
         cmdOK.mouseEnabled = true;
         cmdOK.enabled = true;
      }
      
      public function recreateOkShow() : void
      {
         this.isSave = false;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         var _loc1_:int = 1;
         while(_loc1_ < 4)
         {
            this["txtSoul" + _loc1_].text = this["txtSouling" + _loc1_].text;
            this["txtAtc" + _loc1_].text = this["txtAtcing" + _loc1_].text;
            this["txtAtt" + _loc1_].text = this["txtAtted" + _loc1_].text;
            _loc1_++;
         }
         this.obf_A_I_3833();
         this.tempArr[this.obf_0_3_k_543] = [];
         cmdOK.mouseEnabled = false;
         cmdOK.enabled = false;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.infoTimeInv.checkTimeout() && !this.obf_L_v_4211)
         {
            this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
            if(Boolean(this.obf_L_v_4211) && Boolean(this.obf_0_3_k_543))
            {
               this.showInfo(this.obf_0_3_k_543);
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
            }
         }
      }
      
      public function showInfo(param1:int) : void
      {
         this.obf_0_3_k_543 = param1;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
         if(!this.obf_L_v_4211 || !this.obf_L_v_4211.rideInfo)
         {
            return;
         }
         var _loc2_:Object = this.obf_L_v_4211.rideInfo.equipmenet;
         this.showView(_loc2_,param1);
      }
      
      private function showView(param1:Object, param2:int) : void
      {
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         this.clear();
         this.obf_A_I_3833();
         var _loc3_:Array = param1[param2].attrSoul;
         var _loc4_:Array = param1[param2].attr;
         var _loc5_:Array = param1[param2].attrFinal;
         var _loc6_:int = 1;
         while(_loc6_ < 4)
         {
            this["txtSoul" + _loc6_].text = "(" + RideEquipSoulType.getSoulName(_loc3_[_loc6_ - 1]) + ")";
            this["txtAtc" + _loc6_].text = RoleAttributesModifierEnum.getAttributesName(_loc4_[_loc6_ - 1]);
            this["txtAtt" + _loc6_].text = _loc5_[_loc6_ - 1] + "";
            _loc6_++;
         }
         if(this.tempArr.length > 0)
         {
            _loc7_ = this.tempArr[param2][0];
            _loc8_ = this.tempArr[param2][1];
            _loc9_ = this.tempArr[param2][2];
            _loc10_ = 1;
            while(_loc10_ < 4)
            {
               if(_loc7_.length > 0)
               {
                  this["txtSouling" + _loc10_].text = "(" + RideEquipSoulType.getSoulName(_loc7_[_loc10_ - 1]) + ")";
               }
               if(_loc8_.length > 0)
               {
                  this["txtAtcing" + _loc10_].text = RoleAttributesModifierEnum.getAttributesName(_loc8_[_loc10_ - 1]);
               }
               if(_loc9_.length > 0)
               {
                  this["txtAtted" + _loc10_].text = _loc9_[_loc10_ - 1];
               }
               _loc10_++;
            }
         }
      }
      
      private function clear() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 4)
         {
            this["txtSoul" + _loc1_].text = "";
            this["txtAtc" + _loc1_].text = "";
            this["txtAtt" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      public function obf_A_I_3833() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 4)
         {
            this["txtSouling" + _loc1_].text = "";
            this["txtAtcing" + _loc1_].text = "";
            this["txtAtted" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      public function initDection() : void
      {
         cmdOK.mouseEnabled = false;
         cmdOK.enabled = false;
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            this.tempArr[_loc1_] = [];
            _loc1_++;
         }
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
         cmdOK.label = DiversityManager.getString("RideBoxUI","save");
         soulRecreate.label = DiversityManager.getString("RideBoxUI","soulRecreate");
         attributeRecreate.label = DiversityManager.getString("RideBoxUI","attributeRecreate");
         DiversityManager.setTextField(txtEx,"RideBoxUI","ex");
      }
      
      public function showUI() : void
      {
         this.obf_0_3_k_543 = 1;
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.showInfo(1);
      }
      
      public function closeUI() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
         this.isShowSoulTip = true;
         this.isShowAttTip = true;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

