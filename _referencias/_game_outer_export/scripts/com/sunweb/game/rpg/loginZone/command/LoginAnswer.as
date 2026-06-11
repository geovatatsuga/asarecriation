package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LoginAnswer extends obf_O_8_1034
   {
      
      public var sessionId:String;
      
      public var failureReason:String;
      
      public function LoginAnswer()
      {
         super(CommandCodeLogin.ACCOUNT_LOGIN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["sessionId:string","failureReason:string"];
      }
   }
}

