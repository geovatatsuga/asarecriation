package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ReceiveTaskConstellationRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function ReceiveTaskConstellationRequest()
      {
         super(CommandCodePlayerConstellation.RECEIVE_TASK_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

