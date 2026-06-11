package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundBuyNumNotify extends obf_O_8_1034
   {
      
      public var num:int;
      
      public function PlayerFundBuyNumNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_BUY_NUM_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["num:ushort"];
      }
   }
}

