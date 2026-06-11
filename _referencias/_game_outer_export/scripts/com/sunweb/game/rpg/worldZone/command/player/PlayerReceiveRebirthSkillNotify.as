package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveRebirthSkillNotify extends obf_O_8_1034
   {
      
      public var skillCasterName:String;
      
      public var skillCode:String;
      
      public var skillLevel:int;
      
      public function PlayerReceiveRebirthSkillNotify()
      {
         super(CommandCodePlayer.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillCasterName:string","skillCode:string","skillLevel:byte"];
      }
   }
}

