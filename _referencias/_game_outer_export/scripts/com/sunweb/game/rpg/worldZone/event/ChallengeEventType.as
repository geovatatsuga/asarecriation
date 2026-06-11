package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.challenge.CommandCodeArenaRobot;
   
   public class ChallengeEventType
   {
      
      public static const ROBOT_OPEN_ANSWER:String = CommandCodeArenaRobot.ROBOT_OPEN_ANSWER.toString(16);
      
      public static const ROBOT_ADD_CHANCE_ANSWER:String = CommandCodeArenaRobot.ROBOT_ADD_CHANCE_ANSWER.toString(16);
      
      public static const ROBOT_REPORT_NOTIFY:String = CommandCodeArenaRobot.ROBOT_REPORT_NOTIFY.toString(16);
      
      public static const ROBOT_CHALLENGE_RESULT_NOTIFY:String = CommandCodeArenaRobot.ROBOT_CHALLENGE_RESULT_NOTIFY.toString(16);
      
      public static const ROBOT_AWARD_NOTIFY:String = CommandCodeArenaRobot.ROBOT_AWARD_NOTIFY.toString(16);
      
      public function ChallengeEventType()
      {
         super();
      }
   }
}

