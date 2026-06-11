package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailSendAnswer extends obf_O_8_1034
   {
      
      public var isSucceed:Boolean;
      
      public function MailSendAnswer()
      {
         super(CommandCodeMail.MAIL_SEND_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSucceed:boolean"];
      }
   }
}

