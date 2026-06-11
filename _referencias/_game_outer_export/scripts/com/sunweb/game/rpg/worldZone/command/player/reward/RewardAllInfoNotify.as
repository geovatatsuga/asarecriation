package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardAllInfoNotify extends obf_O_8_1034
   {
      
      public var level:int;
      
      public var exp:int;
      
      public function RewardAllInfoNotify()
      {
         super(CommandCodeReward.REWARD_ALL_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["level:ubyte","exp:int"];
      }
   }
}

