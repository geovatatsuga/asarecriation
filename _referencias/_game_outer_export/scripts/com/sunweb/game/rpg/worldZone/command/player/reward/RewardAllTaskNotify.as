package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardAllTaskNotify extends obf_O_8_1034
   {
      
      public var tasks:Array;
      
      public var isUpdate:Boolean;
      
      public function RewardAllTaskNotify()
      {
         super(CommandCodeReward.REWARD_ALL_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["tasks:array(int)","isUpdate:boolean"];
      }
   }
}

