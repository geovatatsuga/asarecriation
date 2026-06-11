package obf_l_I_3561
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.fund.CommandCodePlayerFund;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundBuyNotify;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundBuyNumNotify;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundBuyRequest;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundCreditNotify;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundRebateNotify;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundRebateRequest;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundRebateTimesNotify;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundRewardRequest;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundWelfareRequest;
   import com.sunweb.game.rpg.worldZone.command.fund.PlayerFundWelfareRewardNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_g_0_3344
   {
      
      private static var fundConfig:Object;
      
      private static var _buyNum:int;
      
      private static var obf_D_U_1833:Boolean;
      
      private static var obf_G_X_4320:Boolean;
      
      private static var obf_h_m_3501:Object;
      
      private static var _rewardList:Object;
      
      public function obf_g_0_3344()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         fundConfig = param1;
      }
      
      public static function getOpenFund() : Object
      {
         return JSONUtil.getValue(fundConfig,["growConfig"]) as Object;
      }
      
      public static function getLocalTyrantFund() : Object
      {
         return JSONUtil.getValue(fundConfig,["regalConfig"]) as Object;
      }
      
      public static function getBoon() : Object
      {
         return JSONUtil.getValue(fundConfig,["welfareConfig"]) as Object;
      }
      
      public static function getMonthCard() : Array
      {
         return JSONUtil.getValue(fundConfig,["rebateConfig"]) as Array;
      }
      
      public static function getBoonList() : Array
      {
         return JSONUtil.getValue(getBoon(),["rewardList"]) as Array;
      }
      
      public static function get getOpenLv() : int
      {
         return JSONUtil.getInt(fundConfig,["openLevel"]);
      }
      
      public static function getFundList() : Array
      {
         return JSONUtil.getValue(getOpenFund(),["rewardList"]) as Array;
      }
      
      public static function getLocalFundList() : Array
      {
         return JSONUtil.getValue(getLocalTyrantFund(),["rewardList"]) as Array;
      }
      
      public static function sendFundBuyRequest(param1:int, param2:String = "") : void
      {
         var _loc3_:PlayerFundBuyRequest = new PlayerFundBuyRequest();
         _loc3_.type = param1;
         _loc3_.rebateId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendGetMonthCardRequest(param1:String) : void
      {
         var _loc2_:PlayerFundRebateRequest = new PlayerFundRebateRequest();
         _loc2_.rebateId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendBoonRewardRequest(param1:String) : void
      {
         var _loc2_:PlayerFundWelfareRequest = new PlayerFundWelfareRequest();
         _loc2_.welfareId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendFundRewardRequest(param1:String) : void
      {
         var _loc2_:PlayerFundRewardRequest = new PlayerFundRewardRequest();
         _loc2_.fundId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerFund.PLAYER_FUND_BUY_NOTIFY)
         {
            obf_D_U_1833 = (param1 as PlayerFundBuyNotify).isGrow;
            obf_G_X_4320 = (param1 as PlayerFundBuyNotify).isRegal;
            if(obf_K_e_3075.fundUI.visible)
            {
               obf_K_e_3075.fundUI.obf_7_E_4314(obf_D_U_1833);
            }
            else if(obf_K_e_3075.localTyrantFundUI.visible)
            {
               obf_K_e_3075.localTyrantFundUI.obf_7_E_4314(obf_G_X_4320);
            }
         }
         else if(param1.code == CommandCodePlayerFund.PLAYER_FUND_REBATE_NOTIFY)
         {
            obf_h_m_3501 = (param1 as PlayerFundRebateNotify).lastDays;
            if(obf_K_e_3075.monthCardUI.visible)
            {
               obf_K_e_3075.monthCardUI.obf_x_L_2564((param1 as PlayerFundRebateNotify).lastDays);
            }
         }
         else if(param1.code == CommandCodePlayerFund.PLAYER_FUND_BUY_NUM_NOTIFY)
         {
            _buyNum = (param1 as PlayerFundBuyNumNotify).num;
            if(obf_K_e_3075.fundUI.visible)
            {
               obf_K_e_3075.fundUI.obf_K_X_4449((param1 as PlayerFundBuyNumNotify).num);
            }
            else if(obf_K_e_3075.localTyrantFundUI.visible)
            {
               obf_K_e_3075.localTyrantFundUI.obf_K_X_4449((param1 as PlayerFundBuyNumNotify).num);
            }
            else if(obf_K_e_3075.allOfPeopleBoonUI.visible)
            {
               obf_K_e_3075.allOfPeopleBoonUI.obf_K_X_4449((param1 as PlayerFundBuyNumNotify).num);
            }
         }
         else if(param1.code == CommandCodePlayerFund.PLAYER_FUND_WELFARE_REWARD_NOTIFY)
         {
            _rewardList = (param1 as PlayerFundWelfareRewardNotify).fundMap;
            if(obf_K_e_3075.fundUI.visible)
            {
               obf_K_e_3075.fundUI.obf_B_v_1525();
            }
            else if(obf_K_e_3075.localTyrantFundUI.visible)
            {
               obf_K_e_3075.localTyrantFundUI.obf_B_v_1525();
            }
            else if(obf_K_e_3075.allOfPeopleBoonUI.visible)
            {
               obf_K_e_3075.allOfPeopleBoonUI.obf_2_Y_3019();
            }
         }
         else if(param1.code == CommandCodePlayerFund.PLAYER_FUND_REBATE_TIMES_NOTIFY)
         {
            obf_o_k_903(param1 as PlayerFundRebateTimesNotify);
         }
         else if(param1.code == CommandCodePlayerFund.PLAYER_FUND_CREDIT_NOTIFY)
         {
            obf_z_h_954(param1 as PlayerFundCreditNotify);
         }
      }
      
      private static function obf_o_k_903(param1:PlayerFundRebateTimesNotify) : void
      {
         obf_K_e_3075.monthCardUI.obf_E_1_955(param1.rebateTimes);
      }
      
      private static function obf_z_h_954(param1:PlayerFundCreditNotify) : void
      {
         obf_K_e_3075.monthCardUI.obf_0_1_L_283(param1.creditValue);
      }
      
      public static function get buyNum() : int
      {
         return _buyNum;
      }
      
      public static function set buyNum(param1:int) : void
      {
         _buyNum = param1;
      }
      
      public static function get isbuyFund() : Boolean
      {
         return obf_D_U_1833;
      }
      
      public static function set isbuyFund(param1:Boolean) : void
      {
         obf_D_U_1833 = param1;
      }
      
      public static function get isbuyLocalTyrantFund() : Boolean
      {
         return obf_G_X_4320;
      }
      
      public static function set isbuyLocalTyrantFund(param1:Boolean) : void
      {
         obf_G_X_4320 = param1;
      }
      
      public static function get cardObj() : Object
      {
         return obf_h_m_3501;
      }
      
      public static function set cardObj(param1:Object) : void
      {
         obf_h_m_3501 = param1;
      }
      
      public static function get rewardList() : Object
      {
         return _rewardList;
      }
      
      public static function set rewardList(param1:Object) : void
      {
         _rewardList = param1;
      }
   }
}

