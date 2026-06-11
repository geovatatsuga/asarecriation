package com.sunweb.game.rpg.loginZone.info
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ServerInfo extends obf_2_M_853
   {
      
      public var serverId:String;
      
      public var serverName:String;
      
      public var serverIP:String;
      
      public var serverPort:int;
      
      public var serverStatus:String;
      
      public function ServerInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["serverId:string","serverName:string","serverIP:string","serverPort:ushort","serverStatus:string"];
      }
   }
}

