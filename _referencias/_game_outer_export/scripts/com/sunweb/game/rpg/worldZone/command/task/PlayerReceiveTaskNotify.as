package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveTaskNotify extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public var taskAllocatorId:int;
      
      public function PlayerReceiveTaskNotify()
      {
         super(CommandCodeTask.PLAYER_RECEIVE_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort","taskAllocatorId:ushort"];
      }
   }
}

