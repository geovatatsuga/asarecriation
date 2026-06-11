package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketTaskNotify extends obf_O_8_1034
   {
      
      public var isOk:Boolean;
      
      public var taskIds:Array;
      
      public function PassTicketTaskNotify()
      {
         super(CommandCodePassTicket.PASS_TICKET_TASK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isOk:boolean","taskIds:array(ushort)"];
      }
   }
}

