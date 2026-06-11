package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyInventSkillNotify extends obf_O_8_1034
   {
      
      public var familySkills:Object;
      
      public function PlayerFamilyInventSkillNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_INVENT_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["familySkills:map(string,byte)"];
      }
   }
}

