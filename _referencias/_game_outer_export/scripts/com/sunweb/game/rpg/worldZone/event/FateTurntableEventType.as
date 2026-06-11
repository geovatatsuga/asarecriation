package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.CommandCodeFateTurntable;
   
   public class FateTurntableEventType
   {
      
      public static const START_TURNTABLE_ANSWER:String = CommandCodeFateTurntable.START_TURNTABLE_ANSWER.toString(16);
      
      public static const FATE_UP_LEVEL_ANSWER:String = CommandCodeFateTurntable.FATE_UP_LEVEL_ANSWER.toString(16);
      
      public static const FATE_TURNTABLE_INFO_NOTIFY:String = CommandCodeFateTurntable.FATE_TURNTABLE_INFO_NOTIFY.toString(16);
      
      public static const FATE_TURNTABLE_VALUE_NOTIFY:String = CommandCodeFateTurntable.FATE_TURNTABLE_VALUE_NOTIFY.toString(16);
      
      public function FateTurntableEventType()
      {
         super();
      }
   }
}

