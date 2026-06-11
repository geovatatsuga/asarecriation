package com.sunweb.game.rpg.role
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class SoulAttr extends obf_2_M_853
   {
      
      public var physicalAttack:int;
      
      public var physicalDefense:int;
      
      public var magicAttack:int;
      
      public var magicDefense:int;
      
      public var hpMax:int;
      
      public var mpMax:int;
      
      public var hitValueAddValue:int;
      
      public var hitRateAddValue:Number;
      
      public var dodgeValueAddValue:int;
      
      public var dodgeRateAddValue:Number;
      
      public var critValueAddValue:int;
      
      public var critRateAddValue:Number;
      
      public function SoulAttr()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["physicalAttack:int","physicalDefense:int","magicAttack:int","magicDefense:int","hpMax:int","mpMax:int","hitValueAddValue:int","hitRateAddValue:float","dodgeValueAddValue:int","dodgeRateAddValue:float","critValueAddValue:int","critRateAddValue:float"];
      }
   }
}

