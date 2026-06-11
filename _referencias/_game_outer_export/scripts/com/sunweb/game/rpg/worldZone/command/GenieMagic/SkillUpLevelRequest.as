package com.sunweb.game.rpg.worldZone.command.GenieMagic
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SkillUpLevelRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var attrEnum:int;
      
      public var skillId:String;
      
      public function SkillUpLevelRequest()
      {
         super(CommandCodePlayerGenieMagic.SKILL_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","attrEnum:ushort","skillId:string"];
      }
   }
}

