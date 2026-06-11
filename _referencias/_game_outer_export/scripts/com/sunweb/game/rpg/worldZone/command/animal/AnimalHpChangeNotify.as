package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AnimalHpChangeNotify extends obf_O_8_1034
   {
      
      public var animalOwnerName:String;
      
      public var hpChanged:Number;
      
      public var hpCurrent:Number;
      
      public var hpMax:Number;
      
      public var skillCode:String;
      
      public var isCriticalStrike:Boolean;
      
      public function AnimalHpChangeNotify()
      {
         super(CommandCodePlayerAnimal.ANIMAL_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["animalOwnerName:string","hpChanged:double","hpCurrent:double","hpMax:double","skillCode:string","isCriticalStrike:boolean"];
      }
   }
}

