package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailViewRequest extends obf_O_8_1034
   {
      
      public var mailId:int;
      
      public function MailViewRequest()
      {
         super(CommandCodeMail.MAIL_VIEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mailId:int"];
      }
   }
}

