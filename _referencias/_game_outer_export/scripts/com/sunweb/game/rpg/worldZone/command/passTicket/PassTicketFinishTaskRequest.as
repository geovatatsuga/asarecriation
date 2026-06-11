package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketFinishTaskRequest extends obf_O_8_1034
   {
      
      public var taskId:int;
      
      public function PassTicketFinishTaskRequest()
      {
         super(CommandCodePassTicket.PASS_TICKET_FINISH_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort"];
      }
   }
}

