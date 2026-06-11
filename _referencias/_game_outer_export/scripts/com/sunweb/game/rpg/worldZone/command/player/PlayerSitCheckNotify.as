package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSitCheckNotify extends obf_O_8_1034
   {
      
      public var isSitting:Boolean;
      
      public function PlayerSitCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_SIT_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSitting:boolean"];
      }
   }
}

