package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.team.TeamRollItemInfo;
   
   public class PlayerTeamRollItemAddedNotify extends obf_O_8_1034
   {
      
      public var rollItemAdded:TeamRollItemInfo;
      
      public function PlayerTeamRollItemAddedNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rollItemAdded:com.sunweb.game.rpg.team.TeamRollItemInfo"];
      }
   }
}

