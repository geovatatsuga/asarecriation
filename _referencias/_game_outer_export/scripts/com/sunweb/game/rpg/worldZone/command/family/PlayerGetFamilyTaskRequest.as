package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGetFamilyTaskRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function PlayerGetFamilyTaskRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_GET_FAMILY_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

