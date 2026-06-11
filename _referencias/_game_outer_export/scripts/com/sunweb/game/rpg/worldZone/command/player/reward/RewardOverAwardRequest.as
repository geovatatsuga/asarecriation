package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardOverAwardRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function RewardOverAwardRequest()
      {
         super(CommandCodeReward.REWARD_OVER_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

