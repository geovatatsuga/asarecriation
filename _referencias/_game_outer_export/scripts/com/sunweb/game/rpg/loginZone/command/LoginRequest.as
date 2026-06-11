package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LoginRequest extends obf_O_8_1034
   {
      
      public var user:String;
      
      public var password:String;
      
      public var ssKey:int = Math.random() * 10000;
      
      public function LoginRequest()
      {
         super(CommandCodeLogin.ACCOUNT_LOGIN_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["user:string","password:string","ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 61457;
      }
   }
}

