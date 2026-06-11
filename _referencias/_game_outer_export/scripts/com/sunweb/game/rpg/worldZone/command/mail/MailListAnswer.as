package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailListAnswer extends obf_O_8_1034
   {
      
      public var pageIndex:int;
      
      public var mailList:Array;
      
      public function MailListAnswer()
      {
         super(CommandCodeMail.MAIL_LIST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["pageIndex:byte","mailList:array(com.sunweb.game.rpg.mail.MailListItemInfo)"];
      }
   }
}

