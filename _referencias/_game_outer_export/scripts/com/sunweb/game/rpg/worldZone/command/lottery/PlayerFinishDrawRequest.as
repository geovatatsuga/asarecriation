package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFinishDrawRequest extends obf_O_8_1034
   {
      
      public function PlayerFinishDrawRequest()
      {
         super(CommandCodeLottery.PLAYER_FINISH_DRAW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

