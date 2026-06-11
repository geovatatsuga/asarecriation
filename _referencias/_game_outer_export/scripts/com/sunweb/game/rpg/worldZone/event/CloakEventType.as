package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.cloak.CommandCodePlayerCloak;
   
   public class CloakEventType
   {
      
      public static const PLAYER_CLOAK_CHIP_NOTIFY:String = CommandCodePlayerCloak.PLAYER_CLOAK_CHIP_NOTIFY.toString(16);
      
      public static const PLAYER_CLOAK_GET_UP_ANSWER:String = CommandCodePlayerCloak.PLAYER_CLOAK_GET_UP_ANSWER.toString(16);
      
      public static const PLAYER_CLOAK_MELT_ANSWER:String = CommandCodePlayerCloak.PLAYER_CLOAK_MELT_ANSWER.toString(16);
      
      public static const PLAYER_CLOAK_GLYPH_NOTIFY:String = CommandCodePlayerCloak.PLAYER_CLOAK_GLYPH_NOTIFY.toString(16);
      
      public function CloakEventType()
      {
         super();
      }
   }
}

