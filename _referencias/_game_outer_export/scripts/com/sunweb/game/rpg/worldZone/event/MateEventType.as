package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.mate.CommandCodePlayerMate;
   
   public class MateEventType
   {
      
      public static const PLAYER_MATE_RELATION_CHECK_NOTIFY:String = CommandCodePlayerMate.PLAYER_MATE_RELATION_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_MATE_VAR_CHANGE_NOTIFY:String = CommandCodePlayerMate.PLAYER_MATE_VAR_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_MATE_VAR_CLEAR_NOTIFY:String = CommandCodePlayerMate.PLAYER_MATE_VAR_CLEAR_NOTIFY.toString(16);
      
      public function MateEventType()
      {
         super();
      }
   }
}

