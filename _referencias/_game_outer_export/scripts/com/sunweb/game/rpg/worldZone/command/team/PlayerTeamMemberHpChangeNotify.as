package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTeamMemberHpChangeNotify extends obf_O_8_1034
   {
      
      public var memberName:String;
      
      public var hp:Number;
      
      public var hpMax:Number;
      
      public function PlayerTeamMemberHpChangeNotify()
      {
         super(CommandCodeTeam.PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["memberName:string","hp:double","hpMax:double"];
      }
   }
}

