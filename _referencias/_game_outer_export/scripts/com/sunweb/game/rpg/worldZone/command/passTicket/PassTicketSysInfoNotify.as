package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketSysInfoNotify extends obf_O_8_1034
   {
      
      public var passTicketCode:String;
      
      public var leaveDay:int;
      
      public function PassTicketSysInfoNotify()
      {
         super(CommandCodePassTicket.PASS_TICKET_SYS_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["passTicketCode:string","leaveDay:ubyte"];
      }
   }
}

