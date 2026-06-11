package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundWelfareRequest extends obf_O_8_1034
   {
      
      public var welfareId:String;
      
      public function PlayerFundWelfareRequest()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_WELFARE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["welfareId:string"];
      }
   }
}

