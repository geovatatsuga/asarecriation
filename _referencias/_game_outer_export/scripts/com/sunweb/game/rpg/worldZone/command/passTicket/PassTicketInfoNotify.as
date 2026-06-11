package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketInfoNotify extends obf_O_8_1034
   {
      
      public var level:int;
      
      public var exp:int;
      
      public function PassTicketInfoNotify()
      {
         super(CommandCodePassTicket.PASS_TICKET_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["level:ubyte","exp:ushort"];
      }
   }
}

