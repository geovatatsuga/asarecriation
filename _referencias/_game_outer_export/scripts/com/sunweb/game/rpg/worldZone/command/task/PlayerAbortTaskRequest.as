package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAbortTaskRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function PlayerAbortTaskRequest()
      {
         super(CommandCodeTask.PLAYER_ABORT_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

