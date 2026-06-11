package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSitRequest extends obf_O_8_1034
   {
      
      public var sit:Boolean;
      
      public function PlayerSitRequest()
      {
         super(CommandCodePlayer.PLAYER_SIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["sit:boolean"];
      }
   }
}

