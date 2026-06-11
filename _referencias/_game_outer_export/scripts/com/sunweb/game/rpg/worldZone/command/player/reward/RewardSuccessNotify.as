package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardSuccessNotify extends obf_O_8_1034
   {
      
      public var playerSp:Array;
      
      public var allSp:Array;
      
      public function RewardSuccessNotify()
      {
         super(CommandCodeReward.REWARD_SUCCESS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["playerSp:array(int)","allSp:array(int)"];
      }
   }
}

