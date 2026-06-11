package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerSpRequest extends obf_O_8_1034
   {
      
      public var spType:int;
      
      public function RewardPlayerSpRequest()
      {
         super(CommandCodeReward.REWARD_PLAYER_SP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["spType:int"];
      }
   }
}

