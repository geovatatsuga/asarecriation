package com.sunweb.game.rpg.worldZone
{
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public dynamic class WorldEventType
   {
      
      public static const LOGIN_WORLD_ANSWER:String = CommandCodeWorld.WORLD_LOGIN_ANSWER.toString(16);
      
      public static const LOGOUT_WORLD_ANSWER:String = CommandCodeWorld.WORLD_LOGOUT_ANSWER.toString(16);
      
      public static const WORLD_PVE_MAPS_NOTIFY:String = CommandCodeWorld.WORLD_PVE_MAPS_NOTIFY.toString(16);
      
      public function WorldEventType()
      {
         super();
      }
   }
}

