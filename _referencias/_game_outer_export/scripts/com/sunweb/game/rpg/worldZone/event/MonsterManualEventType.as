package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.monsterManual.CommandCodeMonsterManual;
   
   public class MonsterManualEventType
   {
      
      public static const MANUAL_VIEW_ANSWER:String = CommandCodeMonsterManual.MANUAL_VIEW_ANSWER.toString(16);
      
      public static const MANUAL_ABSORB_ANSWER:String = CommandCodeMonsterManual.MANUAL_ABSORB_ANSWER.toString(16);
      
      public function MonsterManualEventType()
      {
         super();
      }
   }
}

