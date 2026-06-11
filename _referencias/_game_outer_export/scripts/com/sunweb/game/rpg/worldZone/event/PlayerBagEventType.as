package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.playerBag.CommandCodeBag;
   
   public class PlayerBagEventType
   {
      
      public static const PLAYER_BAG_CHECK_NOTIFY:String = CommandCodeBag.PLAYER_BAG_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_BAG_CAPACITY_CHANGE_NOTIFY:String = CommandCodeBag.PLAYER_BAG_CAPACITY_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_ITEM_USED_NOTIFY:String = CommandCodeBag.PLAYER_ITEM_USED_NOTIFY.toString(16);
      
      public static const PLAYER_ITEM_ADDED_NOTIFY:String = CommandCodeBag.PLAYER_ITEM_ADDED_NOTIFY.toString(16);
      
      public static const PLAYER_ITEM_CD_CHECK_NOTIFY:String = CommandCodeBag.PLAYER_ITEM_CD_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_VIEW_ITEM_ANSWER:String = CommandCodeBag.PLAYER_VIEW_ITEM_ANSWER.toString(16);
      
      public function PlayerBagEventType()
      {
         super();
      }
   }
}

