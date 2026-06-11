package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerXpMaxChangeNotify extends obf_O_8_1034
   {
      
      public var xpCurrent:int;
      
      public var xpMax:int;
      
      public function PlayerXpMaxChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_XPMAX_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["xpCurrent:int","xpMax:int"];
      }
   }
}

