package com.sunweb.game.rpg.worldZone.command.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PetForgetSkillRequest extends obf_O_8_1034
   {
      
      public var petId:String;
      
      public var skillCode:String;
      
      public function PetForgetSkillRequest()
      {
         super(CommandCodePlayerPet.PET_FORGET_SKILL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","skillCode:string"];
      }
   }
}

