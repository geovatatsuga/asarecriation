package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundRebateNotify extends obf_O_8_1034
   {
      
      public var lastDays:Object;
      
      public function PlayerFundRebateNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_REBATE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["lastDays:map(string,ubyte)"];
      }
   }
}

