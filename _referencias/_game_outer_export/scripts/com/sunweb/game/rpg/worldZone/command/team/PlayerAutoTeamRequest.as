package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAutoTeamRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerAutoTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_AUTO_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

