package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.totem.CommandCodePlayerTotem;
   
   public class TotemEventType
   {
      
      public static const TOTEM_UP_LEVEL_STAGE_ANSWER:String = CommandCodePlayerTotem.TOTEM_UP_LEVEL_STAGE_ANSWER.toString(16);
      
      public static const TOTEM_INFO_NOTIFY:String = CommandCodePlayerTotem.TOTEM_INFO_NOTIFY.toString(16);
      
      public function TotemEventType()
      {
         super();
      }
   }
}

