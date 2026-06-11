package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSideChangeNotify extends obf_O_8_1034
   {
      
      public var side:int;
      
      public function PlayerSideChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_SIDE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["side:byte"];
      }
   }
}

