package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerJoinTeamAnswer extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerJoinTeamAnswer()
      {
         super(CommandCodeTeam.PLAYER_JOIN_TEAM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string","isAgreed:boolean"];
      }
   }
}

