package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotOpenRequest extends obf_O_8_1034
   {
      
      public function RobotOpenRequest()
      {
         super(CommandCodeArenaRobot.ROBOT_OPEN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

