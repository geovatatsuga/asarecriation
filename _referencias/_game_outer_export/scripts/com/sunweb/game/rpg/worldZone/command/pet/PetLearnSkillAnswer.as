package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetLearnSkillAnswer extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var skillKind:int;
      
      public var skillCode:String;
      
      public var skillLevel:int;
      
      public function PetLearnSkillAnswer()
      {
         super(CommandCodePlayerPet.PET_LEARN_SKILL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","skillKind:byte","skillCode:string","skillLevel:byte"];
      }
   }
}

