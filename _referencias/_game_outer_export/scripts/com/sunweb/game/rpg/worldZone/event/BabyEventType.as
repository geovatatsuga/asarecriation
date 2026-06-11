package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.baby.CommandCodeBaby;
   
   public class BabyEventType
   {
      
      public static const PLAYER_BABY_EAT_ANSWER:String = CommandCodeBaby.PLAYER_BABY_EAT_ANSWER.toString(16);
      
      public static const PLAYER_BABY_STUDY_ANSWER:String = CommandCodeBaby.PLAYER_BABY_STUDY_ANSWER.toString(16);
      
      public static const PLAYER_BABY_BUY_ATTR_MAX_ANSWER:String = CommandCodeBaby.PLAYER_BABY_BUY_ATTR_MAX_ANSWER.toString(16);
      
      public static const PLAYER_BABY_TRAVEL_ANSWER:String = CommandCodeBaby.PLAYER_BABY_TRAVEL_ANSWER.toString(16);
      
      public static const PLAYER_BABY_BLOOD_UP_ANSWER:String = CommandCodeBaby.PLAYER_BABY_BLOOD_UP_ANSWER.toString(16);
      
      public static const PLAYER_BABY_INFO_NOTIFY:String = CommandCodeBaby.PLAYER_BABY_INFO_NOTIFY.toString(16);
      
      public static const PLAYER_BABY_LV_AT_NOTIFY:String = CommandCodeBaby.PLAYER_BABY_LV_AT_NOTIFY.toString(16);
      
      public static const PLAYER_BABY_FOOD_NOTIFY:String = CommandCodeBaby.PLAYER_BABY_FOOD_NOTIFY.toString(16);
      
      public function BabyEventType()
      {
         super();
      }
   }
}

