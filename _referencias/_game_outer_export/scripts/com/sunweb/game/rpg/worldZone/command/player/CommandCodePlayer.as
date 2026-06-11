package com.sunweb.game.rpg.worldZone.command.player
{
   public class CommandCodePlayer
   {
      
      public static const PLAYER_ENTER_WORLD_REQ:int = 513;
      
      public static const PLAYER_ENTER_WORLD_ANSWER:int = 514;
      
      public static const PLAYER_LEAVE_WORLD_REQ:int = 515;
      
      public static const PLAYER_LEAVE_WORLD_ANSWER:int = 516;
      
      public static const PLAYER_ENTER_MAP_REQ:int = 517;
      
      public static const PLAYER_ENTER_MAP_ANSWER:int = 518;
      
      public static const PLAYER_MOVE_REQ:int = 519;
      
      public static const PLAYER_POSITION_CHECK_NOTIFY:int = 520;
      
      public static const PLAYER_VIEW_MAP_REQ:int = 521;
      
      public static const PLAYER_VIEW_MAP_ANSWER:int = 522;
      
      public static const PLAYER_SELECT_LINE_REQ:int = 523;
      
      public static const PLAYER_USE_SKILL_REQ:int = 545;
      
      public static const PLAYER_LUCKY_SKILL_NOTIFY:int = 547;
      
      public static const PLAYER_CANCEL_SKILL_REQ:int = 548;
      
      public static const PLAYER_SKILL_INTERRUPTED_NOTIFY:int = 549;
      
      public static const PLAYER_HP_CHANGE_NOTIFY:int = 550;
      
      public static const PLAYER_HPMAX_CHANGE_NOTIFY:int = 551;
      
      public static const PLAYER_MP_CHANGE_NOTIFY:int = 552;
      
      public static const PLAYER_MPMAX_CHANGE_NOTIFY:int = 553;
      
      public static const PLAYER_BUFF_CHANGE_NOTIFY:int = 560;
      
      public static const PLAYER_EXP_CHANGE_NOTIFY:int = 561;
      
      public static const PLAYER_LEVEL_UP_NOTIFY:int = 562;
      
      public static const PLAYER_GOLD_CHANGE_NOTIFY:int = 563;
      
      public static const PLAYER_MONEY_CHANGE_NOTIFY:int = 564;
      
      public static const PLAYER_DIED_NOTIFY:int = 565;
      
      public static const PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY:int = 566;
      
      public static const PLAYER_REBIRTH_REQUEST:int = 567;
      
      public static const PLAYER_REBIRTH_NOTIFY:int = 568;
      
      public static const PLAYER_SKILL_CD_CHECK_NOTIFY:int = 569;
      
      public static const PLAYER_COMBAT_STATUS_CHECK_NOTIFY:int = 570;
      
      public static const PLAYER_XP_CHANGE_NOTIFY:int = 571;
      
      public static const PLAYER_XPMAX_CHANGE_NOTIFY:int = 572;
      
      public static const PLAYER_SP_CHANGE_NOTIFY:int = 576;
      
      public static const PLAYER_SPMAX_CHANGE_NOTIFY:int = 577;
      
      public static const PLAYER_SEND_MSG_REQUEST:int = 673;
      
      public static const PLAYER_RECEIVE_MSG_NOTIFY:int = 674;
      
      public static const PLAYER_RECEIVE_SYS_PROMPT_NOTIFY:int = 675;
      
      public static const PLAYER_SHOW_TALKS_NOTIFY:int = 676;
      
      public static const PLAYER_ATTRIBUTES_CHANGE_NOTIFY:int = 578;
      
      public static const PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY:int = 579;
      
      public static const PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY:int = 580;
      
      public static const PLAYER_VIEW_REMOTE_REQUEST:int = 581;
      
      public static const PLAYER_VIEW_REMOTE_ANSWER:int = 582;
      
      public static const PLAYER_SIT_REQUEST:int = 583;
      
      public static const PLAYER_SIT_CHECK_NOTIFY:int = 584;
      
      public static const PLAYER_USE_MOTION_REQUEST:int = 585;
      
      public static const PLAYER_USE_MOTION_NOTIFY:int = 586;
      
      public static const PLAYER_STATUS_CHANGE_NOTIFY:int = 587;
      
      public static const PLAYER_HAIR_STYLE_CHANGE_NOTIFY:int = 588;
      
      public static const PLAYER_COIN_CHANGE_NOTIFY:int = 589;
      
      public static const PLAYER_RIDE_REQUEST:int = 593;
      
      public static const PLAYER_RIDE_STATE_CHECK_NOTIFY:int = 594;
      
      public static const PLAYER_PASSIVE_RIDE_REQUEST:int = 595;
      
      public static const PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY:int = 596;
      
      public static const PLAYER_PROCESS_PASSIVE_RIDE_REQUEST_REPLY:int = 597;
      
      public static const PLAYER_INVITE_RIDE_REQUEST:int = 598;
      
      public static const PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY:int = 599;
      
      public static const PLAYER_PROCESS_INVITE_RIDE_REQUEST_REPLY:int = 600;
      
      public static const PLAYER_KICK_RIDE_REQUEST:int = 601;
      
      public static const PLAYER_SET_USING_RIDE_REQUEST:int = 602;
      
      public static const PLAYER_USING_RIDE_CHECK_NOTIFY:int = 603;
      
      public static const PLAYER_RIDE_FUSION_REQUEST:int = 606;
      
      public static const PLAYER_RIDE_FUSION_ANSWER:int = 607;
      
      public static const PLAYER_RIDE_DECOMPOSE_REQUEST:int = 619;
      
      public static const PLAYER_RIDE_ITEM_CHECK_NOTIFY:int = 604;
      
      public static const PLAYER_ADD_RIDE_EXP_REQUEST:int = 605;
      
      public static const PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY:int = 609;
      
      public static const PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY:int = 610;
      
      public static const PLAYER_KILLED_MONSTER_CHANGE_NOTIFY:int = 611;
      
      public static const PLAYER_DO_CLIENT_MACRO_NOTIFY:int = 612;
      
      public static const PLAYER_COUNTER_CHECK_NOTIFY:int = 613;
      
      public static const PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY:int = 614;
      
      public static const PLAYER_LIFE_JOB_CHANGE_NOTIFY:int = 625;
      
      public static const PLAYER_LIFE_EXP_CHANGE_NOTIFY:int = 626;
      
      public static const PLAYER_LIFE_LEVEL_UP_NOTIFY:int = 627;
      
      public static const PLAYER_SET_PK_MODE_REQUEST:int = 641;
      
      public static const PLAYER_PK_MODE_CHANGE_NOTIFY:int = 642;
      
      public static const PLAYER_PK_VALUE_CHANGE_NOTIFY:int = 643;
      
      public static const PLAYER_LEARN_SKILL_REQUEST:int = 657;
      
      public static const PLAYER_LEARNED_SKILLS_CHECK_NOTIFY:int = 658;
      
      public static const PLAYER_LEARNED_SKILL_NOTIFY:int = 659;
      
      public static const PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY:int = 689;
      
      public static const PLAYER_ASSIGN_ATTR_REQUEST:int = 690;
      
      public static const PLAYER_VIP_CHECK_NOTIFY:int = 691;
      
      public static const PLAYER_SET_TITLE_REQUEST:int = 692;
      
      public static const PLAYER_TITLE_CHECK_NOTIFY:int = 693;
      
      public static const PLAYER_TITLE_LIST_CHECK_NOTIFY:int = 694;
      
      public static const PLAYER_SIDE_CHECK_NOTIFY:int = 695;
      
      public static const PLAYER_SET_KIT_TITLE_REQUEST:int = 696;
      
      public static const PLAYER_KIT_TITLE_CHECK_NOTIFY:int = 697;
      
      public static const PLAYER_BELIEF_CHECK_NOTIFY:int = 698;
      
      public static const PLAYER_MAP_HONOR_CHECK_NOTIFY:int = 702;
      
      public static const PLAYER_REPORT_REMOTE_REQUEST:int = 700;
      
      public static const PLAYER_CALL_TRAINER_NOTIFY:int = 720;
      
      public static const PLAYER_CHANGE_MODEL_NOTIFY:int = 739;
      
      public static const PLAYER_CHANGE_MODEL_END_REQUEST:int = 740;
      
      public static const obf_h_i_3566:int = 746;
      
      public function CommandCodePlayer()
      {
         super();
      }
   }
}

