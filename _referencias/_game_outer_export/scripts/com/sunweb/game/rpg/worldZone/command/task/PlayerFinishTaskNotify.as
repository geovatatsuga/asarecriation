package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFinishTaskNotify extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function PlayerFinishTaskNotify()
      {
         super(CommandCodeTask.PLAYER_FINISH_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

