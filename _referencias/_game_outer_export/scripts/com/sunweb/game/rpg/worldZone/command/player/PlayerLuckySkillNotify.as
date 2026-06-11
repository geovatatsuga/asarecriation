package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLuckySkillNotify extends obf_O_8_1034
   {
      
      public var skillSn:int;
      
      public function PlayerLuckySkillNotify()
      {
         super(CommandCodePlayer.PLAYER_LUCKY_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillSn:ushort"];
      }
   }
}

