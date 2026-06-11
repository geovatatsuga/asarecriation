package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardFinishTaskRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function RewardFinishTaskRequest()
      {
         super(CommandCodeReward.REWARD_FINISH_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:int"];
      }
   }
}

