package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFarmSkillLevelUpNotify extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var newLevel:int;
      
      public function PlayerFarmSkillLevelUpNotify()
      {
         super(CommandCodePlayer.PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","newLevel:ubyte"];
      }
   }
}

