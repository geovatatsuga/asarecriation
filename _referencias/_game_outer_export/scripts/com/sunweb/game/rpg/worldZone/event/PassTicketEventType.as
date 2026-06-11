package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.passTicket.CommandCodePassTicket;
   
   public class PassTicketEventType
   {
      
      public static const PASS_TICKET_INFO_NOTIFY:String = CommandCodePassTicket.PASS_TICKET_INFO_NOTIFY.toString(16);
      
      public static const PASS_TICKET_BUY_REQUEST:String = CommandCodePassTicket.PASS_TICKET_BUY_REQUEST.toString(16);
      
      public static const PASS_TICKET_FINISH_TASK_REQUEST:String = CommandCodePassTicket.PASS_TICKET_FINISH_TASK_REQUEST.toString(16);
      
      public static const PASS_TICKET_AWARD_REQUEST:String = CommandCodePassTicket.PASS_TICKET_AWARD_REQUEST.toString(16);
      
      public static const PASS_TICKET_TASK_NOTIFY:String = CommandCodePassTicket.PASS_TICKET_TASK_NOTIFY.toString(16);
      
      public static const PASS_TICKET_AWARD_INFO_NOTIFY:String = CommandCodePassTicket.PASS_TICKET_AWARD_INFO_NOTIFY.toString(16);
      
      public static const PASS_TICKET_SYS_INFO_NOTIFY:String = CommandCodePassTicket.PASS_TICKET_SYS_INFO_NOTIFY.toString(16);
      
      public function PassTicketEventType()
      {
         super();
      }
   }
}

