package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerQuitTeamRequest extends obf_O_8_1034
   {
      
      public function PlayerQuitTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_QUIT_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

