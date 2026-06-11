package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAbortTaskNotify extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function PlayerAbortTaskNotify()
      {
         super(CommandCodeTask.PLAYER_ABORT_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

