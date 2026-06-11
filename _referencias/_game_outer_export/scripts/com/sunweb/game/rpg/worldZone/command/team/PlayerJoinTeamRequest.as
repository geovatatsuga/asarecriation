package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerJoinTeamRequest extends obf_O_8_1034
   {
      
      public var teamName:String;
      
      public function PlayerJoinTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_JOIN_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamName:string"];
      }
   }
}

