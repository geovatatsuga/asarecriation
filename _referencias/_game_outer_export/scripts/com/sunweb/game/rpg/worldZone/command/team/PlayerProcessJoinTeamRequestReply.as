package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessJoinTeamRequestReply extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessJoinTeamRequestReply()
      {
         super(CommandCodeTeam.PLAYER_PROCESS_JOIN_TEAM_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","isAgreed:boolean"];
      }
   }
}

