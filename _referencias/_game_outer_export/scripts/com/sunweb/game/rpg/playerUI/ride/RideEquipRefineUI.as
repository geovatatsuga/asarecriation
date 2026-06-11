package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
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
   import playerUI.RideEquRefineUIMC;
   
   public class RideEquipRefineUI extends RideEquRefineUIMC implements IPlayerUI
   {
      
      private var obf_K_h_3590:int;
      
      private var obf_4_T_3047:String;
      
      private var obf_0_7_p_465:Array;
      
      private var obf_L_v_4211:GameItemFullInfo;
      
      private var isMoney:Boolean = false;
      
      public var tempAttrFinal:Dictionary;
      
      private var isLimitTemp:Dictionary;
      
      public var isShowRefineTip:Boolean = true;
      
      public var isSave:Boolean;
      
      private var infoTimeInv:TimeLimiter = new TimeLimiter(300);
      
      public function RideEquipRefineUI()
      {
         super();
         this.visible = false;
         cmdOk.mouseEnabled = false;
         cmdOk.enabled = false;
         changeAttribute.visible = false;
         cmdAttribute.visible = false;
         equipImg.visible = false;
         this.tempAttrFinal = new Dictionary();
         this.isLimitTemp = new Dictionary();
         this.isLimitTemp[1] = [];
         this.isLimitTemp[2] = [];
         this.isLimitTemp[3] = [];
         this.isLimitTemp[4] = [];
         this.tempAttrFinal[1] = [];
         this.tempAttrFinal[2] = [];
         this.tempAttrFinal[3] = [];
         this.tempAttrFinal[4] = [];
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         refine.addEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         changeAttribute.addEventListener(MouseEvent.CLICK,this.onChangeSoul);
         cmdOk.addEventListener(MouseEvent.CLICK,this.onOk);
         choiceOrNot.addEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
      }
      
      private function removeListener() : void
      {
         refine.removeEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         changeAttribute.removeEventListener(MouseEvent.CLICK,this.onChangeSoul);
         cmdOk.removeEventListener(MouseEvent.CLICK,this.onOk);
         choiceOrNot.removeEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
      }
      
      private function onOk(param1:Event) : void
      {
         if(txtRefining1.text == null || txtRefining1.text == "")
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
            obf_Y_7_1544.sendSaveInfo(this.obf_4_T_3047,this.obf_K_h_3590,1);
            obf_K_e_3075.rideEquipRecreateUI.obf_A_I_3833();
         }
      }
      
      private function onChangeSoul(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRefineCon(),["soulMoney"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
            return;
         }
         obf_Y_7_1544.sendEquipCommand(this.obf_4_T_3047,false,this.obf_K_h_3590,3);
      }
      
      private function obf_P_G_3138(param1:Event) : void
      {
         this.isMoney = param1.currentTarget.selected;
      }
      
      private function obf_S_v_1347(param1:Event) : void
      {
         if(!this.obf_L_v_4211)
         {
            return;
         }
         var _loc2_:Object = this.obf_L_v_4211.rideInfo.equipmenet;
         var _loc3_:int = int((JSONUtil.getValue(obf_Y_7_1544.getRideEquiStrengthCon(),["levelConfig"]) as Array).length);
         var _loc4_:int = int(_loc2_[this.obf_K_h_3590].level);
         if(_loc4_ < _loc3_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","openLevel"));
            return;
         }
         if(this.isMoney && GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_Y_7_1544.getRideRefineCon(),["money"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noMoney"));
            return;
         }
         var _loc5_:Object = GameItemManager.getItemConfig(JSONUtil.getStr(obf_Y_7_1544.getRideRefineCon(),["item"]));
         if(obf_K_e_3075.playerBagUI.getItemCount(JSONUtil.getStr(obf_Y_7_1544.getRideRefineCon(),["item"])) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","inheritCost",[_loc5_.name]));
            return;
         }
         if(this.isShowRefineTip)
         {
            WindowManager.showDragonWin(DiversityManager.getString("RideBoxUI","inheritCost",[_loc5_.name]),this.sureToRefine,10);
         }
         else
         {
            this.sendRefine();
         }
      }
      
      private function sureToRefine(param1:Object) : void
      {
         if(param1.confirm)
         {
            this.sendRefine();
         }
      }
      
      private function sendRefine() : void
      {
         obf_Y_7_1544.sendEquipCommand(this.obf_4_T_3047,this.isMoney,this.obf_K_h_3590,2);
         this.obf_L_v_4211 = null;
      }
      
      public function showRefiningInfo(param1:Array, param2:Array) : void
      {
         this.isSave = true;
         this.tempAttrFinal[this.obf_K_h_3590] = [];
         this.isLimitTemp[this.obf_K_h_3590] = [];
         cmdOk.mouseEnabled = true;
         cmdOk.enabled = true;
         this.isLimitTemp[this.obf_K_h_3590] = param2;
         this.tempAttrFinal[this.obf_K_h_3590] = param1;
         this.obf_x_X_2953();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_])
            {
               this["txtRefining" + (_loc3_ + 1)].text = param1[_loc3_] + "";
               this["txtDes" + (_loc3_ + 1)].text = DiversityManager.getString("RideBoxUI","max");
            }
            else
            {
               this["txtRefining" + (_loc3_ + 1)].text = param1[_loc3_] + "";
               this["txtDes" + (_loc3_ + 1)].text = param1[_loc3_] - this.obf_0_7_p_465[_loc3_] + "";
               if(param1[_loc3_] - this.obf_0_7_p_465[_loc3_] > 0)
               {
                  this["txtDes" + (_loc3_ + 1)].text = "+" + (param1[_loc3_] - this.obf_0_7_p_465[_loc3_]);
                  this["txtDes" + (_loc3_ + 1)].textColor = obf_0_3_0_538.obf_o_2_4266;
               }
               else if(param1[_loc3_] - this.obf_0_7_p_465[_loc3_] < 0)
               {
                  this["txtDes" + (_loc3_ + 1)].textColor = obf_0_3_0_538.obf_U_4665;
               }
            }
            _loc3_++;
         }
      }
      
      public function showSoul(param1:int) : void
      {
         cmdAttribute.text = RideEquipSoulType.getSoulName(param1);
      }
      
      public function showRefineOkInfo(param1:Array) : void
      {
         this.isSave = false;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         cmdOk.mouseEnabled = false;
         cmdOk.enabled = false;
         this.tempAttrFinal[this.obf_K_h_3590] = [];
         this.isLimitTemp[this.obf_K_h_3590] = [];
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this["txtRefine" + (_loc2_ + 1)].text = param1[_loc2_] + "";
            this["txtRefining" + (_loc2_ + 1)].text = "";
            this["txtDes" + (_loc2_ + 1)].text = "";
            _loc2_++;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         changeAttribute.label = DiversityManager.getString("RideBoxUI","changeAttribute");
         refine.label = DiversityManager.getString("RideBoxUI","refine");
         cmdOk.label = DiversityManager.getString("RideBoxUI","save");
         choiceOrNot.label = DiversityManager.getString("RideBoxUI","choiceOrNot",[JSONUtil.getInt(obf_Y_7_1544.getRideRefineCon(),["money"])]);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.infoTimeInv.checkTimeout() && !this.obf_L_v_4211)
         {
            this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
            if(Boolean(this.obf_L_v_4211) && Boolean(this.obf_K_h_3590))
            {
               this.showRefine(this.obf_K_h_3590);
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
            }
         }
      }
      
      public function showRefine(param1:int) : void
      {
         equipImg.gotoAndStop(param1);
         this.obf_K_h_3590 = param1;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
         if(!this.obf_L_v_4211)
         {
            return;
         }
         this.obf_4_T_3047 = obf_K_e_3075.rideBoxUI.selectedRideId;
         var _loc2_:Object = this.obf_L_v_4211.rideInfo.equipmenet;
         this.clear();
         var _loc3_:int = int(_loc2_[param1].soul);
         this.showSoul(_loc3_);
         var _loc4_:Array = _loc2_[param1].attrSoul;
         var _loc5_:Array = _loc2_[param1].attr;
         this.obf_0_7_p_465 = [];
         this.obf_0_7_p_465 = _loc2_[param1].attrFinal;
         var _loc6_:int = 1;
         while(_loc6_ < 4)
         {
            this["txtAtt" + _loc6_].text = "(" + RideEquipSoulType.getSoulName(_loc4_[_loc6_ - 1]) + ") " + RoleAttributesModifierEnum.getAttributesName(_loc5_[_loc6_ - 1]);
            this["txtRefine" + _loc6_].text = this.obf_0_7_p_465[_loc6_ - 1] + "";
            _loc6_++;
         }
         if(this.tempAttrFinal[this.obf_K_h_3590].length > 0)
         {
            this.showRefiningInfo(this.tempAttrFinal[this.obf_K_h_3590],this.isLimitTemp[this.obf_K_h_3590]);
         }
      }
      
      public function obf_x_X_2953() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 4)
         {
            this["txtDes" + _loc1_].text = "";
            this["txtRefining" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      private function clear() : void
      {
         cmdAttribute.text = "";
         var _loc1_:int = 1;
         while(_loc1_ < 4)
         {
            this["txtAtt" + _loc1_].text = "";
            this["txtDes" + _loc1_].text = "";
            this["txtRefine" + _loc1_].text = "";
            this["txtRefining" + _loc1_].text = "";
            _loc1_++;
         }
      }
      
      public function initDection() : void
      {
         cmdOk.mouseEnabled = false;
         cmdOk.enabled = false;
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            this.isLimitTemp[_loc1_] = [];
            this.tempAttrFinal[_loc1_] = [];
            _loc1_++;
         }
      }
      
      public function showUI() : void
      {
         this.obf_K_h_3590 = 1;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
         this.showRefine(1);
      }
      
      public function closeUI() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
         this.isShowRefineTip = true;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

