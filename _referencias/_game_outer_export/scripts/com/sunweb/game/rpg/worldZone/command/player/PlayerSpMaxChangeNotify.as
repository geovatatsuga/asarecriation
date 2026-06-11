package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSpMaxChangeNotify extends obf_O_8_1034
   {
      
      public var spCurrent:int;
      
      public var spMax:int;
      
      public function PlayerSpMaxChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_SPMAX_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["spCurrent:int","spMax:int"];
      }
   }
}

