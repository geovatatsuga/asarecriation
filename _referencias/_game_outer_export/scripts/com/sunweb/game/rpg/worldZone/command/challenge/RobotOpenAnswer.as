package com.sunweb.game.rpg.worldZone.command.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RobotOpenAnswer extends obf_O_8_1034
   {
      
      public var robotLevel:int;
      
      public var awardLevel:int;
      
      public var itemCode:String;
      
      public var robotNum:int;
      
      public var heroList:Object;
      
      public var robotList:Object;
      
      public function RobotOpenAnswer()
      {
         super(CommandCodeArenaRobot.ROBOT_OPEN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["robotLevel:ushort","awardLevel:ushort","itemCode:string","robotNum:ubyte","heroList:map(ubyte,string)","robotList:map(ushort,com.sunweb.game.rpg.challenge.ArenaRobotInfo)"];
      }
   }
}

