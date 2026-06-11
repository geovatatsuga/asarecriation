package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LogoutRequest extends obf_O_8_1034
   {
      
      public function LogoutRequest()
      {
         super(CommandCodeLogin.ACCOUNT_LOGOUT_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

