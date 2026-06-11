package com.sunweb.game.rpg.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MailListItemInfo extends obf_2_M_853
   {
      
      public var mailId:int;
      
      public var mailTitle:String;
      
      public var mailSender:String;
      
      public var mailDate:String;
      
      public var hasRead:Boolean;
      
      public function MailListItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["mailId:int","mailTitle:string","mailSender:string","mailDate:string","hasRead:boolean"];
      }
   }
}

