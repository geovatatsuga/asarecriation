package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerOutTaskRequest extends obf_O_8_1034
   {
      
      public var star:int;
      
      public function RewardPlayerOutTaskRequest()
      {
         super(CommandCodeReward.REWARD_PLAYER_OUT_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["star:ubyte"];
      }
   }
}

