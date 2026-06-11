package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   
   public class PlayerTeamMemberCheckNotify extends obf_O_8_1034
   {
      
      public var member:TeamMemberInfo;
      
      public function PlayerTeamMemberCheckNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_MEMBER_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["member:com.sunweb.game.rpg.team.TeamMemberInfo"];
      }
   }
}

