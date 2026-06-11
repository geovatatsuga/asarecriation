package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class PetSkillSlot extends obf_2_M_853
   {
      
      public var skillCode:String;
      
      public var skillLevel:int;
      
      public function PetSkillSlot()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["skillCode:string","skillLevel:byte"];
      }
   }
}

