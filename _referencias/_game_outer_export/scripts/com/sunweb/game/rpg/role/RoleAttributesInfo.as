package com.sunweb.game.rpg.role
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RoleAttributesInfo extends obf_2_M_853
   {
      
      public var strength:int;
      
      public var wisdom:int;
      
      public var agility:int;
      
      public var vitality:int;
      
      public var hp:Number;
      
      public var hpMax:Number;
      
      public var mp:int;
      
      public var mpMax:int;
      
      public var sp:int;
      
      public var spMax:int;
      
      public var xp:int;
      
      public var xpMax:int;
      
      public var physicalAttack:Number;
      
      public var physicalDefense:int;
      
      public var physicalReduceRate:Number;
      
      public var magicAttack:Number;
      
      public var magicDefense:int;
      
      public var magicReduceRate:Number;
      
      public var hitValue:int;
      
      public var hitRate:Number;
      
      public var dodgeValue:int;
      
      public var dodgeRate:Number;
      
      public var critValue:int;
      
      public var critRate:Number;
      
      public var luckyAttack:int;
      
      public var luckyDefense:int;
      
      public var critDamageMul:Number;
      
      public var toughValue:int;
      
      public var pierceAttack:int;
      
      public var pierceDefense:int;
      
      public var singTimeModifier:Number = 1;
      
      public var castTimeModifier:Number = 1;
      
      public var singTimeReduceMS:int;
      
      public var walkSpeed:int;
      
      public var hpHealValue:int;
      
      public var mpHealValue:int;
      
      public var spHealValue:int;
      
      public var cureValue:int;
      
      public var element1Attack:int;
      
      public var element2Attack:int;
      
      public var element3Attack:int;
      
      public var element4Attack:int;
      
      public var element5Attack:int;
      
      public var element1Defense:int;
      
      public var element2Defense:int;
      
      public var element3Defense:int;
      
      public var element4Defense:int;
      
      public var element5Defense:int;
      
      public var lot:int;
      
      public var loa:int;
      
      public var loh:int;
      
      public function RoleAttributesInfo()
      {
         super();
      }
      
      public function get hpPercent() : int
      {
         return this.hp / this.hpMax * 100;
      }
      
      public function get mpPercent() : int
      {
         return this.mp / this.mpMax * 100;
      }
      
      override public function getFieldList() : Array
      {
         return ["strength:int","wisdom:int","agility:int","vitality:int","hp:double","hpMax:double","mp:int","mpMax:int","sp:int","spMax:int","xp:int","xpMax:int","physicalAttack:double","physicalDefense:int","physicalReduceRate:float","magicAttack:double","magicDefense:int","magicReduceRate:float","hitValue:int","hitRate:float","dodgeValue:int","dodgeRate:float","critValue:int","critRate:float","luckyAttack:int","luckyDefense:int","critDamageMul:float","toughValue:int","pierceAttack:int","pierceDefense:int","singTimeModifier:float","castTimeModifier:float","singTimeReduceMS:int","walkSpeed:int","hpHealValue:int","mpHealValue:int","spHealValue:int","cureValue:int","element1Attack:int","element2Attack:int","element3Attack:int","element4Attack:int","element5Attack:int","element1Defense:int","element2Defense:int","element3Defense:int","element4Defense:int","element5Defense:int","lot:int","loa:int","loh:int"];
      }
   }
}

