package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerTaskNotify extends obf_O_8_1034
   {
      
      public var refreshIn:Boolean;
      
      public var refreshOut:Boolean;
      
      public var isOut:Boolean;
      
      public var awardExp:int;
      
      public function RewardPlayerTaskNotify()
      {
         super(CommandCodeReward.REWARD_PLAYER_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["refreshIn:boolean","refreshOut:boolean","isOut:boolean","awardExp:int"];
      }
   }
}

