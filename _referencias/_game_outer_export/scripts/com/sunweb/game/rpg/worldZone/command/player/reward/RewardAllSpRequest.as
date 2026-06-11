package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardAllSpRequest extends obf_O_8_1034
   {
      
      public var spType:int;
      
      public function RewardAllSpRequest()
      {
         super(CommandCodeReward.REWARD_ALL_SP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["spType:int"];
      }
   }
}

