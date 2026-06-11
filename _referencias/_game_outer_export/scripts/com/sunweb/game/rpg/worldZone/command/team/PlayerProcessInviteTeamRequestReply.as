package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessInviteTeamRequestReply extends obf_O_8_1034
   {
      
      public var teamName:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessInviteTeamRequestReply()
      {
         super(CommandCodeTeam.PLAYER_PROCESS_INVITE_TEAM_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamName:string","isAgreed:boolean"];
      }
   }
}

