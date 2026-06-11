package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class MonsterUseSkillNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var monsterId:String;
      
      public var monsterCode:String;
      
      public var x:int;
      
      public var y:int;
      
      public var skillCode:String;
      
      public var skillLevel:int = 1;
      
      public var targetId:String;
      
      public var targetPoint:MapPoint;
      
      public var singTime:int;
      
      public var castTime:int;
      
      public function MonsterUseSkillNotify()
      {
         super(CommandCodeMonster.MONSTER_USE_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","monsterId:string","monsterCode:string","x:short","y:short","skillCode:string","skillLevel:byte","targetId:string","targetPoint:com.sunweb.game.rpg.world.map.MapPoint","singTime:ushort","castTime:ushort"];
      }
   }
}

