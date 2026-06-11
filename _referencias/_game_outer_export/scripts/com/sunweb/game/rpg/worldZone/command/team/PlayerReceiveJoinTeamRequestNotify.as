package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveJoinTeamRequestNotify extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public function PlayerReceiveJoinTeamRequestNotify()
      {
         super(CommandCodeTeam.PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string"];
      }
   }
}

