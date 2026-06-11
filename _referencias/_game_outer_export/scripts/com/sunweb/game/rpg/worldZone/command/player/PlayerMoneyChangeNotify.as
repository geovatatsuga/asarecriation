package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMoneyChangeNotify extends obf_O_8_1034
   {
      
      public var moneyChanged:int;
      
      public var moneyCurrent:int;
      
      public function PlayerMoneyChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_MONEY_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["moneyChanged:int","moneyCurrent:int"];
      }
   }
}

