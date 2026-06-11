package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundBuyRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var rebateId:String;
      
      public function PlayerFundBuyRequest()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","rebateId:string"];
      }
   }
}

