package com.sunweb.game.rpg.worldZone.command.GenieMagic
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SkillLevelNotify extends obf_O_8_1034
   {
      
      public var bloodSkills:Object;
      
      public var talentLevel:int;
      
      public var magicSkills:Object;
      
      public function SkillLevelNotify()
      {
         super(CommandCodePlayerGenieMagic.SKILL_LEVEL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bloodSkills:map(ushort,ubyte)","talentLevel:ubyte","magicSkills:map(string,ubyte)"];
      }
   }
}

