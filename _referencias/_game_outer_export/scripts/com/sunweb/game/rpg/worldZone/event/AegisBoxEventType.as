package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisEventType;
   
   public class AegisBoxEventType
   {
      
      public static const PLAYER_AEGIS_NOTIFY:String = AegisEventType.PLAYER_AEGIS_NOTIFY.toString(16);
      
      public static const PLAYER_UP_LEVEL_ANSWER:String = AegisEventType.PLAYER_UP_LEVEL_ANSWER.toString(16);
      
      public static const PLAYER_UPDATE_ANSWER:String = AegisEventType.PLAYER_UPDATE_ANSWER.toString(16);
      
      public static const PLAYER_PRAY_ANSWER:String = AegisEventType.PLAYER_PRAY_ANSWER.toString(16);
      
      public function AegisBoxEventType()
      {
         super();
      }
   }
}

