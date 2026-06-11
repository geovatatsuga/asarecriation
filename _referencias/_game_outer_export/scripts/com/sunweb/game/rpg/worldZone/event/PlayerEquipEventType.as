package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.equ.CommandCodePlayerEquip;
   
   public class PlayerEquipEventType
   {
      
      public static const PLAYER_EQUIPMENT_CHECK_NOTIFY:String = CommandCodePlayerEquip.PLAYER_EQUIPMENT_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_SWITCH_FASHION_NOTIFY:String = CommandCodePlayerEquip.PLAYER_SWITCH_FASHION_NOTIFY.toString(16);
      
      public static const PLAYER_VIEW_REPAIR_INFO_ANSWER:String = CommandCodePlayerEquip.PLAYER_VIEW_REPAIR_INFO_ANSWER.toString(16);
      
      public static const PLAYER_REPAIR_EQUIPMENT_ANSWER:String = CommandCodePlayerEquip.PLAYER_REPAIR_EQUIPMENT_ANSWER.toString(16);
      
      public static const PLAYER_EQUIP_DUR_CHECK_NOTIFY:String = CommandCodePlayerEquip.PLAYER_EQUIP_DUR_CHECK_NOTIFY.toString(16);
      
      public function PlayerEquipEventType()
      {
         super();
      }
   }
}

