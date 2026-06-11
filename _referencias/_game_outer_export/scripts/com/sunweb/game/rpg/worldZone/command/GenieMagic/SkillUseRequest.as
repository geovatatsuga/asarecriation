package com.sunweb.game.rpg.worldZone.command.GenieMagic
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SkillUseRequest extends obf_O_8_1034
   {
      
      public var skillId:String;
      
      public function SkillUseRequest()
      {
         super(CommandCodePlayerGenieMagic.SKILL_USE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillId:string"];
      }
   }
}

