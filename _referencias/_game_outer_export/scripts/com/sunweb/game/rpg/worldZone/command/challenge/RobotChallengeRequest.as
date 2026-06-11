package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotChallengeRequest extends obf_O_8_1034
   {
      
      public var robotLevel:int;
      
      public function RobotChallengeRequest()
      {
         super(CommandCodeArenaRobot.ROBOT_CHALLENGE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["robotLevel:ushort"];
      }
   }
}

