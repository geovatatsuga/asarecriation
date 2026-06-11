package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.itemManual.CommandCodeItemManual;
   
   public class ItemManualEventType
   {
      
      public static const ITEM_MANUAL_INFO_NOTIFY:String = CommandCodeItemManual.ITEM_MANUAL_INFO_NOTIFY.toString(16);
      
      public static const ITEM_MANUAL_LOTTERY_ANSWER:String = CommandCodeItemManual.ITEM_MANUAL_LOTTERY_ANSWER.toString(16);
      
      public static const ITEM_MANUAL_SUCCESS_ANSWER:String = CommandCodeItemManual.ITEM_MANUAL_SUCCESS_ANSWER.toString(16);
      
      public static const ITEM_MANUAL_SUCCESS_AWARD_ANSWER:String = CommandCodeItemManual.ITEM_MANUAL_SUCCESS_AWARD_ANSWER.toString(16);
      
      public static const ITEM_MANUAL_STAR_VALUE_NOTIFY:String = CommandCodeItemManual.ITEM_MANUAL_STAR_VALUE_NOTIFY.toString(16);
      
      public static const ITEM_MANUAL_LIST_NOTIFY:String = CommandCodeItemManual.ITEM_MANUAL_LIST_NOTIFY.toString(16);
      
      public static const ITEM_MANUAL_SELL_ANSWER:String = CommandCodeItemManual.ITEM_MANUAL_SELL_ANSWER.toString(16);
      
      public function ItemManualEventType()
      {
         super();
      }
   }
}

