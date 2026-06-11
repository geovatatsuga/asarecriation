package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotAwardRequest extends obf_O_8_1034
   {
      
      public function RobotAwardRequest()
      {
         super(CommandCodeArenaRobot.ROBOT_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

