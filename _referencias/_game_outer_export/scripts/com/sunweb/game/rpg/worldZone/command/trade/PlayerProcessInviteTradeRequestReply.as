package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessInviteTradeRequestReply extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessInviteTradeRequestReply()
      {
         super(CommandCodePlayerTrade.PLAYER_PROCESS_INVITE_TRADE_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","isAgreed:boolean"];
      }
   }
}

