package com.sunweb.game.rpg.mail
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MailContentInfo extends obf_2_M_853
   {
      
      public var mailId:int;
      
      public var sender:String;
      
      public var mailTitle:String;
      
      public var mailContent:String;
      
      public var mailDate:String;
      
      public function MailContentInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["mailId:int","sender:string","mailTitle:string","mailContent:string","mailDate:string"];
      }
   }
}

