package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyInventSkillRequest extends obf_O_8_1034
   {
      
      public var skillCode:String;
      
      public function PlayerFamilyInventSkillRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_INVENT_SKILL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillCode:string"];
      }
   }
}

