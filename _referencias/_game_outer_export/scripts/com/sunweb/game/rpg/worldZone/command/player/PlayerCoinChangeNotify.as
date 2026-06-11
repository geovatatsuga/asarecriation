package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCoinChangeNotify extends obf_O_8_1034
   {
      
      public var coinChanged:int;
      
      public var coinCurrent:int;
      
      public function PlayerCoinChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_COIN_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["coinChanged:int","coinCurrent:int"];
      }
   }
}

