package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeItemSubmitRequest extends obf_O_8_1034
   {
      
      public var otherPlayerId:String;
      
      public var gold:int;
      
      public var itemList:Array;
      
      public function PlayerTradeItemSubmitRequest()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_ITEM_SUBMIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["otherPlayerId:string","gold:int","itemList:array(com.sunweb.game.rpg.trade.TradeItemInfo)"];
      }
      
      override public function getDigestKey() : int
      {
         return 3072;
      }
   }
}

