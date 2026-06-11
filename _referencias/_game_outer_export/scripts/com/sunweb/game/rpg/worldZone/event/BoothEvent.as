package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.booth.CommandCodePlayerBooth;
   
   public class BoothEvent
   {
      
      public static const BOOTH_CHECK_NOTIFY:String = CommandCodePlayerBooth.BOOTH_CHECK_NOTIFY.toString(16);
      
      public static const BOOTH_ITEM_SOLD_NOTIFY:String = CommandCodePlayerBooth.BOOTH_ITEM_SOLD_NOTIFY.toString(16);
      
      public static const BOOTH_VISIT_ANSWER:String = CommandCodePlayerBooth.BOOTH_VISIT_ANSWER.toString(16);
      
      public static const BOOTH_ITEM_PURCHASED_NOTIFY:String = CommandCodePlayerBooth.BOOTH_ITEM_PURCHASED_NOTIFY.toString(16);
      
      public function BoothEvent()
      {
         super();
      }
   }
}

