package com.sunweb.game.rpg.playerUI.activity
{
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.ActivityBoxMC;
   
   public class obf_6_C_2385 extends ActivityBoxMC
   {
      
      private var obf_d_A_3301:String;
      
      private var obf_0_8_X_483:Object;
      
      public function obf_6_C_2385(param1:Object)
      {
         super();
         this.initDiversity();
         this.obf_0_8_X_483 = param1;
         this.obf_d_A_3301 = param1.activityCode;
         this.obf_2_Y_3019();
         this.addListener();
      }
      
      private function obf_D_O_1893(param1:Event) : void
      {
         var _loc2_:String = "";
         _loc2_ = this.obf_0_8_X_483.activityName;
         var _loc3_:GameTipUI = new GameTipUI("activity");
         var _loc4_:int = 250;
         _loc3_.addTipInfo(_loc2_,_loc4_,_loc3_.maxRow + 1);
         GameTipManager.showTip(_loc3_);
      }
      
      private function obf_V_W_2008(param1:Event) : void
      {
         GameTipManager.closeTip("activity");
      }
      
      public function obf_2_Y_3019() : void
      {
         txtActDate.text = JSONUtil.getStr(this.obf_0_8_X_483,["listTime"],DiversityManager.getString("ActivityUI","actNoTimeLimit"));
         txtName.text = this.obf_0_8_X_483.activityName;
         var _loc1_:String = DiversityManager.getString("ActivityUI","level_all");
         if(JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevel"]) > 0 && JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevelMax"]) > 0)
         {
            _loc1_ = DiversityManager.getString("ActivityUI","level_limit",[JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevel"]),JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevelMax"])]);
         }
         else if(JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevel"]) > 0)
         {
            _loc1_ = DiversityManager.getString("ActivityUI","level_min",[JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevel"])]);
         }
         else if(JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevelMax"]) > 0)
         {
            _loc1_ = DiversityManager.getString("ActivityUI","level_max",[JSONUtil.getInt(this.obf_0_8_X_483,["listRoleLevelMax"])]);
         }
         txtRoleLevel.text = _loc1_;
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_0_8_X_483.listNumberLimitFlag);
         var _loc3_:String = DiversityManager.getString("ActivityUI","actNoTimeLimit");
         if(JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerDay"]) > 0)
         {
            _loc3_ = DiversityManager.getString("ActivityUI","actPerDay",[JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerDay"]) - JSONUtil.getInt(_loc2_,["numOfDay"]),JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerDay"])]);
         }
         else if(JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerWeek"]) > 0)
         {
            _loc3_ = DiversityManager.getString("ActivityUI","actPerWeek",[JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerWeek"]) - JSONUtil.getInt(_loc2_,["numOfWeek"]),JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerWeek"])]);
         }
         else if(JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerMonth"]) > 0)
         {
            _loc3_ = DiversityManager.getString("ActivityUI","actPerMonth",[JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerMonth"]) - JSONUtil.getInt(_loc2_,["numOfMonth"]),JSONUtil.getInt(this.obf_0_8_X_483,["listNumberPerMonth"])]);
         }
         txtTimes.text = _loc3_;
         txtStatus.htmlText = DiversityManager.getString("ActivityUI",obf_J_F_3431.obf_U_Q_3887([this.obf_0_8_X_483.activityCode]) ? "actEnabled" : "actDisabled");
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function get actCode() : String
      {
         return this.obf_d_A_3301;
      }
      
      public function actConfig() : Object
      {
         return this.obf_0_8_X_483;
      }
      
      private function addListener() : void
      {
         txtName.addEventListener(MouseEvent.MOUSE_OVER,this.obf_D_O_1893);
         txtName.addEventListener(MouseEvent.MOUSE_OUT,this.obf_V_W_2008);
      }
      
      private function removeListener() : void
      {
         txtName.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_D_O_1893);
         txtName.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_V_W_2008);
      }
      
      private function obf_3_7_4442(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

