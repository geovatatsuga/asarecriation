package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.farm.CommandCodeFarm;
   
   public class FarmEventType
   {
      
      public static const FARM_CHECK_NOTIFY:String = CommandCodeFarm.FARM_CHECK_NOTIFY.toString(16);
      
      public static const FARM_EXP_CHANGE_NOTIFY:String = CommandCodeFarm.FARM_EXP_CHANGE_NOTIFY.toString(16);
      
      public static const FARM_LIST_CHECK_NOTIFY:String = CommandCodeFarm.FARM_LIST_CHECK_NOTIFY.toString(16);
      
      public static const FARM_BUILDING_ADDED_NOTIFY:String = CommandCodeFarm.FARM_BUILDING_ADDED_NOTIFY.toString(16);
      
      public static const FARM_BUILDING_REMOVED_NOTIFY:String = CommandCodeFarm.FARM_BUILDING_REMOVED_NOTIFY.toString(16);
      
      public static const FARM_HARVEST_ADDED_NOTIFY:String = CommandCodeFarm.FARM_HARVEST_ADDED_NOTIFY.toString(16);
      
      public static const FARM_HARVEST_CHECK_NOTIFY:String = CommandCodeFarm.FARM_HARVEST_CHECK_NOTIFY.toString(16);
      
      public static const FARM_HARVEST_REMOVED_NOTIFY:String = CommandCodeFarm.FARM_HARVEST_REMOVED_NOTIFY.toString(16);
      
      public static const FARM_HARVEST_COLLECT_TEST_ANSWER:String = CommandCodeFarm.FARM_HARVEST_COLLECT_TEST_ANSWER.toString(16);
      
      public static const FARM_HARVEST_QUERY_ANSWER:String = CommandCodeFarm.FARM_HARVEST_QUERY_ANSWER.toString(16);
      
      public function FarmEventType()
      {
         super();
      }
   }
}

