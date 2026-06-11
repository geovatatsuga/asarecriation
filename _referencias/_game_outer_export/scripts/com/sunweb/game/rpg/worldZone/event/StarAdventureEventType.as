package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.starAdventure.CommandCodePlayerStars;
   
   public class StarAdventureEventType
   {
      
      public static const PLAYER_STARS_INFO_NOTIFY:String = CommandCodePlayerStars.PLAYER_STARS_INFO_NOTIFY.toString(16);
      
      public static const PLAYER_STARS_ADVENTURE_ANSWER:String = CommandCodePlayerStars.PLAYER_STARS_ADVENTURE_ANSWER.toString(16);
      
      public function StarAdventureEventType()
      {
         super();
      }
   }
}

