package com.sunweb.game.rpg.worldZone.command.runningMan
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRunAwardNotify extends obf_O_8_1034
   {
      
      public var awardType:Object;
      
      public function PlayerRunAwardNotify()
      {
         super(CommandCodePlayerRunConfig.PLAYER_RUN_AWARD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["awardType:map(string,ubyte)"];
      }
   }
}

