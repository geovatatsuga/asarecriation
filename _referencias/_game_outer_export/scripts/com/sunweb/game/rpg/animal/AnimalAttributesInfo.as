package com.sunweb.game.rpg.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class AnimalAttributesInfo extends obf_2_M_853
   {
      
      public var strength:int;
      
      public var wisdom:int;
      
      public var agility:int;
      
      public var vitality:int;
      
      public var hp:Number;
      
      public var hpMax:Number;
      
      public var physicalAttack:Number;
      
      public var magicAttack:Number;
      
      public var physicalDefense:int;
      
      public var physicalReduceRate:Number;
      
      public var magicDefense:int;
      
      public var magicReduceRate:Number;
      
      public var hitValue:int;
      
      public var hitRate:Number;
      
      public var critValue:int;
      
      public var critRate:Number;
      
      public var critDamageMul:Number;
      
      public var dodgeValue:int;
      
      public var dodgeRate:Number;
      
      public var castTimeModifier:Number;
      
      public var singTimeModifier:Number;
      
      public var skillArray:Array;
      
      public function AnimalAttributesInfo()
      {
         super();
      }
      
      public function get hpPercent() : Number
      {
         return this.hp / this.hpMax * 100;
      }
      
      override public function getFieldList() : Array
      {
         return ["strength:int","wisdom:int","agility:int","vitality:int","hp:double","hpMax:double","physicalAttack:double","magicAttack:double","physicalDefense:vint","physicalReduceRate:float","magicDefense:vint","magicReduceRate:float","hitValue:int","hitRate:float","critValue:int","critRate:float","critDamageMul:float","dodgeValue:int","dodgeRate:float","castTimeModifier:float","singTimeModifier:float","skillArray:array(string)"];
      }
   }
}

