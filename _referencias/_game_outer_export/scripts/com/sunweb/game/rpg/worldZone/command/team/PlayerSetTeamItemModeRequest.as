package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetTeamItemModeRequest extends obf_O_8_1034
   {
      
      public var teamItemMode:int;
      
      public var teamItemRollingRank:int;
      
      public function PlayerSetTeamItemModeRequest()
      {
         super(CommandCodeTeam.PLAYER_SET_TEAM_ITEM_MODE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamItemMode:byte","teamItemRollingRank:byte"];
      }
   }
}

