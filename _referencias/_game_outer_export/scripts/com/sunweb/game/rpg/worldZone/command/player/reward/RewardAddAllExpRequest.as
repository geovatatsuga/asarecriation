package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardAddAllExpRequest extends obf_O_8_1034
   {
      
      public function RewardAddAllExpRequest()
      {
         super(CommandCodeReward.REWARD_ADD_ALL_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

