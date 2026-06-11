package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketAwardRequest extends obf_O_8_1034
   {
      
      public function PassTicketAwardRequest()
      {
         super(CommandCodePassTicket.PASS_TICKET_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

