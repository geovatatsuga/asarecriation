package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamRollItemsCheckNotify extends obf_O_8_1034
   {
      
      public var rollItems:Array;
      
      public function PlayerTeamRollItemsCheckNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rollItems:array(com.sunweb.game.rpg.team.TeamRollItemInfo)"];
      }
   }
}

