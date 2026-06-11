package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailSendRequest extends obf_O_8_1034
   {
      
      public var mailType:int;
      
      public var targetPlayer:String;
      
      public var mailTitle:String;
      
      public var mailContent:String;
      
      public function MailSendRequest()
      {
         super(CommandCodeMail.MAIL_SEND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mailType:byte","targetPlayer:string","mailTitle:string","mailContent:string"];
      }
   }
}

