package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLearnedSkillNotify extends obf_O_8_1034
   {
      
      public var skillKind:int;
      
      public var skillCode:String;
      
      public var skillLevel:int;
      
      public function PlayerLearnedSkillNotify()
      {
         super(CommandCodePlayer.PLAYER_LEARNED_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillKind:byte","skillCode:string","skillLevel:byte"];
      }
   }
}

