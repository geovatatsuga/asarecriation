package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerKickTeamMemberRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerKickTeamMemberRequest()
      {
         super(CommandCodeTeam.PLAYER_KICK_TEAM_MEMBER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

