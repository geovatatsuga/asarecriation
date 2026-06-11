package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerEventType
   {
      
      public static const PLAYER_ENTER_WORLD_ANSWER:String = CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER.toString(16);
      
      public static const PLAYER_LEAVE_WORLD_ANSWER:String = CommandCodePlayer.PLAYER_LEAVE_WORLD_ANSWER.toString(16);
      
      public static const PLAYER_ENTER_MAP_ANSWER:String = CommandCodePlayer.PLAYER_ENTER_MAP_ANSWER.toString(16);
      
      public static const PLAYER_POSITION_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_POSITION_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_VIEW_MAP_ANSWER:String = CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER.toString(16);
      
      public static const PLAYER_LUCKY_SKILL_NOTIFY:String = CommandCodePlayer.PLAYER_LUCKY_SKILL_NOTIFY.toString(16);
      
      public static const PLAYER_SKILL_INTERRUPTED_NOTIFY:String = CommandCodePlayer.PLAYER_SKILL_INTERRUPTED_NOTIFY.toString(16);
      
      public static const PLAYER_HP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_HP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_HPMAX_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_HPMAX_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_MP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_MP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_MPMAX_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_MPMAX_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_BUFF_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_BUFF_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_EXP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_EXP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_LEVEL_UP_NOTIFY:String = CommandCodePlayer.PLAYER_LEVEL_UP_NOTIFY.toString(16);
      
      public static const PLAYER_SKILL_CD_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_SKILL_CD_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_GOLD_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_GOLD_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_MONEY_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_MONEY_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_COIN_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_COIN_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_COMBAT_STATUS_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_COMBAT_STATUS_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_ATTRIBUTES_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_ATTRIBUTES_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY:String = CommandCodePlayer.PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY.toString(16);
      
      public static const PLAYER_XP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_XP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_XPMAX_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_XPMAX_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_SP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_SP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_SPMAX_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_SPMAX_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_DIED_NOTIFY:String = CommandCodePlayer.PLAYER_DIED_NOTIFY.toString(16);
      
      public static const PLAYER_REBIRTH_NOTIFY:String = CommandCodePlayer.PLAYER_REBIRTH_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY:String = CommandCodePlayer.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_MSG_NOTIFY:String = CommandCodePlayer.PLAYER_RECEIVE_MSG_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_SYS_PROMPT_NOTIFY:String = CommandCodePlayer.PLAYER_RECEIVE_SYS_PROMPT_NOTIFY.toString(16);
      
      public static const PLAYER_SHOW_TALKS_NOTIFY:String = CommandCodePlayer.PLAYER_SHOW_TALKS_NOTIFY.toString(16);
      
      public static const PLAYER_RIDE_STATE_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_RIDE_STATE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY:String = CommandCodePlayer.PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY:String = CommandCodePlayer.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_USING_RIDE_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_USING_RIDE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_RIDE_ITEM_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_RIDE_ITEM_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_RIDE_FUSION_ANSWER:String = CommandCodePlayer.PLAYER_RIDE_FUSION_ANSWER.toString(16);
      
      public static const PLAYER_VIEW_REMOTE_ANSWER:String = CommandCodePlayer.PLAYER_VIEW_REMOTE_ANSWER.toString(16);
      
      public static const PLAYER_SIT_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_SIT_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_USE_MOTION_NOTIFY:String = CommandCodePlayer.PLAYER_USE_MOTION_NOTIFY.toString(16);
      
      public static const PLAYER_STATUS_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_STATUS_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_HAIR_STYLE_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_HAIR_STYLE_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_LIFE_EXP_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_LIFE_EXP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_LIFE_JOB_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_LIFE_JOB_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_LIFE_LEVEL_UP_NOTIFY:String = CommandCodePlayer.PLAYER_LIFE_LEVEL_UP_NOTIFY.toString(16);
      
      public static const PLAYER_PK_MODE_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_PK_MODE_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_PK_VALUE_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_PK_VALUE_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY:String = CommandCodePlayer.PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY.toString(16);
      
      public static const PLAYER_KILLED_MONSTER_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_KILLED_MONSTER_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_DO_CLIENT_MACRO_NOTIFY:String = CommandCodePlayer.PLAYER_DO_CLIENT_MACRO_NOTIFY.toString(16);
      
      public static const PLAYER_COUNTER_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_COUNTER_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_LEARNED_SKILLS_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_LEARNED_SKILLS_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_LEARNED_SKILL_NOTIFY:String = CommandCodePlayer.PLAYER_LEARNED_SKILL_NOTIFY.toString(16);
      
      public static const PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY:String = CommandCodePlayer.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_VIP_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_VIP_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TITLE_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_TITLE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_KIT_TITLE_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_KIT_TITLE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TITLE_LIST_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_TITLE_LIST_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_SIDE_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_SIDE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_BELIEF_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_BELIEF_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_MAP_HONOR_CHECK_NOTIFY:String = CommandCodePlayer.PLAYER_MAP_HONOR_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_CALL_TRAINER_NOTIFY:String = CommandCodePlayer.PLAYER_CALL_TRAINER_NOTIFY.toString(16);
      
      public static const PLAYER_CHANGE_MODEL_END_REQUEST:String = CommandCodePlayer.PLAYER_CHANGE_MODEL_END_REQUEST.toString(16);
      
      public static const PLAYER_CHANGE_MODEL_NOTIFY:String = CommandCodePlayer.PLAYER_CHANGE_MODEL_NOTIFY.toString(16);
      
      public static const obf_h_i_3566:String = CommandCodePlayer.obf_h_i_3566.toString(16);
      
      public function PlayerEventType()
      {
         super();
      }
   }
}

