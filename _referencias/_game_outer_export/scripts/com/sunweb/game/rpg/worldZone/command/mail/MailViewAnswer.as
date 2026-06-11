package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.mail.MailContentInfo;
   
   public class MailViewAnswer extends obf_O_8_1034
   {
      
      public var mail:MailContentInfo;
      
      public function MailViewAnswer()
      {
         super(CommandCodeMail.MAIL_VIEW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["mail:com.sunweb.game.rpg.mail.MailContentInfo"];
      }
   }
}

