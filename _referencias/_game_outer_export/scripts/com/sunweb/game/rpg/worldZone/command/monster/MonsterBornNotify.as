package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.info.MonsterInfo;
   
   public class MonsterBornNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var monster:MonsterInfo;
      
      public function MonsterBornNotify()
      {
         super(CommandCodeMonster.MONSTER_BORN_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","monster:com.sunweb.game.rpg.world.info.MonsterInfo"];
      }
   }
}

