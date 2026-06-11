package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSkillInterruptedNotify extends obf_O_8_1034
   {
      
      public var skillSn:int;
      
      public var cancelCD:Boolean;
      
      public function PlayerSkillInterruptedNotify()
      {
         super(CommandCodePlayer.PLAYER_SKILL_INTERRUPTED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillSn:ushort","cancelCD:boolean"];
      }
   }
}

