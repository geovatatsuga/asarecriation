package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.activityBox.CommandTermConfig;
   
   public class activityBoxEventType
   {
      
      public static const CONSUME_RANK_NOTIFY:String = CommandTermConfig.CONSUME_RANK_NOTIFY.toString(16);
      
      public static const CONSUME_RANK_ITEM_NOTIFY:String = CommandTermConfig.CONSUME_RANK_ITEM_NOTIFY.toString(16);
      
      public function activityBoxEventType()
      {
         super();
      }
   }
}

