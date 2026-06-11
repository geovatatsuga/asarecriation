package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCancelSkillRequest extends obf_O_8_1034
   {
      
      public var skillSn:int;
      
      public function PlayerCancelSkillRequest()
      {
         super(CommandCodePlayer.PLAYER_CANCEL_SKILL_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillSn:ushort"];
      }
   }
}

