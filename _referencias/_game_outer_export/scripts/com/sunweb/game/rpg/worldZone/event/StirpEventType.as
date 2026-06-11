package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.stirp.CommandCodeStirp;
   
   public class StirpEventType
   {
      
      public static const PLAYER_STIRP_LVUP_ANSWER:String = CommandCodeStirp.PLAYER_STIRP_LVUP_ANSWER.toString(16);
      
      public static const PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY:String = CommandCodeStirp.PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY.toString(16);
      
      public function StirpEventType()
      {
         super();
      }
   }
}

