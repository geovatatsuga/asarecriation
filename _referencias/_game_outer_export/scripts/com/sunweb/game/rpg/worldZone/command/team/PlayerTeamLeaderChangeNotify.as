package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamLeaderChangeNotify extends obf_O_8_1034
   {
      
      public var leaderName:String;
      
      public function PlayerTeamLeaderChangeNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_LEADER_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["leaderName:string"];
      }
   }
}

