package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailNewNotify extends obf_O_8_1034
   {
      
      public function MailNewNotify()
      {
         super(CommandCodeMail.MAIL_NEW_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

