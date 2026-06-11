package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRebirthRequest extends obf_O_8_1034
   {
      
      public var rebirthMode:int;
      
      public function PlayerRebirthRequest()
      {
         super(CommandCodePlayer.PLAYER_REBIRTH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["rebirthMode:byte"];
      }
   }
}

