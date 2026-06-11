package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerStatusChangeNotify extends obf_O_8_1034
   {
      
      public var statusFlags:int;
      
      public function PlayerStatusChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_STATUS_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["statusFlags:int"];
      }
   }
}

