package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDismissTeamRequest extends obf_O_8_1034
   {
      
      public function PlayerDismissTeamRequest()
      {
         super(CommandCodeTeam.PLAYER_DISMISS_TEAM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

