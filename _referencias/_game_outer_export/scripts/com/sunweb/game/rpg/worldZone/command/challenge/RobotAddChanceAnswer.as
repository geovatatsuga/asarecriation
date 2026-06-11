package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotAddChanceAnswer extends obf_O_8_1034
   {
      
      public var robotNum:int;
      
      public function RobotAddChanceAnswer()
      {
         super(CommandCodeArenaRobot.ROBOT_ADD_CHANCE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["robotNum:ubyte"];
      }
   }
}

