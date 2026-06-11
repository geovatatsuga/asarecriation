package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInviteTeamRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerInviteTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_INVITE_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

