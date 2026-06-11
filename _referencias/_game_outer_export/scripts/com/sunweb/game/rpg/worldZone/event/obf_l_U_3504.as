package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.map.CommandCodeMap;
   import com.sunweb.game.rpg.worldZone.command.map.clear.CommandCodeMapClear;
   import com.sunweb.game.rpg.worldZone.command.map.tower.CommandCodeMapTower;
   
   public class obf_l_U_3504
   {
      
      public static const MAP_ITEM_ADDED_NOTIFY:String = CommandCodeMap.MAP_ITEM_ADDED_NOTIFY.toString(16);
      
      public static const MAP_ITEM_REMOVED_NOTIFY:String = CommandCodeMap.MAP_ITEM_REMOVED_NOTIFY.toString(16);
      
      public static const MAP_VAR_CHANGE_NOTIFY:String = CommandCodeMap.MAP_VAR_CHANGE_NOTIFY.toString(16);
      
      public static const MAP_VAR_CLEAR_NOTIFY:String = CommandCodeMap.MAP_VAR_CLEAR_NOTIFY.toString(16);
      
      public static const MAP_REFRESH_NPC_NOTIFY:String = CommandCodeMap.MAP_REFRESH_NOTIFY.toString(16);
      
      public static const MAP_NPC_SAY_NOTIFY:String = CommandCodeMap.MAP_NPC_SAY_NOTIFY.toString(16);
      
      public static const MAP_DAMAGE_VALUE_CHECK_NOTIFY:String = CommandCodeMap.MAP_DAMAGE_VALUE_CHECK_NOTIFY.toString(16);
      
      public static const MAP_DAMAGE_RANK_CHECK_NOTIFY:String = CommandCodeMap.MAP_DAMAGE_RANK_CHECK_NOTIFY.toString(16);
      
      public static const MAP_CLEAR_INFO_CHECK_NOTIFY:String = CommandCodeMapClear.MAP_CLEAR_INFO_CHECK_NOTIFY.toString(16);
      
      public static const MAP_CLEARED_NOTIFY:String = CommandCodeMapClear.MAP_CLEARED_NOTIFY.toString(16);
      
      public static const MAP_CLEAR_BONUS_ANSWER:String = CommandCodeMapClear.MAP_CLEAR_BONUS_ANSWER.toString(16);
      
      public static const MAP_CLEAR_RANKING_ANSWER:String = CommandCodeMapClear.MAP_CLEAR_RANKING_ANSWER.toString(16);
      
      public static const MAP_TOWER_NOTIFY:String = CommandCodeMapTower.MAP_TOWER_NOTIFY.toString(16);
      
      public function obf_l_U_3504()
      {
         super();
      }
   }
}

