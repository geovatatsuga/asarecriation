package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class AnimalUseSkillNotify extends obf_O_8_1034
   {
      
      public var animalOwnerName:String;
      
      public var skillCode:String;
      
      public var targetId:String;
      
      public var targetPoint:MapPoint;
      
      public var singTime:int;
      
      public var castTime:int;
      
      public function AnimalUseSkillNotify()
      {
         super(CommandCodePlayerAnimal.ANIMAL_USE_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["animalOwnerName:string","skillCode:string","targetId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint","singTime:ushort","castTime:ushort"];
      }
   }
}

