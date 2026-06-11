package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInviteTradeRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerInviteTradeRequest()
      {
         super(CommandCodePlayerTrade.PLAYER_INVITE_TRADE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 51209;
      }
   }
}

