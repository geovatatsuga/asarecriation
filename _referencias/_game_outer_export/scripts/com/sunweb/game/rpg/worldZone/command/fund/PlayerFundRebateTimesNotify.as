package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundRebateTimesNotify extends obf_O_8_1034
   {
      
      public var rebateTimes:Object;
      
      public function PlayerFundRebateTimesNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_REBATE_TIMES_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rebateTimes:map(string,ubyte)"];
      }
   }
}

