package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerAwardRequest extends obf_O_8_1034
   {
      
      public function RewardPlayerAwardRequest()
      {
         super(CommandCodeReward.REWARD_PLAYER_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

