package com.sunweb.game.rpg.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class TaskRecorder extends obf_2_M_853
   {
      
      public static var MAX_DOING_TASK_NUMBER:int = 10;
      
      public var doingAllocators:Object = new Object();
      
      public var doingTasks:Array = new Array();
      
      public var doneTasks:Object = new Object();
      
      public function TaskRecorder()
      {
         super();
      }
      
      public function delAllocatorByTaskId(param1:int) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.doingAllocators)
         {
            if(this.doingAllocators[_loc2_] == param1)
            {
               delete this.doingAllocators[_loc2_];
            }
         }
      }
      
      public function getAllocatorByTaskId(param1:int) : int
      {
         var _loc2_:String = null;
         for(_loc2_ in this.doingAllocators)
         {
            if(this.doingAllocators[_loc2_] == param1)
            {
               return int(_loc2_);
            }
         }
         return 0;
      }
      
      public function addDoingTask(param1:int, param2:int = 0) : void
      {
         if(this.doingTasks.indexOf(param1) <= -1)
         {
            this.doingTasks.push(param1);
            if(param2 > 0)
            {
               this.doingAllocators[param2] = param1;
            }
         }
      }
      
      public function delDoingTask(param1:int) : void
      {
         if(this.doingTasks.indexOf(param1) > -1)
         {
            this.doingTasks.splice(this.doingTasks.indexOf(param1),1);
            this.delAllocatorByTaskId(param1);
         }
      }
      
      public function addDoneTask(param1:int) : void
      {
         if(this.doneTasks[param1] == null)
         {
            this.doneTasks[param1] = 0;
         }
         ++this.doneTasks[param1];
      }
      
      public function delDoneTask(param1:int, param2:int = 1) : void
      {
         if(this.doneTasks[param1] != null)
         {
            if(param2 < 0)
            {
               param2 = 65535;
            }
            this.doneTasks[param1] -= param2;
            if(this.doneTasks[param1] < 0)
            {
               delete this.doneTasks[param1];
            }
         }
      }
      
      override public function getFieldList() : Array
      {
         return ["doingAllocators:map(ushort,ushort)","doingTasks:array(ushort)","doneTasks:map(ushort,short)"];
      }
   }
}

