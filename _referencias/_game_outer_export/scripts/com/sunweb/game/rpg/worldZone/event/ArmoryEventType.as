package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.armory.CommandCodeArmory;
   
   public class ArmoryEventType
   {
      
      public static const ARMORY_GRID_KIND_IS_MISS:String = CommandCodeArmory.ARMORY_GRID_KIND_IS_MISS.toString(16);
      
      public static const PLAYER_ARMORY_UPGRADE_ANSWER:String = CommandCodeArmory.PLAYER_ARMORY_UPGRADE_ANSWER.toString(16);
      
      public static const PLAYER_ARMORY_PROPERTY_NOTIFY:String = CommandCodeArmory.PLAYER_ARMORY_PROPERTY_NOTIFY.toString(16);
      
      public static const PLAYER_ARMORY_UPGRADE_NOTIFY:String = CommandCodeArmory.PLAYER_ARMORY_UPGRADE_NOTIFY.toString(16);
      
      public function ArmoryEventType()
      {
         super();
      }
   }
}

