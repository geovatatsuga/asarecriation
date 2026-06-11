package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.constellation.CommandCodePlayerConstellation;
   
   public class ConstellationEventType
   {
      
      public static const SET_PLAYER_CONSTELLATION_ANSWER:String = CommandCodePlayerConstellation.SET_PLAYER_CONSTELLATION_ANSWER.toString(16);
      
      public static const RESET_PLAYER_CONSTELLATION_NOTIFY:String = CommandCodePlayerConstellation.RESET_PLAYER_CONSTELLATION_NOTIFY.toString(16);
      
      public static const LUCK_CHANGE_CONSTELLATION_ANSWER:String = CommandCodePlayerConstellation.LUCK_CHANGE_CONSTELLATION_ANSWER.toString(16);
      
      public static const LUCK_GET_CONSTELLATION_ANSWER:String = CommandCodePlayerConstellation.LUCK_GET_CONSTELLATION_ANSWER.toString(16);
      
      public static const UP_PLAYER_CONSTELLATION_ANSWER:String = CommandCodePlayerConstellation.UP_PLAYER_CONSTELLATION_ANSWER.toString(16);
      
      public static const CONSTELLATION_LUCK_NOTIFY:String = CommandCodePlayerConstellation.CONSTELLATION_LUCK_NOTIFY.toString(16);
      
      public static const CONSTELLATION_TASK_NOTIFY:String = CommandCodePlayerConstellation.CONSTELLATION_TASK_NOTIFY.toString(16);
      
      public function ConstellationEventType()
      {
         super();
      }
   }
}

