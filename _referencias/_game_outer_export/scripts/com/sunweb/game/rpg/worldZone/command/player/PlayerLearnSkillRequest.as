package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLearnSkillRequest extends obf_O_8_1034
   {
      
      public var skillKind:int;
      
      public var skillCode:String;
      
      public var ssKey:int = Math.random() * 10000;
      
      public function PlayerLearnSkillRequest()
      {
         super(CommandCodePlayer.PLAYER_LEARN_SKILL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillKind:byte","skillCode:string","ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 62097;
      }
   }
}

