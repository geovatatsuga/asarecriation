package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInOutExpAnswer extends obf_O_8_1034
   {
      
      public var exp:uint;
      
      public function PlayerInOutExpAnswer()
      {
         super(CommandCodePlayerReGrow.PLAYER_IN_OUT_EXP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["exp:uint"];
      }
   }
}

