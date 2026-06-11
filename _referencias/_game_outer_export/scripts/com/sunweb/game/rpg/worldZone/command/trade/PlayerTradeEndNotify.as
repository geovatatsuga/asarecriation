package com.sunweb.game.rpg.worldZone.command.trade
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTradeEndNotify extends obf_O_8_1034
   {
      
      public var otherPlayerId:String;
      
      public var result:int;
      
      public function PlayerTradeEndNotify()
      {
         super(CommandCodePlayerTrade.PLAYER_TRADE_END_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["otherPlayerId:string","result:byte"];
      }
   }
}

