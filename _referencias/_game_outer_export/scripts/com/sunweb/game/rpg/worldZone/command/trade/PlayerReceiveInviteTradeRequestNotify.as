package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveInviteTradeRequestNotify extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public function PlayerReceiveInviteTradeRequestNotify()
      {
         super(CommandCodePlayerTrade.PLAYER_RECEIVE_INVITE_TRADE_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string"];
      }
   }
}

