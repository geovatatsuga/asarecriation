package com.sunweb.game.rpg.loginZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ServerListAnswer extends obf_O_8_1034
   {
      
      public var serverList:Array;
      
      public var selectedServer:String;
      
      public function ServerListAnswer()
      {
         super(CommandCodeLogin.SERVER_LIST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["serverList:array(com.sunweb.game.rpg.loginZone.info.ServerInfo)","selectedServer:string"];
      }
   }
}

