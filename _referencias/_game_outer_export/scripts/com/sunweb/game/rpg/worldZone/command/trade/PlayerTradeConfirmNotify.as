package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeConfirmNotify extends obf_O_8_1034
   {
      
      public var playerId:String;
      
      public function PlayerTradeConfirmNotify()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_CONFIRM_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["playerId:string"];
      }
   }
}

