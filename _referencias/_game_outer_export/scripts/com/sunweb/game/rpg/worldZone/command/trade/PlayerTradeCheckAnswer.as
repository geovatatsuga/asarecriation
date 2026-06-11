package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeCheckAnswer extends obf_O_8_1034
   {
      
      public var que:String;
      
      public function PlayerTradeCheckAnswer()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_CHECK_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["que:string"];
      }
   }
}

