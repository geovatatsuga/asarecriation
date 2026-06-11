package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.monster.CommandCodeMonster;
   
   public class MonsterEventType
   {
      
      public static const MONSTER_BORN_NOTIFY:String = CommandCodeMonster.MONSTER_BORN_NOTIFY.toString(16);
      
      public static const MONSTER_DIE_NOTIFY:String = CommandCodeMonster.MONSTER_DIED_NOTIFY.toString(16);
      
      public static const MONSTER_MOVE_NOTIFY:String = CommandCodeMonster.MONSTER_MOVE_NOTIFY.toString(16);
      
      public static const MONSTER_POSITION_CHECK_NOTIFY:String = CommandCodeMonster.MONSTER_POSITION_CHECK_NOTIFY.toString(16);
      
      public static const MONSTER_USE_SKILL_NOTIFY:String = CommandCodeMonster.MONSTER_USE_SKILL_NOTIFY.toString(16);
      
      public static const MONSTER_HP_CHANGE_NOTIFY:String = CommandCodeMonster.MONSTER_HP_CHANGE_NOTIFY.toString(16);
      
      public static const MONSTER_BUFF_CHANGE_NOTIFY:String = CommandCodeMonster.MONSTER_BUFF_CHANGE_NOTIFY.toString(16);
      
      public static const MONSTER_REMOVED_NOTIFY:String = CommandCodeMonster.MONSTER_REMOVED_NOTIFY.toString(16);
      
      public function MonsterEventType()
      {
         super();
      }
   }
}

