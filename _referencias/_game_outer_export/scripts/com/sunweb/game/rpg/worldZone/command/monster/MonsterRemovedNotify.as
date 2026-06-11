package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MonsterRemovedNotify extends obf_O_8_1034
   {
      
      public var monsterId:String;
      
      public function MonsterRemovedNotify()
      {
         super(CommandCodeMonster.MONSTER_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["monsterId:string"];
      }
   }
}

