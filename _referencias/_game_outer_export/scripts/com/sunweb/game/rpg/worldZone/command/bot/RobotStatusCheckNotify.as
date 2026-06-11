package com.sunweb.game.rpg.worldZone.command.bot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotStatusCheckNotify extends obf_O_8_1034
   {
      
      public var isRobot:Boolean;
      
      public var robotTime1LeftInSec:int;
      
      public var robotTime2LeftInSec:int;
      
      public function RobotStatusCheckNotify()
      {
         super(CommandCodeRobot.ROBOT_STATUS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isRobot:boolean","robotTime1LeftInSec:int","robotTime2LeftInSec:int"];
      }
   }
}

