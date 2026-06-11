package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerAwardAnswer extends obf_O_8_1034
   {
      
      public function RewardPlayerAwardAnswer()
      {
         super(CommandCodeReward.REWARD_PLAYER_AWARD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

