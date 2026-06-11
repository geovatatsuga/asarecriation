package com.sunweb.game.rpg.worldZone.command.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MailListRequest extends obf_O_8_1034
   {
      
      public var pageIndex:int;
      
      public function MailListRequest()
      {
         super(CommandCodeMail.MAIL_LIST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["pageIndex:byte"];
      }
   }
}

