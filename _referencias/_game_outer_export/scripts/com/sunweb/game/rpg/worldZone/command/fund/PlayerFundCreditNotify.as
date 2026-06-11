package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundCreditNotify extends obf_O_8_1034
   {
      
      public var creditValue:int;
      
      public function PlayerFundCreditNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_CREDIT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["creditValue:int"];
      }
   }
}

