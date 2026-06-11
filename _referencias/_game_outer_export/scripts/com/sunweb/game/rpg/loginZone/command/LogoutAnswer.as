package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LogoutAnswer extends obf_O_8_1034
   {
      
      public var sessionId:String;
      
      public function LogoutAnswer()
      {
         super(CommandCodeLogin.ACCOUNT_LOGOUT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["sessionId:string"];
      }
   }
}

