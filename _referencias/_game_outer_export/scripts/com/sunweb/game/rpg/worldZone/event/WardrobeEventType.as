package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.wardrobe.CommandCodeWardrobe;
   
   public class WardrobeEventType
   {
      
      public static const WARDRODE_UPLEVEL_ANSWER:String = CommandCodeWardrobe.WARDRODE_UPLEVEL_ANSWER.toString(16);
      
      public static const WARDRODE_ITEMS_NOYIFY:String = CommandCodeWardrobe.WARDRODE_ITEMS_NOYIFY.toString(16);
      
      public function WardrobeEventType()
      {
         super();
      }
   }
}

