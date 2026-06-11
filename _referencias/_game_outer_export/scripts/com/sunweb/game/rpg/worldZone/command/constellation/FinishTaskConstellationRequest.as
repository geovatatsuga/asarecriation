package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FinishTaskConstellationRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function FinishTaskConstellationRequest()
      {
         super(CommandCodePlayerConstellation.FINISH_TASK_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

