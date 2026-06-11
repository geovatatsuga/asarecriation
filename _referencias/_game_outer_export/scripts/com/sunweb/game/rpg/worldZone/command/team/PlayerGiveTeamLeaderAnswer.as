package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGiveTeamLeaderAnswer extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerGiveTeamLeaderAnswer()
      {
         super(CommandCodeTeam.PLAYER_GIVE_TEAM_LEADER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string","isAgreed:boolean"];
      }
   }
}

