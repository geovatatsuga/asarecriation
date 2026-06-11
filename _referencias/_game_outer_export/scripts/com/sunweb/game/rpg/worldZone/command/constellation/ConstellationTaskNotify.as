package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ConstellationTaskNotify extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function ConstellationTaskNotify()
      {
         super(CommandCodePlayerConstellation.CONSTELLATION_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

