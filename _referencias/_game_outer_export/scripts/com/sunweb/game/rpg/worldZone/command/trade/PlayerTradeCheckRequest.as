package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeCheckRequest extends obf_O_8_1034
   {
      
      public var ans:String;
      
      public function PlayerTradeCheckRequest()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_CHECK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["ans:string"];
      }
   }
}

