package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamItemModeCheckNotify extends obf_O_8_1034
   {
      
      public var teamItemMode:int;
      
      public var teamItemRollingRank:int;
      
      public function PlayerTeamItemModeCheckNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["teamItemMode:byte","teamItemRollingRank:byte"];
      }
   }
}

