package com.sunweb.game.rpg.worldZone.command.bot
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotActionRequest extends obf_O_8_1034
   {
      
      public var action:int;
      
      public function RobotActionRequest()
      {
         super(CommandCodeRobot.ROBOT_ACTION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["action:byte"];
      }
   }
}

