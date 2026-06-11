package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeItemSubmitNotify extends obf_O_8_1034
   {
      
      public var playerId:String;
      
      public var gold:int;
      
      public var itemList:Array;
      
      public function PlayerTradeItemSubmitNotify()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_ITEM_SUBMIT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["playerId:string","gold:int","itemList:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

