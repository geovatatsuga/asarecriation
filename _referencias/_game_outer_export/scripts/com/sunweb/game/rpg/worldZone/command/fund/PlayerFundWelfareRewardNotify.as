package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundWelfareRewardNotify extends obf_O_8_1034
   {
      
      public var fundMap:Object;
      
      public function PlayerFundWelfareRewardNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_WELFARE_REWARD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["fundMap:map(string,boolean)"];
      }
   }
}

