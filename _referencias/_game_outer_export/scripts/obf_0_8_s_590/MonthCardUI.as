package obf_0_8_s_590
{
   import obf_l_I_3561.obf_g_0_3344;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MonthCardUIMC;
   
   public class MonthCardUI extends MonthCardUIMC implements IPlayerUI
   {
      
      private var monthObj0:Object;
      
      private var monthObj1:Object;
      
      private var num0:int;
      
      private var num1:int;
      
      private var id0:String;
      
      private var id1:String;
      
      private var obf_W_k_3950:int;
      
      private var rebateTimes:Object;
      
      public function MonthCardUI()
      {
         super();
         this.visible = false;
         this.getConfig();
         cmdBuy0.visible = false;
         cmdBuy1.visible = false;
         cmdGet0.visible = false;
         cmdGet1.visible = false;
         timeTxt0.visible = false;
         timeTxt1.visible = false;
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdBuy0.addEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         cmdBuy1.addEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         cmdGet0.addEventListener(MouseEvent.CLICK,this.obf_M_4669);
         cmdGet1.addEventListener(MouseEvent.CLICK,this.obf_M_4669);
         cmdBuy0.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         cmdBuy0.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         cmdBuy1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         cmdBuy1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
      }
      
      private function removeListener() : void
      {
         cmdBuy0.removeEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         cmdBuy1.removeEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         cmdGet0.removeEventListener(MouseEvent.CLICK,this.obf_M_4669);
         cmdGet1.removeEventListener(MouseEvent.CLICK,this.obf_M_4669);
         cmdBuy0.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         cmdBuy0.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         cmdBuy1.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         cmdBuy1.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
      }
      
      private function obf_b_i_1293(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(param1.currentTarget == cmdBuy0)
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(this.monthObj0,["needMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FundUI","noMoney"));
               return;
            }
            _loc2_ = int(this.rebateTimes[this.id0]);
            _loc3_ = JSONUtil.getValue(this.monthObj0,"creditByTimes") as Array;
            _loc4_ = int(_loc3_[_loc2_]);
            if(_loc2_ >= _loc3_.length)
            {
               return;
            }
            if(this.obf_W_k_3950 < _loc4_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("MonthCardUI","noCreditValue",[_loc4_]));
               return;
            }
            obf_g_0_3344.sendFundBuyRequest(3,this.id0);
         }
         if(param1.currentTarget == cmdBuy1)
         {
            if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(this.monthObj1,["needMoney"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FundUI","noMoney"));
               return;
            }
            _loc2_ = int(this.rebateTimes[this.id1]);
            _loc3_ = JSONUtil.getValue(this.monthObj1,"creditByTimes") as Array;
            _loc4_ = int(_loc3_[_loc2_]);
            if(_loc2_ >= _loc3_.length)
            {
               return;
            }
            if(this.obf_W_k_3950 < _loc4_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("MonthCardUI","noCreditValue",[_loc4_]));
               return;
            }
            obf_g_0_3344.sendFundBuyRequest(3,this.id1);
         }
      }
      
      private function obf_N_N_1987(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:GameTipUI = new GameTipUI("MonthCardUI");
         if(param1.currentTarget == cmdBuy1)
         {
            _loc2_ = int(this.rebateTimes[this.id1]);
            _loc3_ = JSONUtil.getValue(this.monthObj1,"creditByTimes") as Array;
            _loc4_ = int(_loc3_[_loc2_]);
            _loc5_ = JSONUtil.getInt(this.monthObj1,["needMoney"]);
         }
         else if(param1.currentTarget == cmdBuy0)
         {
            _loc2_ = int(this.rebateTimes[this.id0]);
            _loc3_ = JSONUtil.getValue(this.monthObj0,"creditByTimes") as Array;
            _loc4_ = int(_loc3_[_loc2_]);
            _loc5_ = JSONUtil.getInt(this.monthObj0,["needMoney"]);
         }
         if(_loc2_ >= _loc3_.length)
         {
            return;
         }
         _loc6_.addTipInfo(DiversityManager.getString("MonthCardUI","conditon"),150,_loc6_.maxRow + 1);
         _loc6_.addTipInfo(DiversityManager.getString("MonthCardUI","money",[_loc5_]),150,_loc6_.maxRow + 1);
         if(_loc4_ > 0)
         {
            _loc6_.addTipInfo(DiversityManager.getString("MonthCardUI","creditValue",[_loc4_]),150,_loc6_.maxRow + 1);
         }
         GameTipManager.showTip(_loc6_);
      }
      
      private function obf_k_a_2234(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("MonthCardUI");
      }
      
      private function obf_M_4669(param1:Event) : void
      {
         if(param1.currentTarget == cmdGet0)
         {
            if(this.num0 > 0 && this.getCount(this.id0) == 0)
            {
               obf_g_0_3344.sendGetMonthCardRequest(this.id0);
            }
         }
         if(param1.currentTarget == cmdGet1)
         {
            if(this.num1 > 0 && this.getCount(this.id1) == 0)
            {
               obf_g_0_3344.sendGetMonthCardRequest(this.id1);
            }
         }
      }
      
      public function obf_0_1_L_283(param1:int) : void
      {
         txtcreditValue.text = "";
         txtCreditReamrk.visible = false;
         txtcreditValue.visible = false;
         this.obf_W_k_3950 = param1;
         txtcreditValue.text = DiversityManager.getString("MonthCardUI","txtcreditValue",[this.obf_W_k_3950]);
         this.setShow();
      }
      
      public function obf_E_1_955(param1:Object) : void
      {
         this.rebateTimes = new Object();
         this.rebateTimes = param1;
         this.setShow();
      }
      
      public function getSetMonthCard(param1:String) : Boolean
      {
         if(this.rebateTimes[param1] > 0)
         {
            return true;
         }
         return false;
      }
      
      private function setShow() : void
      {
         var _loc1_:Array = JSONUtil.getValue(this.monthObj0,"creditByTimes") as Array;
         var _loc2_:Array = JSONUtil.getValue(this.monthObj1,"creditByTimes") as Array;
         if(this.rebateTimes[this.id0] > 1 && this.rebateTimes[this.id0] < _loc1_.length || this.rebateTimes[this.id1] > 1 && this.rebateTimes[this.id1] < _loc2_.length)
         {
            txtCreditReamrk.visible = true;
            txtcreditValue.visible = true;
         }
      }
      
      private function getCount(param1:String) : int
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$fundRebateId-" + param1);
         return JSONUtil.getInt(_loc2_,["numOfDay"]);
      }
      
      private function getConfig() : void
      {
         var _loc1_:Array = obf_g_0_3344.getMonthCard();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            this["monthObj" + _loc2_] = _loc1_[_loc2_];
            _loc2_++;
         }
         this.id0 = JSONUtil.getStr(this.monthObj0,["id"]);
         this.id1 = JSONUtil.getStr(this.monthObj1,["id"]);
      }
      
      public function obf_x_L_2564(param1:Object) : void
      {
         this.num0 = this.getLastDays(param1,this.monthObj0);
         this.num1 = this.getLastDays(param1,this.monthObj1);
         if(!this.num0 || this.num0 == 0)
         {
            cmdBuy0.visible = false;
            cmdGet0.visible = false;
            timeTxt0.visible = false;
         }
         if(this.num0 > 0)
         {
            cmdBuy0.visible = false;
            cmdGet0.visible = true;
            timeTxt0.visible = true;
            DiversityManager.setTextField(timeTxt0,"MonthCardUI","timeTxt",[this.num0]);
            if(this.getCount(this.id0) == 0)
            {
               cmdGet0.label = DiversityManager.getString("MonthCardUI","get");
               cmdGet0.mouseEnabled = true;
               cmdGet0.enabled = true;
            }
            else if(this.getCount(this.id0) > 0)
            {
               cmdGet0.label = DiversityManager.getString("MonthCardUI","getted");
               cmdGet0.mouseEnabled = false;
               cmdGet0.enabled = false;
            }
         }
         if(!this.num1 || this.num1 == 0)
         {
            cmdBuy1.visible = false;
            cmdGet1.visible = false;
            timeTxt1.visible = false;
         }
         if(this.num1 > 0)
         {
            cmdBuy1.visible = false;
            cmdGet1.visible = true;
            timeTxt1.visible = true;
            timeTxt1.text = DiversityManager.getString("MonthCardUI","timeTxt",[this.num1]);
            if(this.getCount(this.id1) == 0)
            {
               cmdGet1.label = DiversityManager.getString("MonthCardUI","get");
               cmdGet1.mouseEnabled = true;
               cmdGet1.enabled = true;
            }
            else if(this.getCount(this.id1) > 0)
            {
               cmdGet1.label = DiversityManager.getString("MonthCardUI","getted");
               cmdGet1.mouseEnabled = false;
               cmdGet1.enabled = false;
            }
         }
      }
      
      private function getLastDays(param1:Object, param2:Object) : int
      {
         var _loc3_:String = JSONUtil.getStr(param2,["id"]);
         var _loc4_:int = int(param1[_loc3_]);
         return param1[_loc3_];
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
         DiversityManager.setTextField(titleTxt0,"MonthCardUI","titleTxt",[JSONUtil.getInt(this.monthObj0,["needMoney"])]);
         DiversityManager.setTextField(titleTxt1,"MonthCardUI","titleTxt",[JSONUtil.getInt(this.monthObj1,["needMoney"])]);
         cmdBuy0.label = DiversityManager.getString("FundUI","buy");
         cmdBuy1.label = DiversityManager.getString("FundUI","buy");
         txtRemark1.htmlText = JSONUtil.getStr(obf_g_0_3344.getMonthCard()[0],["explanation"]);
         txtRemark2.htmlText = JSONUtil.getStr(obf_g_0_3344.getMonthCard()[1],["explanation"]);
         DiversityManager.setTextField(txtCreditReamrk,"MonthCardUI","txtCreditReamrk");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_x_L_2564(obf_g_0_3344.cardObj);
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

