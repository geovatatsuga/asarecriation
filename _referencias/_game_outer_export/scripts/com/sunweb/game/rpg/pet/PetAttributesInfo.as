package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.utils.JSONUtil;
   
   public class PetAttributesInfo extends obf_2_M_853
   {
      
      public var strength:int;
      
      public var wisdom:int;
      
      public var agility:int;
      
      public var vitality:int;
      
      public var hpMax:int;
      
      public var mpMax:int;
      
      public var physicalAttack:Number;
      
      public var magicAttack:Number;
      
      public var hitValue:int;
      
      public var hitRate:Number;
      
      public var critValue:int;
      
      public var critRate:Number;
      
      public var strengthApt:int;
      
      public var wisdomApt:int;
      
      public var agilityApt:int;
      
      public var vitalityApt:int;
      
      public var subdueMul:Number = JSONUtil.getNumber(obf_c_4686.config,["defaultValue","subdueMul"]);
      
      public var damageAbsorbRatio:Number = 0;
      
      public var damageAbsorbMul:Number = 1;
      
      public var levelUpAttrPt:Number;
      
      public var growthRate:int;
      
      public function PetAttributesInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["strength:int","wisdom:int","agility:int","vitality:int","hpMax:int","mpMax:int","physicalAttack:double","magicAttack:double","hitValue:int","hitRate:float","critValue:int","critRate:float","strengthApt:int","wisdomApt:int","agilityApt:int","vitalityApt:int","subdueMul:float","damageAbsorbRatio:float","damageAbsorbMul:float","levelUpAttrPt:float","growthRate:short"];
      }
   }
}

