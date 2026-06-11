package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailDeleteRequest extends obf_O_8_1034
   {
      
      public var mailId:int;
      
      public function MailDeleteRequest()
      {
         super(CommandCodeMail.MAIL_DELETE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mailId:int"];
      }
   }
}

