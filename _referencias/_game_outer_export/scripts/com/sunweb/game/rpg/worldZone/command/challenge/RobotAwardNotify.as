package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotAwardNotify extends obf_O_8_1034
   {
      
      public var canAward:Boolean;
      
      public function RobotAwardNotify()
      {
         super(CommandCodeArenaRobot.ROBOT_AWARD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["canAward:boolean"];
      }
   }
}

