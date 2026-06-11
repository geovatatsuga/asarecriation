package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ServerListRequest extends obf_O_8_1034
   {
      
      public var ssKey:int = Math.random() * 10000;
      
      public function ServerListRequest()
      {
         super(CommandCodeLogin.SERVER_LIST_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 61463;
      }
   }
}

