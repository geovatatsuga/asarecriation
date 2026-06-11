package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundRebateRequest extends obf_O_8_1034
   {
      
      public var rebateId:String;
      
      public function PlayerFundRebateRequest()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_REBATE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rebateId:string"];
      }
   }
}

