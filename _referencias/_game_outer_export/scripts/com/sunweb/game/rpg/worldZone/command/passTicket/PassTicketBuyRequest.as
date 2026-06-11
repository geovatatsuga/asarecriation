package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketBuyRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function PassTicketBuyRequest()
      {
         super(CommandCodePassTicket.PASS_TICKET_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

