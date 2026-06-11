package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFinishTaskRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var taskId:int;
      
      public function PlayerFinishTaskRequest()
      {
         super(CommandCodeTask.PLAYER_FINISH_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","taskId:ushort"];
      }
      
      override public function getDigestKey() : int
      {
         return 63234;
      }
   }
}

