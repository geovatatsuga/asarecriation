package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.task.CommandCodeTask;
   
   public class TaskEventType
   {
      
      public static const PLAYER_ABORT_TASK_NOTIFY:String = CommandCodeTask.PLAYER_ABORT_TASK_NOTIFY.toString(16);
      
      public static const PLAYER_FINISH_TASK_NOTIFY:String = CommandCodeTask.PLAYER_FINISH_TASK_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_TASK_NOTIFY:String = CommandCodeTask.PLAYER_RECEIVE_TASK_NOTIFY.toString(16);
      
      public function TaskEventType()
      {
         super();
      }
   }
}

