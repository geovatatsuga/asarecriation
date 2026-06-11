package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundRewardRequest extends obf_O_8_1034
   {
      
      public var fundId:String;
      
      public function PlayerFundRewardRequest()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_REWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["fundId:string"];
      }
   }
}

