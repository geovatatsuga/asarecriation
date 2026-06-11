package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLearnedSkillsCheckNotify extends obf_O_8_1034
   {
      
      public var skillKind:int;
      
      public var learnedSkills:Object;
      
      public function PlayerLearnedSkillsCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_LEARNED_SKILLS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillKind:byte","learnedSkills:map(string,byte)"];
      }
   }
}

