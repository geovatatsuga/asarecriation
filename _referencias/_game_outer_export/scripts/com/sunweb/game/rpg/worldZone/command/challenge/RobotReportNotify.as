package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotReportNotify extends obf_O_8_1034
   {
      
      public var reportList:Array;
      
      public function RobotReportNotify()
      {
         super(CommandCodeArenaRobot.ROBOT_REPORT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["reportList:array(string)"];
      }
   }
}

