package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class WorldSystemEventType
   {
      
      public static const WORLD_PING_ECHO:String = CommandCodeWorld.WORLD_PING_ECHO.toString(16);
      
      public static const WORLD_TIME_CHECK_NOTIFY:String = CommandCodeWorld.WORLD_TIME_CHECK_NOTIFY.toString(16);
      
      public static const SYS_VAR_CHANGE_NOTIFY:String = CommandCodeWorld.SYS_VAR_CHANGE_NOTIFY.toString(16);
      
      public static const SYS_VAR_CLEAR_NOTIFY:String = CommandCodeWorld.SYS_VAR_CLEAR_NOTIFY.toString(16);
      
      public function WorldSystemEventType()
      {
         super();
      }
   }
}

