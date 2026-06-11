package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGiveTeamLeaderRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerGiveTeamLeaderRequest()
      {
         super(CommandCodeTeam.PLAYER_GIVE_TEAM_LEADER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

