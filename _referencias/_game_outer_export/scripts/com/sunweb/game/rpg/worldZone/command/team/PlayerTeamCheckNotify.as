package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamCheckNotify extends obf_O_8_1034
   {
      
      public var teamName:String;
      
      public var leader:String;
      
      public var members:Array;
      
      public function PlayerTeamCheckNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamName:string","leader:string","members:array(com.sunweb.game.rpg.team.TeamMemberInfo)"];
      }
   }
}

