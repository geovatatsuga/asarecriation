package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.CommandCodeOnlineBonus;
   
   public class OnlineBonusEventType
   {
      
      public static const ONLINE_BONUS_CHECK_NOTIFY:String = CommandCodeOnlineBonus.ONLINE_BONUS_CHECK_NOTIFY.toString(16);
      
      public static const ONLINE_COIN_CHECK_NOTIFY:String = CommandCodeOnlineBonus.ONLINE_COIN_CHECK_NOTIFY.toString(16);
      
      public static const OFFLINE_BONUS_CHECK_NOTIFY:String = CommandCodeOnlineBonus.OFFLINE_BONUS_CHECK_NOTIFY.toString(16);
      
      public static const OFFLINE_BONUS_FETCH_ANSWER:String = CommandCodeOnlineBonus.OFFLINE_BONUS_FETCH_ANSWER.toString(16);
      
      public static const obf_0_8_k_656:String = CommandCodeOnlineBonus.obf_0_8_k_656.toString(16);
      
      public static const obf_0_0_W_474:String = CommandCodeOnlineBonus.obf_0_0_W_474.toString(16);
      
      public function OnlineBonusEventType()
      {
         super();
      }
   }
}

