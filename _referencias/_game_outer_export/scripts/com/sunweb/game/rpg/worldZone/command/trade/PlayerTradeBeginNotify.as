package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeBeginNotify extends obf_O_8_1034
   {
      
      public var otherPlayerId:String;
      
      public function PlayerTradeBeginNotify()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_BEGIN_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["otherPlayerId:string"];
      }
   }
}

