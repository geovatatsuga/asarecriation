package com.sunweb.game.rpg.worldZone.command.task
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveTaskRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var taskId:int;
      
      public function PlayerReceiveTaskRequest()
      {
         super(CommandCodeTask.PLAYER_RECEIVE_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","taskId:ushort"];
      }
   }
}

