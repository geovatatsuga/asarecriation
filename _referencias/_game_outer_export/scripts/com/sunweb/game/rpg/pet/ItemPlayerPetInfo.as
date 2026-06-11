package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.utils.JSONUtil;
   
   public class ItemPlayerPetInfo extends obf_2_M_853
   {
      
      public var baseAttributes:PetAttributesInfo;
      
      public var fusionAttributes:PetAttributesInfo;
      
      public var cultivateAttributes:PetAttributesInfo;
      
      public var attributes:PetAttributesInfo;
      
      public var equipment:Array;
      
      public var name:String;
      
      public var sex:int;
      
      public var generation:int = 1;
      
      public var level:int = 1;
      
      public var exp:int;
      
      public var life:int;
      
      public var loyalty:int;
      
      public var enhanceLevel:int;
      
      public var openedSkillNum:int;
      
      public var learnedSkillList:Array;
      
      public var fateSkillList:Array;
      
      public var freeAttrPt:int;
      
      public var hp:int;
      
      public var mp:int;
      
      public var buffInfo:Array;
      
      public function ItemPlayerPetInfo()
      {
         super();
      }
      
      public function get hpPercent() : Number
      {
         return this.hp / JSONUtil.getNumber(this.attributes,["hpMax"]) * 100;
      }
      
      public function get mpPercent() : Number
      {
         return this.mp / JSONUtil.getNumber(this.attributes,["mpMax"]) * 100;
      }
      
      override public function getFieldList() : Array
      {
         return ["baseAttributes:com.sunweb.game.rpg.pet.PetAttributesInfo","fusionAttributes:com.sunweb.game.rpg.pet.PetAttributesInfo","cultivateAttributes:com.sunweb.game.rpg.pet.PetAttributesInfo","attributes:com.sunweb.game.rpg.pet.PetAttributesInfo","equipment:array(com.sunweb.game.rpg.equ.EquippedItemInfo)","name:string","sex:byte","generation:byte","level:short","exp:int","life:int","loyalty:short","enhanceLevel:byte","openedSkillNum:byte","learnedSkillList:array(com.sunweb.game.rpg.pet.PetSkillSlot)","fateSkillList:array(com.sunweb.game.rpg.pet.PetSkillSlot)","freeAttrPt:int","hp:int","mp:vint","buffInfo:array(com.sunweb.game.rpg.buff.BuffInfo)"];
      }
   }
}

