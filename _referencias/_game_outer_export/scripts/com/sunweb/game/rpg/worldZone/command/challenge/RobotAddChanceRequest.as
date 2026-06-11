package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotAddChanceRequest extends obf_O_8_1034
   {
      
      public function RobotAddChanceRequest()
      {
         super(CommandCodeArenaRobot.ROBOT_ADD_CHANCE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

