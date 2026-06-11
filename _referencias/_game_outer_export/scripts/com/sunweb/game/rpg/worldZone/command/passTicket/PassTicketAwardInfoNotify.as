package com.sunweb.game.rpg.worldZone.command.passTicket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PassTicketAwardInfoNotify extends obf_O_8_1034
   {
      
      public var hasMidd:Boolean;
      
      public var hasHigh:Boolean;
      
      public var awardFree:int;
      
      public var awardMidd:int;
      
      public var awardHigh:int;
      
      public function PassTicketAwardInfoNotify()
      {
         super(CommandCodePassTicket.PASS_TICKET_AWARD_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["hasMidd:boolean","hasHigh:boolean","awardFree:ubyte","awardMidd:ubyte","awardHigh:ubyte"];
      }
   }
}

