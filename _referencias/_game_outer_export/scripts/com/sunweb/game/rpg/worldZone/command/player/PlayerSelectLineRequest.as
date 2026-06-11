package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSelectLineRequest extends obf_O_8_1034
   {
      
      public var lineIndex:int;
      
      public function PlayerSelectLineRequest()
      {
         super(CommandCodePlayer.PLAYER_SELECT_LINE_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["lineIndex:byte"];
      }
   }
}

