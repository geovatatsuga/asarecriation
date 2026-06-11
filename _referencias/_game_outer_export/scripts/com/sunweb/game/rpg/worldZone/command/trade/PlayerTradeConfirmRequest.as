package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeConfirmRequest extends obf_O_8_1034
   {
      
      public var otherPlayerId:String;
      
      public function PlayerTradeConfirmRequest()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_CONFIRM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["otherPlayerId:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 49279;
      }
   }
}

