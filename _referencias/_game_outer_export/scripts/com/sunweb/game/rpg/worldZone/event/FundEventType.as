package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.fund.CommandCodePlayerFund;
   
   public class FundEventType
   {
      
      public static const PLAYER_FUND_BUY_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_BUY_NOTIFY.toString(16);
      
      public static const PLAYER_FUND_WELFARE_REWARD_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_WELFARE_REWARD_NOTIFY.toString(16);
      
      public static const PLAYER_FUND_REBATE_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_REBATE_NOTIFY.toString(16);
      
      public static const PLAYER_FUND_BUY_NUM_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_BUY_NUM_NOTIFY.toString(16);
      
      public static const PLAYER_FUND_REBATE_TIMES_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_REBATE_TIMES_NOTIFY.toString(16);
      
      public static const PLAYER_FUND_CREDIT_NOTIFY:String = CommandCodePlayerFund.PLAYER_FUND_CREDIT_NOTIFY.toString(16);
      
      public function FundEventType()
      {
         super();
      }
   }
}

