package com.sunweb.game.rpg.worldZone.command.GenieMagic
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SkillUseNotify extends obf_O_8_1034
   {
      
      public var usedSkill:Object;
      
      public var items:Object;
      
      public function SkillUseNotify()
      {
         super(CommandCodePlayerGenieMagic.SKILL_USE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["usedSkill:map(string,ubyte)","items:map(string,ubyte)"];
      }
   }
}

