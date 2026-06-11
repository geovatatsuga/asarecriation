package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardPlayerInfoNotify extends obf_O_8_1034
   {
      
      public var rank:int;
      
      public var level:int;
      
      public var exp:int;
      
      public function RewardPlayerInfoNotify()
      {
         super(CommandCodeReward.REWARD_PLAYER_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rank:ubyte","level:ubyte","exp:int"];
      }
   }
}

