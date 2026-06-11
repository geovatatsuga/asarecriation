package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteTeamCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var teamName:String;
      
      public var isTeamLeader:Boolean;
      
      public function RemoteTeamCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_TEAM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","teamName:string","isTeamLeader:boolean"];
      }
   }
}

