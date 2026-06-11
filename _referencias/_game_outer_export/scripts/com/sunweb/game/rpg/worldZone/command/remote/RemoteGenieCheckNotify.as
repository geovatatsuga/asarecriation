package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.genie.GenieBriefInfo;
   
   public class RemoteGenieCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var usingGenie:GenieBriefInfo = null;
      
      public function RemoteGenieCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_GENIE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","usingGenie:com.sunweb.game.rpg.genie.GenieBriefInfo"];
      }
   }
}

