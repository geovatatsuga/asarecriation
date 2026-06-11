package com.sunweb.game.rpg.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class AnimalInfo extends obf_2_M_853
   {
      
      public var animalOwnerName:String;
      
      public var level:int;
      
      public var id:String;
      
      public var animalCode:String;
      
      public var type:int;
      
      public var x:int;
      
      public var y:int;
      
      public var walkSpeed:int;
      
      public var buffs:Array;
      
      public var actionMode:int;
      
      public var animalAtr:AnimalAttributesInfo;
      
      public var callSkillCode:String;
      
      public function AnimalInfo()
      {
         super();
      }
      
      public function get mpPercent() : Number
      {
         return 100;
      }
      
      override public function getFieldList() : Array
      {
         return ["animalOwnerName:string","id:string","animalCode:string","type:ubyte","level:ubyte","x:ushort","y:ushort","walkSpeed:short","buffs:array(com.sunweb.game.rpg.buff.BuffInfo)","actionMode:ubyte","animalAtr:com.sunweb.game.rpg.animal.AnimalAttributesInfo","callSkillCode:string"];
      }
   }
}

