package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotPlayerOutMapRequest extends obf_O_8_1034
   {
      
      public function RobotPlayerOutMapRequest()
      {
         super(CommandCodeArenaRobot.ROBOT_PLAYER_OUT_MAP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

