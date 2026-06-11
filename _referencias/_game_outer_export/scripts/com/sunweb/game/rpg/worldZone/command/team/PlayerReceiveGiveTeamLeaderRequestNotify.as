package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveGiveTeamLeaderRequestNotify extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public function PlayerReceiveGiveTeamLeaderRequestNotify()
      {
         super(CommandCodeTeam.PLAYER_RECEIVE_GIVE_TEAM_LEADER_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string"];
      }
   }
}

