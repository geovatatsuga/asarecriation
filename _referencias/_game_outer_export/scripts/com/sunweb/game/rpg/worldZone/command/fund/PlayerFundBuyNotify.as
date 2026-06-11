package com.sunweb.game.rpg.worldZone.command.fund
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFundBuyNotify extends obf_O_8_1034
   {
      
      public var isGrow:Boolean;
      
      public var isRegal:Boolean;
      
      public function PlayerFundBuyNotify()
      {
         super(CommandCodePlayerFund.PLAYER_FUND_BUY_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isGrow:boolean","isRegal:boolean"];
      }
   }
}

