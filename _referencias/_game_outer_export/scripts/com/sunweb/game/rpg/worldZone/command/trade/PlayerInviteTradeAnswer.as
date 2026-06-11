package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInviteTradeAnswer extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerInviteTradeAnswer()
      {
         super(CommandCodePlayerTrade.PLAYER_INVITE_TRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string","isAgreed:boolean"];
      }
   }
}

