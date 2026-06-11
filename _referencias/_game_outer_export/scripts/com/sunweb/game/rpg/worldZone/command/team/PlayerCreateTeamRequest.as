package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCreateTeamRequest extends obf_O_8_1034
   {
      
      public var teamName:String;
      
      public var invitePlayers:Array;
      
      public function PlayerCreateTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_CREATE_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamName:string","invitePlayers:array(string)"];
      }
   }
}

