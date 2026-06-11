package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerHpMaxChangeNotify extends obf_O_8_1034
   {
      
      public var hpCurrent:Number;
      
      public var hpMax:Number;
      
      public function PlayerHpMaxChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_HPMAX_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["hpCurrent:double","hpMax:double"];
      }
   }
}

