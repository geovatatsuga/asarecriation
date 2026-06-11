package com.sunweb.game.rpg.worldZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldLoginRequest extends obf_O_8_1034
   {
      
      public var sessionId:String;
      
      public var serverId:String;
      
      public function WorldLoginRequest()
      {
         super(CommandCodeWorld.WORLD_LOGIN_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["sessionId:string","serverId:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 41115;
      }
   }
}

