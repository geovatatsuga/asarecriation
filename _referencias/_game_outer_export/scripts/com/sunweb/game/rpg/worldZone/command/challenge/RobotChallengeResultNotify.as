package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotChallengeResultNotify extends obf_O_8_1034
   {
      
      public var result:Boolean;
      
      public function RobotChallengeResultNotify()
      {
         super(CommandCodeArenaRobot.ROBOT_CHALLENGE_RESULT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["result:boolean"];
      }
   }
}

