package com.sunweb.game.rpg.worldZone.command.runningMan
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRunOnlineTimeNotify extends obf_O_8_1034
   {
      
      public var onlineTime:int;
      
      public function PlayerRunOnlineTimeNotify()
      {
         super(CommandCodePlayerRunConfig.PLAYER_RUN_ONLINE_TIME_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["onlineTime:int"];
      }
   }
}

