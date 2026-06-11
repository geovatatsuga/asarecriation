package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMpMaxChangeNotify extends obf_O_8_1034
   {
      
      public var mpCurrent:int;
      
      public var mpMax:int;
      
      public function PlayerMpMaxChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_MPMAX_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mpCurrent:int","mpMax:int"];
      }
   }
}

