package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.dragon.CommandCodeDragon;
   
   public class DragonEventType
   {
      
      public static const PLAYER_DRAGON_UPGRADE_ANSWER:String = CommandCodeDragon.PLAYER_DRAGON_UPGRADE_ANSWER.toString(16);
      
      public static const PLAYER_DRAGON_CHECK_NOTIFY:String = CommandCodeDragon.PLAYER_DRAGON_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_BUY_UP_CHANCE_ANSWER:String = CommandCodeDragon.PLAYER_BUY_UP_CHANCE_ANSWER.toString(16);
      
      public function DragonEventType()
      {
         super();
      }
   }
}

