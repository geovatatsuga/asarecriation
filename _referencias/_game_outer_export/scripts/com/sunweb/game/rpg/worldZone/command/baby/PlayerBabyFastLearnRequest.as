package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyFastLearnRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyFastLearnRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_FAST_LEARN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

