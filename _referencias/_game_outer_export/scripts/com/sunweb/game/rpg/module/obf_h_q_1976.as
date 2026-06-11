package com.sunweb.game.rpg.module
{
   import obf_0_2_o_501.obf_g_4_2381;
   import obf_0_2_t_601.obf_o_H_2969;
   import obf_0_6_Z_584.obf_5_M_1027;
   import obf_0_7_V_532.obf_N_o_3647;
   import obf_0_7_o_492.obf_b_q_889;
   import obf_5_S_2387.obf_H_c_1383;
   import obf_6_4_3428.obf_s_W_2408;
   import obf_9_H_3298.PassTicketManager;
   import obf_D_Y_975.obf_7_q_3477;
   import obf_H_I_939.obf_u_Z_4014;
   import obf_O_e_3875.obf_0_4_5_176;
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_R_R_2172.obf_1_Y_1502;
   import obf_R_w_4473.obf_A_S_2214;
   import obf_S_0_4540.DevilGodManager;
   import obf_T_4_4162.obf_0_4_3_717;
   import obf_Z_U_3013.obf_C_p_3418;
   import obf_Z_Y_1344.ItemManualManager;
   import obf_a_F_1055.obf_K_i_1311;
   import obf_b_2_1718.obf_0_8_D_73;
   import obf_b_P_3069.obf_n_x_1562;
   import obf_c_j_3175.obf_0_6_H_238;
   import obf_h_e_3633.obf_8_m_2284;
   import obf_i_X_3487.obf_v_0_1258;
   import obf_l_I_3561.obf_g_0_3344;
   import obf_o_M_4577.obf_l_N_3214;
   import obf_q_S_2073.obf_O_a_3022;
   import obf_r_4635.obf_R_6_1363;
   import obf_x_O_4078.obf_1_t_884;
   import obf_x_O_4078.obf_A_V_935;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_0_1_2695;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.aegis.obf_C_E_4362;
   import com.sunweb.game.rpg.agent.obf_Y_6_1629;
   import com.sunweb.game.rpg.angel.obf_O_7_1100;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.challenge.obf_0_5_f_69;
   import com.sunweb.game.rpg.cloak.obf_b_T_3041;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.country.obf_S_x_1774;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.extractant.obf_t_f_2299;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.fateTurntable.obf_3_i_1942;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.genie.obf_P_e_2948;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.godSoul.obf_t_a_1082;
   import com.sunweb.game.rpg.godStyle.obf_d_M_1152;
   import com.sunweb.game.rpg.legend.obf_P_8_3783;
   import com.sunweb.game.rpg.lockTower.obf_N_9_4230;
   import com.sunweb.game.rpg.mail.obf_G_6_4257;
   import com.sunweb.game.rpg.manual.obf_V_C_3520;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.mate.MateManager;
   import com.sunweb.game.rpg.misc.obf_0_5_9_486;
   import com.sunweb.game.rpg.netRole.*;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.petDepot.obf_0_1_a_376;
   import com.sunweb.game.rpg.pis.obf_j_s_1302;
   import com.sunweb.game.rpg.playerBag.BagItemManager;
   import com.sunweb.game.rpg.playerBook.obf_E_1429;
   import com.sunweb.game.rpg.playerDevil.obf_0_4_6_372;
   import com.sunweb.game.rpg.playerUI.*;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playingCard.obf_V_N_2158;
   import com.sunweb.game.rpg.ranking.RankingManager;
   import com.sunweb.game.rpg.rideDepot.obf_2_l_4040;
   import com.sunweb.game.rpg.rideEquip.obf_Y_7_1544;
   import com.sunweb.game.rpg.role.*;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillAreaAimManager;
   import com.sunweb.game.rpg.skill.SkillCDManager;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.soulGuard.obf_4_3841;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.starAdventure.StarAdventureManager;
   import com.sunweb.game.rpg.stirp.obf_x_B_2963;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.rpg.sysmsg.obf_a_L_2059;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import com.sunweb.game.rpg.trade.obf_G_0_3203;
   import com.sunweb.game.rpg.treasury.obf_M_a_3122;
   import com.sunweb.game.rpg.vacantSpace.obf_9_Y_4477;
   import com.sunweb.game.rpg.wardrobe.obf_s_o_3993;
   import com.sunweb.game.rpg.wingSpirit.obf_B_5_1274;
   import com.sunweb.game.rpg.world.PromptsManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.*;
   import com.sunweb.game.rpg.world.ui.*;
   import com.sunweb.game.rpg.worldZone.obf_u_d_1452;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   import com.sunweb.game.rpg.worldZone.command.gm.GM_CommandAnswer;
   import com.sunweb.game.rpg.worldZone.command.npc.CommandCodeNpc;
   import com.sunweb.game.rpg.worldZone.command.player.*;
   import com.sunweb.game.rpg.worldZone.command.shop.CommandCodeShop;
   import com.sunweb.game.rpg.worldZone.command.system.SysVarChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.system.SysVarClearNotify;
   import com.sunweb.game.rpg.worldZone.command.system.WorldPingEcho;
   import com.sunweb.game.rpg.worldZone.command.system.WorldTimeCheckNotify;
   import com.sunweb.game.rpg.worldZone.event.*;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import mmorpg.MainUI;
   
   public class obf_h_q_1976 extends MainUI implements IWindow
   {
      
      private var obf_H_L_4047:TimeLimiter = new TimeLimiter(10000);
      
      private var obf_0_7_y_415:Sprite;
      
      private var uiSprite:Sprite;
      
      private var tipSprite:Sprite;
      
      private var obf_0_e_4025:TimeLimiter = new TimeLimiter(3000);
      
      private var userConfig:Object;
      
      private var userConfigSaveTime:TimeLimiter;
      
      private var _player:obf_U_6_3454;
      
      private var obf_S_1036:MapWrapper;
      
      private var _mapManager:MapManager;
      
      private var _mapSprite:Sprite;
      
      public function obf_h_q_1976()
      {
         super();
         this.obf_0_7_y_415 = new Sprite();
         this.uiSprite = new Sprite();
         this.tipSprite = new Sprite();
         this.obf_S_1036 = new MapWrapper();
         this._mapManager = new MapManager();
         this._mapSprite = new Sprite();
         this.addChildAt(this._mapSprite,0);
         this.addChild(this.obf_0_7_y_415);
         this.addChild(this.uiSprite);
         this.addChild(this.tipSprite);
         GameContext.bagItemManager = new BagItemManager();
         obf_K_e_3075.init(this.uiSprite);
         FarmManager.init(this._mapSprite);
         SkillAreaAimManager.init(this.obf_0_7_y_415);
         GameTipManager.init(this.tipSprite);
         this.addListener();
         if(GameContext.worldClient.online)
         {
            GameContext.worldClient.sendCommand(new PlayerEnterWorldRequest());
         }
         GameContext.mainModule = this;
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         GameContext.worldClient.addEventListener(obf_l_N_3214.obf_N_7_3895,this.obf_J_H_4400);
         this._mapManager.addEventListener(MapManagerEvent.MAP_START_LOAD,this.onMapStartLoad);
         this._mapManager.addEventListener(MapManagerEvent.MAP_CREATE_COMPLETE,this.onMapCreateComplete);
         var _loc1_:obf_u_d_1452 = GameContext.worldClient;
         _loc1_.addEventListener(WorldSystemEventType.WORLD_PING_ECHO,this.obf_e_m_3644);
         _loc1_.addEventListener(WorldSystemEventType.WORLD_TIME_CHECK_NOTIFY,this.obf_p_a_c_k_a_g_e_30);
         _loc1_.addEventListener(WorldSystemEventType.SYS_VAR_CHANGE_NOTIFY,this.obf_6_p_864);
         _loc1_.addEventListener(WorldSystemEventType.SYS_VAR_CLEAR_NOTIFY,this.obf_h_A_3414);
         _loc1_.addEventListener(PlayerEventType.PLAYER_ENTER_WORLD_ANSWER,this.onEnterWorld);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LEAVE_WORLD_ANSWER,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_ENTER_MAP_ANSWER,this.onEnterMap);
         _loc1_.addEventListener(PlayerEventType.PLAYER_VIEW_MAP_ANSWER,this.onViewMap);
         _loc1_.addEventListener(PlayerEventType.PLAYER_POSITION_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_BUFF_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_HP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_HPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_MP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_MPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_DIED_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SKILL_INTERRUPTED_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LUCKY_SKILL_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_REBIRTH_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SKILL_CD_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_XP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_XPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_ATTRIBUTES_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SIT_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_GOLD_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_MONEY_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_COIN_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_USE_MOTION_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_STATUS_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_HAIR_STYLE_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_COMBAT_STATUS_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_MSG_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_SYS_PROMPT_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SHOW_TALKS_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RIDE_STATE_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_USING_RIDE_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RIDE_ITEM_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_RIDE_FUSION_ANSWER,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LIFE_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LIFE_JOB_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LIFE_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_VIEW_REMOTE_ANSWER,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_PK_MODE_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_PK_VALUE_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_KILLED_MONSTER_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_DO_CLIENT_MACRO_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_COUNTER_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LEARNED_SKILLS_CHECK_NOTIFY,this.obf_2_S_2318);
         _loc1_.addEventListener(PlayerEventType.PLAYER_LEARNED_SKILL_NOTIFY,this.obf_2_S_2318);
         _loc1_.addEventListener(PlayerEventType.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_VIP_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_TITLE_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_KIT_TITLE_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_TITLE_LIST_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_SIDE_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_BELIEF_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_MAP_HONOR_CHECK_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_CALL_TRAINER_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.PLAYER_CHANGE_MODEL_NOTIFY,this.obf_a_0_2514);
         _loc1_.addEventListener(PlayerEventType.obf_h_i_3566,this.obf_a_0_2514);
         _loc1_.addEventListener(MateEventType.PLAYER_MATE_RELATION_CHECK_NOTIFY,this.obf_5_H_3100);
         _loc1_.addEventListener(MateEventType.PLAYER_MATE_VAR_CHANGE_NOTIFY,this.obf_5_H_3100);
         _loc1_.addEventListener(MateEventType.PLAYER_MATE_VAR_CLEAR_NOTIFY,this.obf_5_H_3100);
         _loc1_.addEventListener(FriendEvent.PLAYER_ADD_FRIEND_ANSWER,this.obf_0_0_X_268);
         _loc1_.addEventListener(FriendEvent.PLAYER_FRIEND_CHECK_NOTIFY,this.obf_0_0_X_268);
         _loc1_.addEventListener(FriendEvent.PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY,this.obf_0_0_X_268);
         _loc1_.addEventListener(FriendEvent.PLAYER_REMOVED_FRIEND_NOTIFY,this.obf_0_0_X_268);
         _loc1_.addEventListener(FriendEvent.PLAYER_RECEIVE_GIFT_NOTIFY,this.obf_0_0_X_268);
         _loc1_.addEventListener(NpcEvent.NPC_ASSEMBLE_ITEM_ANSWER,this.obf_0_u_3276);
         _loc1_.addEventListener(NpcEvent.NPC_Function_ANSWER,this.obf_0_u_3276);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_ADDED_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_LIST_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_REMOVED_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_MY_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_INVITE_FAMILY_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_LIST_FAMILY_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_RECEIVE_INVITE_FAMILY_REQUEST_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_VIEW_FAMILY_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_VIEW_JOIN_FAMILY_LIST_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_DECLARATION_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_NOTICE_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_VIEW_FAMILY_POST_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_LIST_FAMILY_TASK_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_VARS_CHECK_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_VAR_CHANGE_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_VAR_CLEAR_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.LIST_FAMILY_INT_VAR_ANSWER,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_INVENT_SKILL_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(FamilyEvent.PLAYER_FAMILY_BOSS_CALL_NOTIFY,this.obf_f_Y_3549);
         _loc1_.addEventListener(TeamEventType.PLAYER_GIVE_TEAM_LEADER_ANSWER,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_INVITE_TEAM_ANSWER,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_JOIN_TEAM_ANSWER,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_RECEIVE_GIVE_TEAM_LEADER_REQUEST_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_CHECK_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_LEADER_CHANGE_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_MEMBER_CHECK_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_MEMBER_MP_CHANGE_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_ROLL_ITEM_ANSWER,this.obf_u_V_3362);
         _loc1_.addEventListener(TeamEventType.PLAYER_TEAM_ROLL_RESULT_NOTIFY,this.obf_u_V_3362);
         _loc1_.addEventListener(TaskEventType.PLAYER_RECEIVE_TASK_NOTIFY,this.obf_w_H_3965);
         _loc1_.addEventListener(TaskEventType.PLAYER_FINISH_TASK_NOTIFY,this.obf_w_H_3965);
         _loc1_.addEventListener(TaskEventType.PLAYER_ABORT_TASK_NOTIFY,this.obf_w_H_3965);
         _loc1_.addEventListener(obf_g_W_3605.PLAYER_FINISH_SUCCESS_NOTIFY,this.obf_Q_v_4401);
         _loc1_.addEventListener(obf_g_W_3605.PLAYER_SUCCESS_INFO_NOTIFY,this.obf_Q_v_4401);
         _loc1_.addEventListener(obf_g_W_3605.WORLD_SUCCESS_TIMES_ANSWER,this.obf_Q_v_4401);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_ENTER_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_LEAVE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_POSITION_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_USE_SKILL_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_SKILL_INTERRUPTED_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_HP_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_MP_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_BUFF_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_LEVEL_UP_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_LUCKY_SKILL_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_DIED_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_REBIRTH_LOCALLY_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_EQUIPMENT_MODEL_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_SIT_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_USE_MOTION_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_STATUS_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_RIDE_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_GENIE_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_PET_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_BLESS_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_BOOTH_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_VIP_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_HONOR_LEVEL_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_PK_MODE_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_PK_VALUE_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_TEAM_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_FAMILY_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_MATE_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_HAIR_STYLE_CHANGE_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_SIDE_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_DRAGON_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_CALL_TRAINER_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_DEVIL_CHECK_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(RemotePlayerEventType.REMOTE_CHANGE_MODEL_NOTIFY,this.obf_4_L_4387);
         _loc1_.addEventListener(MonsterEventType.MONSTER_BORN_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_MOVE_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_POSITION_CHECK_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_BUFF_CHANGE_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_DIE_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_HP_CHANGE_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_USE_SKILL_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(MonsterEventType.MONSTER_REMOVED_NOTIFY,this.obf_0_Q_759);
         _loc1_.addEventListener(obf_l_U_3504.MAP_ITEM_ADDED_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_ITEM_REMOVED_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_VAR_CHANGE_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_VAR_CLEAR_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_REFRESH_NPC_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_NPC_SAY_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_DAMAGE_RANK_CHECK_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_DAMAGE_VALUE_CHECK_NOTIFY,this.obf_6_z_4094);
         _loc1_.addEventListener(obf_l_U_3504.MAP_CLEAR_INFO_CHECK_NOTIFY,this.obf_c_3_2666);
         _loc1_.addEventListener(obf_l_U_3504.MAP_CLEARED_NOTIFY,this.obf_c_3_2666);
         _loc1_.addEventListener(obf_l_U_3504.MAP_CLEAR_BONUS_ANSWER,this.obf_c_3_2666);
         _loc1_.addEventListener(obf_l_U_3504.MAP_TOWER_NOTIFY,this.obf_0_3_G_585);
         _loc1_.addEventListener(obf_d_4670.MAP_TRAP_ADDED_NOTIFY,this.obf_g_J_1920);
         _loc1_.addEventListener(obf_d_4670.MAP_TRAP_REMOVED_NOTIFY,this.obf_g_J_1920);
         _loc1_.addEventListener(obf_d_4670.MAP_TRAP_USE_SKILL_NOTIFY,this.obf_g_J_1920);
         _loc1_.addEventListener(obf_0_5_c_303.BLESS_CHECK_NOTIFY,this.obf_7_M_4450);
         _loc1_.addEventListener(obf_0_5_c_303.BLESS_SOLD_NOTIFY,this.obf_7_M_4450);
         _loc1_.addEventListener(obf_0_5_c_303.BLESS_VISIT_ANSWER,this.obf_7_M_4450);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_BAG_CAPACITY_CHANGE_NOTIFY,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_BAG_CHECK_NOTIFY,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_ITEM_USED_NOTIFY,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_ITEM_ADDED_NOTIFY,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_ITEM_CD_CHECK_NOTIFY,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PlayerBagEventType.PLAYER_VIEW_ITEM_ANSWER,this.obf_Q_Z_1048);
         _loc1_.addEventListener(PetEventType.PET_CHECK_NOTIFY,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_ATTR_INT_CHANGE_NOTIFY,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_USE_SKILL_NOTIFY,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_LEARN_SKILL_ANSWER,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_HP_CHANGE_NOTIFY,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_ENHANCE_ANSWER,this.obf_5_p_2638);
         _loc1_.addEventListener(PetEventType.PET_FUSION_ANSWER,this.obf_5_p_2638);
         _loc1_.addEventListener(obf_o_o_1182.PLAYER_GENIE_EXP_CHECK_NOTIFY,this.obf_0_6_d_648);
         _loc1_.addEventListener(obf_o_o_1182.PLAYER_GENIE_ITEM_CHECK_NOTIFY,this.obf_0_6_d_648);
         _loc1_.addEventListener(obf_o_o_1182.PLAYER_GENIE_UPGRADE_ANSWER,this.obf_0_6_d_648);
         _loc1_.addEventListener(obf_o_o_1182.PLAYER_USING_GENIE_CHECK_NOTIFY,this.obf_0_6_d_648);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_MOVE_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_USE_SKILL_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_HP_CHANGE_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_ATTRIBUTES_CHANGE_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_ENTER_TRAINER_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(AnimalEventType.ANIMAL_BUFF_CHANGE_NOTIFY,this.obf_S_E_3433);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_DISEMBED_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_EMBED_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_HOLE_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_REFINE_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_UPGRADE_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_FUSION_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_WASH_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_HOLESKILL_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_HOST_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_CLEAN_SKILL_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_LETTERING_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_UP_EQU_EXP_ANSWER,this.obf_0_1_V_721);
         _loc1_.addEventListener(AgentEventType.AGENT_LIST_ITEM_ANSWER,this.obf_1_j_999);
         _loc1_.addEventListener(AgentEventType.AGENT_VIEW_MY_ITEMS_ANSWER,this.obf_1_j_999);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_INVITE_TRADE_ANSWER,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_RECEIVE_INVITE_TRADE_REQUEST_NOTIFY,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_TRADE_BEGIN_NOTIFY,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_TRADE_CONFIRM_NOTIFY,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_TRADE_END_NOTIFY,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_TRADE_ITEM_SUBMIT_NOTIFY,this.obf_8_3126);
         _loc1_.addEventListener(obf_0_2_J_653.PLAYER_TRADE_CHECK_ANSWER,this.obf_8_3126);
         _loc1_.addEventListener(BoothEvent.BOOTH_CHECK_NOTIFY,this.obf_0_2_U_535);
         _loc1_.addEventListener(BoothEvent.BOOTH_ITEM_SOLD_NOTIFY,this.obf_0_2_U_535);
         _loc1_.addEventListener(BoothEvent.BOOTH_VISIT_ANSWER,this.obf_0_2_U_535);
         _loc1_.addEventListener(BoothEvent.BOOTH_ITEM_PURCHASED_NOTIFY,this.obf_0_2_U_535);
         _loc1_.addEventListener(PlayerEquipEventType.PLAYER_EQUIPMENT_CHECK_NOTIFY,this.obf_M_L_4488);
         _loc1_.addEventListener(PlayerEquipEventType.PLAYER_SWITCH_FASHION_NOTIFY,this.obf_M_L_4488);
         _loc1_.addEventListener(PlayerEquipEventType.PLAYER_REPAIR_EQUIPMENT_ANSWER,this.obf_M_L_4488);
         _loc1_.addEventListener(PlayerEquipEventType.PLAYER_VIEW_REPAIR_INFO_ANSWER,this.obf_M_L_4488);
         _loc1_.addEventListener(PlayerEquipEventType.PLAYER_EQUIP_DUR_CHECK_NOTIFY,this.obf_M_L_4488);
         _loc1_.addEventListener(FarmEventType.FARM_BUILDING_ADDED_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_BUILDING_REMOVED_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_CHECK_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_LIST_CHECK_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_EXP_CHANGE_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_HARVEST_ADDED_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_HARVEST_CHECK_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_HARVEST_REMOVED_NOTIFY,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_HARVEST_COLLECT_TEST_ANSWER,this.onFarmCommand);
         _loc1_.addEventListener(FarmEventType.FARM_HARVEST_QUERY_ANSWER,this.onFarmCommand);
         _loc1_.addEventListener(SysMsgEventType.SYSMSG_NEW_NOTIFY,this.obf_k_y_3983);
         _loc1_.addEventListener(SysMsgEventType.SYSMSG_VIEW_ANSWER,this.obf_k_y_3983);
         _loc1_.addEventListener(obf_0_5_2_727.MAIL_LIST_ANSWER,this.obf_2_h_1719);
         _loc1_.addEventListener(obf_0_5_2_727.MAIL_NEW_NOTIFY,this.obf_2_h_1719);
         _loc1_.addEventListener(obf_0_5_2_727.MAIL_SEND_ANSWER,this.obf_2_h_1719);
         _loc1_.addEventListener(obf_0_5_2_727.MAIL_VIEW_ANSWER,this.obf_2_h_1719);
         _loc1_.addEventListener(obf_L_g_3260.LOTTERY_LOG_NOTIFY,this.obf_I_R_2814);
         _loc1_.addEventListener(obf_L_g_3260.LOTTERY_ANSWER,this.obf_I_R_2814);
         _loc1_.addEventListener(obf_L_g_3260.GAMBLE_START_ANSWER,this.obf_I_R_2814);
         _loc1_.addEventListener(obf_L_g_3260.GAMBLE_STOP_ANSWER,this.obf_I_R_2814);
         _loc1_.addEventListener(obf_L_g_3260.PLAYER_FETCHED_ONLINEAWARD_NOTIFY,this.obf_I_R_2814);
         _loc1_.addEventListener(OnlineBonusEventType.ONLINE_BONUS_CHECK_NOTIFY,this.obf_s_3_4097);
         _loc1_.addEventListener(OnlineBonusEventType.ONLINE_COIN_CHECK_NOTIFY,this.obf_s_3_4097);
         _loc1_.addEventListener(OnlineBonusEventType.OFFLINE_BONUS_CHECK_NOTIFY,this.obf_s_3_4097);
         _loc1_.addEventListener(OnlineBonusEventType.OFFLINE_BONUS_FETCH_ANSWER,this.obf_s_3_4097);
         _loc1_.addEventListener(OnlineBonusEventType.obf_0_8_k_656,this.obf_s_3_4097);
         _loc1_.addEventListener(OnlineBonusEventType.obf_0_0_W_474,this.obf_s_3_4097);
         _loc1_.addEventListener(RankingEventType.RANKING_LIST_VIEW_ANSWER,this.obf_P_F_2419);
         _loc1_.addEventListener(obf_0___m_220.ROBOT_STATUS_CHECK_NOTIFY,this.obf_6_l_3314);
         _loc1_.addEventListener(GMEventType.GM_COMMAND_ANSWER,this.obf_8_U_1246);
         _loc1_.addEventListener(MiscEvent.USE_GIFT_CDKEY_ANSWER,this.obf_X_i_1835);
         _loc1_.addEventListener(obf_0_3_Q_292.ACTIVITY_CHECK_ALL_NOTIFY,this.obf_0_9_A_165);
         _loc1_.addEventListener(obf_0_3_Q_292.ACTIVITY_CHECK_ONE_NOTIFY,this.obf_0_9_A_165);
         _loc1_.addEventListener(obf_0_3_Q_292.PAY_MARK_ACTIVITY_NOTIFY,this.obf_0_9_A_165);
         _loc1_.addEventListener(MiscEvent.PIS_CHECK_NOTIFY,this.obf_0_s_4505);
         _loc1_.addEventListener(ShopEventType.LEAD_ITEM_INFO_NOTIFY,this.obf_4_V_1484);
         _loc1_.addEventListener(ShopEventType.obf_d_9_3617,this.obf_4_V_1484);
         _loc1_.addEventListener(PlayingCardEvent.PLAYER_CARD_START_ANSWER,this.obf_6_e_3438);
         _loc1_.addEventListener(PlayingCardEvent.PLAYER_CARD_TURN_ANSWER,this.obf_6_e_3438);
         _loc1_.addEventListener(PlayingCardEvent.PLAYER_CARD_TURN_NOTIFY,this.obf_6_e_3438);
         _loc1_.addEventListener(PlayingCardEvent.PLAYER_CARD_GAME_TIMES_NOTIFY,this.obf_6_e_3438);
         _loc1_.addEventListener(PlayingCardEvent.PLAYER_CARD_BOUN_ANSWER,this.obf_6_e_3438);
         _loc1_.addEventListener(ConstellationEventType.SET_PLAYER_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.RESET_PLAYER_CONSTELLATION_NOTIFY,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.LUCK_CHANGE_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.LUCK_GET_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.UP_PLAYER_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.CONSTELLATION_LUCK_NOTIFY,this.obf_b_F_3825);
         _loc1_.addEventListener(ConstellationEventType.CONSTELLATION_TASK_NOTIFY,this.obf_b_F_3825);
         _loc1_.addEventListener(StirpEventType.PLAYER_STIRP_LVUP_ANSWER,this.obf_1_n_3102);
         _loc1_.addEventListener(StirpEventType.PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY,this.obf_1_n_3102);
         _loc1_.addEventListener(ArmoryEventType.PLAYER_ARMORY_UPGRADE_ANSWER,this.obf_S_K_2573);
         _loc1_.addEventListener(ArmoryEventType.PLAYER_ARMORY_PROPERTY_NOTIFY,this.obf_S_K_2573);
         _loc1_.addEventListener(ArmoryEventType.PLAYER_ARMORY_UPGRADE_NOTIFY,this.obf_S_K_2573);
         _loc1_.addEventListener(BoneEventType.BONE_MELT_ANSWER,this.obf_2_r_3018);
         _loc1_.addEventListener(BoneEventType.BONE_REFINE_ANSWER,this.obf_2_r_3018);
         _loc1_.addEventListener(BoneEventType.BONE_UP_LEVEL_ANSWER,this.obf_2_r_3018);
         _loc1_.addEventListener(BoneEventType.BONE_ATTR_ANSWER,this.obf_2_r_3018);
         _loc1_.addEventListener(BoneEventType.BONE_OPEN_ANSWER,this.obf_2_r_3018);
         _loc1_.addEventListener(DragonEventType.PLAYER_DRAGON_CHECK_NOTIFY,this.obf_4_N_1466);
         _loc1_.addEventListener(DragonEventType.PLAYER_DRAGON_UPGRADE_ANSWER,this.obf_4_N_1466);
         _loc1_.addEventListener(DragonEventType.PLAYER_BUY_UP_CHANCE_ANSWER,this.obf_4_N_1466);
         _loc1_.addEventListener(TowerEventType.CLICK_LVUP_TOWER_ANSWER,this.obf_0_3_G_585);
         _loc1_.addEventListener(obf_l_4690.GLYPH_INFO_NOTIFY,this.obf_w_U_2533);
         _loc1_.addEventListener(obf_l_4690.GLYPH_MASTER_ANSWER,this.obf_w_U_2533);
         _loc1_.addEventListener(obf_l_4690.GLYPH_UP_ANSWER,this.obf_w_U_2533);
         _loc1_.addEventListener(obf_l_4690.GLYPH_UP_MASTER_NOTIFY,this.obf_w_U_2533);
         _loc1_.addEventListener(MonsterManualEventType.MANUAL_ABSORB_ANSWER,this.obf_6_S_4390);
         _loc1_.addEventListener(MonsterManualEventType.MANUAL_VIEW_ANSWER,this.obf_6_S_4390);
         _loc1_.addEventListener(activityBoxEventType.CONSUME_RANK_ITEM_NOTIFY,this.obf_0_6_J_537);
         _loc1_.addEventListener(activityBoxEventType.CONSUME_RANK_NOTIFY,this.obf_0_6_J_537);
         _loc1_.addEventListener(obf_Y_L_3484.PLAYER_FAVOR_OFFER_ANSWER,this.obf_0_4_4_636);
         _loc1_.addEventListener(ChallengeEventType.ROBOT_OPEN_ANSWER,this.obf_c_Y_1385);
         _loc1_.addEventListener(ChallengeEventType.ROBOT_ADD_CHANCE_ANSWER,this.obf_c_Y_1385);
         _loc1_.addEventListener(ChallengeEventType.ROBOT_CHALLENGE_RESULT_NOTIFY,this.obf_c_Y_1385);
         _loc1_.addEventListener(ChallengeEventType.ROBOT_REPORT_NOTIFY,this.obf_c_Y_1385);
         _loc1_.addEventListener(ChallengeEventType.ROBOT_AWARD_NOTIFY,this.obf_c_Y_1385);
         _loc1_.addEventListener(obf_Y_w_3400.GOD_SOUL_EQUIPMENT_NOTIFY,this.onGodSoul);
         _loc1_.addEventListener(obf_Y_w_3400.GOD_SOUL_INFO_NOTIFY,this.onGodSoul);
         _loc1_.addEventListener(obf_0_5_6_294.REMARK_TIMEINFO_NOTIFY,this.obf_n_f_2241);
         _loc1_.addEventListener(obf_0_5_6_294.REMARK_EXTRACTANT_UP_LV_ANSWER,this.obf_n_f_2241);
         _loc1_.addEventListener(AegisBoxEventType.PLAYER_AEGIS_NOTIFY,this.obf_K_D_4494);
         _loc1_.addEventListener(AegisBoxEventType.PLAYER_PRAY_ANSWER,this.obf_K_D_4494);
         _loc1_.addEventListener(AegisBoxEventType.PLAYER_UP_LEVEL_ANSWER,this.obf_K_D_4494);
         _loc1_.addEventListener(AegisBoxEventType.PLAYER_UPDATE_ANSWER,this.obf_K_D_4494);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_BLOOD_UP_ANSWER,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_BUY_ATTR_MAX_ANSWER,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_EAT_ANSWER,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_INFO_NOTIFY,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_LV_AT_NOTIFY,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_STUDY_ANSWER,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_TRAVEL_ANSWER,this.obf_0_3_C_527);
         _loc1_.addEventListener(BabyEventType.PLAYER_BABY_FOOD_NOTIFY,this.obf_0_3_C_527);
         _loc1_.addEventListener(FateTurntableEventType.START_TURNTABLE_ANSWER,this.obf_f_Z_1205);
         _loc1_.addEventListener(FateTurntableEventType.FATE_UP_LEVEL_ANSWER,this.obf_f_Z_1205);
         _loc1_.addEventListener(FateTurntableEventType.FATE_TURNTABLE_VALUE_NOTIFY,this.obf_f_Z_1205);
         _loc1_.addEventListener(FateTurntableEventType.FATE_TURNTABLE_INFO_NOTIFY,this.obf_f_Z_1205);
         _loc1_.addEventListener(LegendEventType.LEGEND_EMBED_ANSWER,this.onLegend);
         _loc1_.addEventListener(LegendEventType.LEGEND_HOLE_ANSWER,this.onLegend);
         _loc1_.addEventListener(LegendEventType.LEGEND_REMOVE_ANSWER,this.onLegend);
         _loc1_.addEventListener(LegendEventType.LEGENG_UP_LEVEL_ANSWER,this.onLegend);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_SOUL_ANSWER,this.obf_0_8_c_555);
         _loc1_.addEventListener(ArtifactEventType.ARTIFACT_SOUL_MOVE_ANSWER,this.obf_0_8_c_555);
         _loc1_.addEventListener(CloakEventType.PLAYER_CLOAK_CHIP_NOTIFY,this.obf_B_i_1578);
         _loc1_.addEventListener(CloakEventType.PLAYER_CLOAK_GET_UP_ANSWER,this.obf_B_i_1578);
         _loc1_.addEventListener(CloakEventType.PLAYER_CLOAK_GLYPH_NOTIFY,this.obf_B_i_1578);
         _loc1_.addEventListener(CloakEventType.PLAYER_CLOAK_MELT_ANSWER,this.obf_B_i_1578);
         _loc1_.addEventListener(PetDepotEventType.PETDEPOT_ITEMS_NOYIFY,this.obf_w_s_4568);
         _loc1_.addEventListener(PetDepotEventType.PETDEPOT_UPLEVEL_ANSWER,this.obf_w_s_4568);
         _loc1_.addEventListener(RideDepotEventType.RIDEDEPOT_ITEMS_NOYIFY,this.obf_0___F_149);
         _loc1_.addEventListener(RideDepotEventType.RIDEDEPOT_UPLEVEL_ANSWER,this.obf_0___F_149);
         _loc1_.addEventListener(TotemEventType.TOTEM_INFO_NOTIFY,this.obf_z_P_4385);
         _loc1_.addEventListener(TotemEventType.TOTEM_UP_LEVEL_STAGE_ANSWER,this.obf_z_P_4385);
         _loc1_.addEventListener(WardrobeEventType.WARDRODE_UPLEVEL_ANSWER,this.obf_U_x_3272);
         _loc1_.addEventListener(WardrobeEventType.WARDRODE_ITEMS_NOYIFY,this.obf_U_x_3272);
         _loc1_.addEventListener(obf_s_7_755.PLAYER_CHRISTMAS_DRAW_ANSWER,this.obf_0_1_s_80);
         _loc1_.addEventListener(obf_s_7_755.PLAYER_CHRISTMAS_POST_NOTIFY,this.obf_0_1_s_80);
         _loc1_.addEventListener(obf_s_7_755.PLAYER_CHRISTMAS_VALUE_NOTIFY,this.obf_0_1_s_80);
         _loc1_.addEventListener(obf_s_L_1872.PLAYER_RUN_ONLINE_TIME_NOTIFY,this.obf_0_6_m_89);
         _loc1_.addEventListener(obf_s_L_1872.PLAYER_RUN_AWARD_NOTIFY,this.obf_0_6_m_89);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_BUY_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_BUY_NUM_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_REBATE_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_WELFARE_REWARD_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_REBATE_TIMES_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(FundEventType.PLAYER_FUND_CREDIT_NOTIFY,this.obf_R_4671);
         _loc1_.addEventListener(WingSpiritEventType.PLAYER_WING_SPIRIT_ANSWER,this.obf_x_N_3059);
         _loc1_.addEventListener(obf_N_s_2019.PLAYER_USING_DEVIL_CHECK_NOTIFY,this.obf_I_M_3471);
         _loc1_.addEventListener(obf_N_s_2019.PLAYER_DEVIL_ITEM_CHECK_NOTIFY,this.obf_I_M_3471);
         _loc1_.addEventListener(obf_N_s_2019.PLAYER_DEVIL_UPGRADE_ANSWER,this.obf_I_M_3471);
         _loc1_.addEventListener(obf_N_s_2019.PLAYER_DEVIL_EXP_CHECK_NOTIFY,this.obf_I_M_3471);
         _loc1_.addEventListener(obf_2_p_3844.PLAYER_RE_GROW_ANSWER,this.obf_g_1_2097);
         _loc1_.addEventListener(obf_2_p_3844.PLAYER_IN_OUT_EXP_ANSWER,this.obf_g_1_2097);
         _loc1_.addEventListener(obf_2_p_3844.PLAYER_MAKE_ITEM_ANSWER,this.obf_g_1_2097);
         _loc1_.addEventListener(obf_2_p_3844.PLAYER_RE_GROW_NOTIFY,this.obf_g_1_2097);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_COUNTRY_INFO_NOTIFY,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_UP_COUNTRY_ANSWER,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_UP_LAND_ANSWER,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_WILLS_NOTIFY,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_CREATURES_NOTIFY,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_a_o_3243.PLAYER_ORIGINS_NOTIFY,this.obf_0_A_3373);
         _loc1_.addEventListener(obf_T_d_3612.RIDE_EQUIP_RECREATE_ANSWER,this.obf_0_U_1503);
         _loc1_.addEventListener(obf_T_d_3612.RIDE_EQUIP_REFINE_ANSWER,this.obf_0_U_1503);
         _loc1_.addEventListener(obf_T_d_3612.RIDE_EQUIP_UP_ANSWER,this.obf_0_U_1503);
         _loc1_.addEventListener(obf_T_d_3612.RIDE_EQUIP_INHERIT_ANSWER,this.obf_0_U_1503);
         _loc1_.addEventListener(StarAdventureEventType.PLAYER_STARS_INFO_NOTIFY,this.obf_E_b_2262);
         _loc1_.addEventListener(StarAdventureEventType.PLAYER_STARS_ADVENTURE_ANSWER,this.obf_E_b_2262);
         _loc1_.addEventListener(obf_0_3_4_258.PLAYER_BOOK_TIME_POINT_NOTIFY,this.onBook);
         _loc1_.addEventListener(obf_0_3_4_258.PLAYER_BOOK_UP_ANSWER,this.onBook);
         _loc1_.addEventListener(obf_0_3_4_258.PLAYER_BOOK_INFO_NOTIFY,this.onBook);
         _loc1_.addEventListener(obf_j_C_2813.DEVIL_GOD_INFO_NOTIFY,this.obf_h_x_4567);
         _loc1_.addEventListener(obf_j_C_2813.DEVIL_GOD_USE_MONEY_ANSWER,this.obf_h_x_4567);
         _loc1_.addEventListener(obf_j_C_2813.DEVIL_GOD_EAT_PET_ANSWER,this.obf_h_x_4567);
         _loc1_.addEventListener(obf_0_8_m_288.PLAYER_ANGEL_GOD_NOTIFY,this.obf_x_J_1141);
         _loc1_.addEventListener(obf_0_8_m_288.PLAYER_ANGEL_UP_ANSWER,this.obf_x_J_1141);
         _loc1_.addEventListener(obf_0_8_m_288.PLAYER_ANGEL_GOD_UP_ANSWER,this.obf_x_J_1141);
         _loc1_.addEventListener(obf_0_8_m_288.PLAYER_ANGEL_EQU_ANSWER,this.obf_x_J_1141);
         _loc1_.addEventListener(obf_0_8_m_288.PLAYER_ANGEL_INFO_NOTIFY,this.obf_x_J_1141);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_PLAYER_INFO_NOTIFY,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_ALL_TASK_NOTIFY,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_PLAYER_TASK_NOTIFY,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_SUCCESS_NOTIFY,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_PLAYER_AWARD_ANSWER,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_ALL_INFO_NOTIFY,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_9_p_3031.REWARD_OVER_AWARD_ANSWER,this.obf_d_S_2276);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_INFO_NOTIFY,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_ADD_EXP_ANSWER,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_BLESS_ANSWER,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_BREACH_ANSWER,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_TEMPER_ANSWER,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_s_e_4659.KIND_GROW_TEMPER_SAVE_ANSWER,this.obf_P_6_1851);
         _loc1_.addEventListener(obf_u_K_1604.VAR_SHOP_BUY_ANSWER,this.obf_d_0_3474);
         _loc1_.addEventListener(obf_X_N_2669.SOUL_GUARD_UP_ANSWER,this.obf_M_I_4109);
         _loc1_.addEventListener(obf_X_N_2669.SOUL_BLESS_UP_ANSWER,this.obf_M_I_4109);
         _loc1_.addEventListener(obf_X_N_2669.SOUL_GUARD_INFO_NOTIFY,this.obf_M_I_4109);
         _loc1_.addEventListener(obf_z_c_3994.PLAYER_DIVINE_LEVEL_NOTIFY,this.obf_U_4154);
         _loc1_.addEventListener(obf_z_c_3994.PLAYER_DIVINE_VALUE_NOTIFY,this.obf_U_4154);
         _loc1_.addEventListener(obf_z_c_3994.PLAYER_EQUIPMENT_DIVINE_ANSWER,this.obf_U_4154);
         _loc1_.addEventListener(obf_0_3_t_580.POCKET_ADD_STONE_ANSWER,this.obf_I_4656);
         _loc1_.addEventListener(obf_0_3_t_580.POCKET_ITEM_IN_OUT_ANSWER,this.obf_I_4656);
         _loc1_.addEventListener(obf_0_3_t_580.POCKET_INFO_NOTIFY,this.obf_I_4656);
         _loc1_.addEventListener(obf_Y_2_3616.BLOODY_WAR_INFO_NOTIFY,this.obf_B_P_3374);
         _loc1_.addEventListener(obf_Y_2_3616.BLOODY_WAR_KILL_MONSTER_NOTIFY,this.obf_B_P_3374);
         _loc1_.addEventListener(obf_Y_2_3616.BLOODY_WAR_UP_LEVEL_ANSWER,this.obf_B_P_3374);
         _loc1_.addEventListener(obf_Y_2_3616.BLOODY_WAR_CHANGE_ANSWER,this.obf_B_P_3374);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_TAKE_ANSWER,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_DO_ANSWER,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_OVER_ANSWER,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_SAVE_ANSWER,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_POWER_ANSWER,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_INFO_NOTIFY,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_CHANGE_PRESSURE_TEMP_NOTIFY,this.obf_T_r_860);
         _loc1_.addEventListener(obf_0_3_K_435.INCUBATOR_STATE_NOTIFY,this.obf_T_r_860);
         _loc1_.addEventListener(obf_C_I_3780.LOCK_TOWER_INFO_NOTIFY,this.obf_H_H_1912);
         _loc1_.addEventListener(obf_C_I_3780.LOCK_TOWER_ADD_FLOOR_ANSWER,this.obf_H_H_1912);
         _loc1_.addEventListener(obf_u_O_1177.TREASURY_INFO_NOTIFY,this.obf_P_d_2928);
         _loc1_.addEventListener(obf_u_O_1177.TREASURY_ATTR_NOTIFY,this.obf_P_d_2928);
         _loc1_.addEventListener(obf_u_O_1177.TREASURY_LEVEL_NOTIFY,this.obf_P_d_2928);
         _loc1_.addEventListener(obf_u_O_1177.TREASURY_EXP_NOTIFY,this.obf_P_d_2928);
         _loc1_.addEventListener(obf_u_O_1177.TREASURY_USE_ITEM_ANSWER,this.obf_P_d_2928);
         _loc1_.addEventListener(obf_Q_r_1870.GOD_STYLE_NOTIFY,this.obf_N_e_1940);
         _loc1_.addEventListener(obf_Q_r_1870.GOD_STYLE_RANK_NOTIFY,this.obf_N_e_1940);
         _loc1_.addEventListener(obf_v_7_3503.TREE_INFO_NOTIFY,this.obf_Y_b_3518);
         _loc1_.addEventListener(obf_v_7_3503.TREE_ADD_EXP_ANSWER,this.obf_Y_b_3518);
         _loc1_.addEventListener(obf_v_7_3503.TREE_UP_RANK_ANSWER,this.obf_Y_b_3518);
         _loc1_.addEventListener(obf_v_7_3503.TREE_GET_ITEM_ANSWER,this.obf_Y_b_3518);
         _loc1_.addEventListener(obf_Y_j_4077.MAGIC_CIRCLE_INFO_NOTIFY,this.obf_j_m_4117);
         _loc1_.addEventListener(obf_Y_j_4077.MAGIC_CIRCLE_UP_ANSWER,this.obf_j_m_4117);
         _loc1_.addEventListener(obf_Y_j_4077.MAGIC_CIRCLE_USE_ANSWER,this.obf_j_m_4117);
         _loc1_.addEventListener(obf_k_W_1605.VACANT_SPACE_INFO_NOTIFY,this.obf_y_3_2859);
         _loc1_.addEventListener(obf_k_W_1605.VACANT_SPACE_BALL_UP_ANSWER,this.obf_y_3_2859);
         _loc1_.addEventListener(obf_k_W_1605.VACANT_SPACE_BALL_IN_ANSWER,this.obf_y_3_2859);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_INFO_NOTIFY,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_LOTTERY_ANSWER,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_SUCCESS_ANSWER,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_SUCCESS_AWARD_ANSWER,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_STAR_VALUE_NOTIFY,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_LIST_NOTIFY,this.obf_1_5_4574);
         _loc1_.addEventListener(ItemManualEventType.ITEM_MANUAL_SELL_ANSWER,this.obf_1_5_4574);
         _loc1_.addEventListener(PassTicketEventType.PASS_TICKET_INFO_NOTIFY,this.obf_R_M_4195);
         _loc1_.addEventListener(PassTicketEventType.PASS_TICKET_TASK_NOTIFY,this.obf_R_M_4195);
         _loc1_.addEventListener(PassTicketEventType.PASS_TICKET_AWARD_INFO_NOTIFY,this.obf_R_M_4195);
         _loc1_.addEventListener(PassTicketEventType.PASS_TICKET_SYS_INFO_NOTIFY,this.obf_R_M_4195);
         _loc1_.addEventListener(obf_m_8_3515.PLAYER_FEED_GOD_ANSWER,this.obf_4_C_4325);
         _loc1_.addEventListener(obf_m_8_3515.PLAYER_FEED_GOD_NOTIFY,this.obf_4_C_4325);
         _loc1_.addEventListener(obf_m_8_3515.PLAYER_REFINE_GOD_ANSWER,this.obf_4_C_4325);
         _loc1_.addEventListener(obf_m_8_3515.PLAYER_SUM_GOD_ANSWER,this.obf_4_C_4325);
         _loc1_.addEventListener(obf_m_8_3515.PLAYER_USE_GOD_ANSWER,this.obf_4_C_4325);
         _loc1_.addEventListener(obf_Z_2_4564.FORGE_GOD_INFO_NOTIFY,this.obf_K_C_3785);
         _loc1_.addEventListener(obf_Z_2_4564.FORGE_GOD_VALUE_NOTIFY,this.obf_K_C_3785);
         _loc1_.addEventListener(obf_t_x_2606.SKILL_LEVEL_NOTIFY,this.obf_e_2_2629);
         _loc1_.addEventListener(obf_t_x_2606.SKILL_USE_NOTIFY,this.obf_e_2_2629);
         _loc1_.addEventListener(obf_H_J_3193.MAKE_KEY_ANSWER,this.obf_7_a_1137);
         _loc1_.addEventListener(obf_H_J_3193.OPEN_BOX_ANSWER,this.obf_7_a_1137);
         _loc1_.addEventListener(obf_H_J_3193.BREAK_CHIP_ANSWER,this.obf_7_a_1137);
         _loc1_.addEventListener(obf_H_J_3193.MAKE_CHIP_ANSWER,this.obf_7_a_1137);
         _loc1_.addEventListener(obf_H_J_3193.MAKE_CHIP_INFO_NOTIFY,this.obf_7_a_1137);
         _loc1_.addEventListener(obf_H_J_3193.FREE_GET_BAD_KEY_ANSWER,this.obf_7_a_1137);
      }
      
      private function removeListener() : void
      {
         var thisClient:obf_u_d_1452;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         try
         {
            this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.obf_G_M_4309);
         }
         catch(e:Error)
         {
         }
         GameContext.worldClient.removeEventListener(obf_l_N_3214.obf_N_7_3895,this.obf_J_H_4400);
         this._mapManager.removeEventListener(MapManagerEvent.MAP_START_LOAD,this.onMapStartLoad);
         this._mapManager.removeEventListener(MapManagerEvent.MAP_CREATE_COMPLETE,this.onMapCreateComplete);
         thisClient = GameContext.worldClient;
         thisClient.removeEventListener(WorldSystemEventType.WORLD_PING_ECHO,this.obf_e_m_3644);
         thisClient.removeEventListener(WorldSystemEventType.WORLD_TIME_CHECK_NOTIFY,this.obf_p_a_c_k_a_g_e_30);
         thisClient.removeEventListener(WorldSystemEventType.SYS_VAR_CHANGE_NOTIFY,this.obf_6_p_864);
         thisClient.removeEventListener(WorldSystemEventType.SYS_VAR_CLEAR_NOTIFY,this.obf_h_A_3414);
         thisClient.removeEventListener(PlayerEventType.PLAYER_ENTER_WORLD_ANSWER,this.onEnterWorld);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LEAVE_WORLD_ANSWER,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_ENTER_MAP_ANSWER,this.onEnterMap);
         thisClient.removeEventListener(PlayerEventType.PLAYER_VIEW_MAP_ANSWER,this.onViewMap);
         thisClient.removeEventListener(PlayerEventType.PLAYER_POSITION_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_BUFF_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_HP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_HPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_MP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_MPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_DIED_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SKILL_INTERRUPTED_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LUCKY_SKILL_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_REBIRTH_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SKILL_CD_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_XP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_XPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SPMAX_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_ATTRIBUTES_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_GOLD_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_MONEY_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_COIN_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_USE_MOTION_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_STATUS_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_HAIR_STYLE_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_MSG_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_SYS_PROMPT_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SHOW_TALKS_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RIDE_STATE_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_USING_RIDE_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RIDE_ITEM_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_RIDE_FUSION_ANSWER,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LIFE_EXP_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LIFE_JOB_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LIFE_LEVEL_UP_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_VIEW_REMOTE_ANSWER,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_PK_MODE_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_PK_VALUE_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_KILLED_MONSTER_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_DO_CLIENT_MACRO_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_COUNTER_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LEARNED_SKILLS_CHECK_NOTIFY,this.obf_2_S_2318);
         thisClient.removeEventListener(PlayerEventType.PLAYER_LEARNED_SKILL_NOTIFY,this.obf_2_S_2318);
         thisClient.removeEventListener(PlayerEventType.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_VIP_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_TITLE_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_KIT_TITLE_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_TITLE_LIST_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_SIDE_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_BELIEF_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_MAP_HONOR_CHECK_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_CALL_TRAINER_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.PLAYER_CHANGE_MODEL_NOTIFY,this.obf_a_0_2514);
         thisClient.removeEventListener(PlayerEventType.obf_h_i_3566,this.obf_a_0_2514);
         thisClient.removeEventListener(MateEventType.PLAYER_MATE_RELATION_CHECK_NOTIFY,this.obf_5_H_3100);
         thisClient.removeEventListener(MateEventType.PLAYER_MATE_VAR_CHANGE_NOTIFY,this.obf_5_H_3100);
         thisClient.removeEventListener(MateEventType.PLAYER_MATE_VAR_CLEAR_NOTIFY,this.obf_5_H_3100);
         thisClient.removeEventListener(FriendEvent.PLAYER_ADD_FRIEND_ANSWER,this.obf_0_0_X_268);
         thisClient.removeEventListener(FriendEvent.PLAYER_FRIEND_CHECK_NOTIFY,this.obf_0_0_X_268);
         thisClient.removeEventListener(FriendEvent.PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY,this.obf_0_0_X_268);
         thisClient.removeEventListener(FriendEvent.PLAYER_REMOVED_FRIEND_NOTIFY,this.obf_0_0_X_268);
         thisClient.removeEventListener(FriendEvent.PLAYER_RECEIVE_GIFT_NOTIFY,this.obf_0_0_X_268);
         thisClient.removeEventListener(NpcEvent.NPC_ASSEMBLE_ITEM_ANSWER,this.obf_0_u_3276);
         thisClient.removeEventListener(NpcEvent.NPC_Function_ANSWER,this.obf_0_u_3276);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_ADDED_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_LIST_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_MEMBER_REMOVED_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_MY_INFO_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_INVITE_FAMILY_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_LIST_FAMILY_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_RECEIVE_INVITE_FAMILY_REQUEST_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_VIEW_FAMILY_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_VIEW_JOIN_FAMILY_LIST_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_DECLARATION_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_NOTICE_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_VIEW_FAMILY_POST_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_LIST_FAMILY_TASK_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_VARS_CHECK_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_VAR_CHANGE_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_VAR_CLEAR_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.LIST_FAMILY_INT_VAR_ANSWER,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_INVENT_SKILL_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(FamilyEvent.PLAYER_FAMILY_BOSS_CALL_NOTIFY,this.obf_f_Y_3549);
         thisClient.removeEventListener(TeamEventType.PLAYER_GIVE_TEAM_LEADER_ANSWER,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_INVITE_TEAM_ANSWER,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_JOIN_TEAM_ANSWER,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_RECEIVE_GIVE_TEAM_LEADER_REQUEST_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_CHECK_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_LEADER_CHANGE_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_MEMBER_CHECK_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_MEMBER_MP_CHANGE_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_ROLL_ITEM_ANSWER,this.obf_u_V_3362);
         thisClient.removeEventListener(TeamEventType.PLAYER_TEAM_ROLL_RESULT_NOTIFY,this.obf_u_V_3362);
         thisClient.removeEventListener(TaskEventType.PLAYER_RECEIVE_TASK_NOTIFY,this.obf_w_H_3965);
         thisClient.removeEventListener(TaskEventType.PLAYER_FINISH_TASK_NOTIFY,this.obf_w_H_3965);
         thisClient.removeEventListener(TaskEventType.PLAYER_ABORT_TASK_NOTIFY,this.obf_w_H_3965);
         thisClient.removeEventListener(obf_g_W_3605.PLAYER_FINISH_SUCCESS_NOTIFY,this.obf_Q_v_4401);
         thisClient.removeEventListener(obf_g_W_3605.PLAYER_SUCCESS_INFO_NOTIFY,this.obf_Q_v_4401);
         thisClient.removeEventListener(obf_g_W_3605.WORLD_SUCCESS_TIMES_ANSWER,this.obf_Q_v_4401);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_ENTER_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_LEAVE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_POSITION_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_USE_SKILL_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_SKILL_INTERRUPTED_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_HP_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_MP_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_BUFF_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_LEVEL_UP_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_LUCKY_SKILL_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_DIED_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_REBIRTH_LOCALLY_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_EQUIPMENT_MODEL_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_USE_MOTION_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_STATUS_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_RIDE_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_GENIE_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_PET_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_BLESS_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_BOOTH_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_VIP_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_HONOR_LEVEL_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_PK_MODE_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_PK_VALUE_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_TEAM_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_FAMILY_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_MATE_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_HAIR_STYLE_CHANGE_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_SIDE_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_DRAGON_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_CALL_TRAINER_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_DEVIL_CHECK_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(RemotePlayerEventType.REMOTE_CHANGE_MODEL_NOTIFY,this.obf_4_L_4387);
         thisClient.removeEventListener(MonsterEventType.MONSTER_BORN_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_MOVE_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_POSITION_CHECK_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_BUFF_CHANGE_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_DIE_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_HP_CHANGE_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(MonsterEventType.MONSTER_USE_SKILL_NOTIFY,this.obf_0_Q_759);
         thisClient.removeEventListener(obf_l_U_3504.MAP_ITEM_ADDED_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_ITEM_REMOVED_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_VAR_CHANGE_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_VAR_CLEAR_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_REFRESH_NPC_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_NPC_SAY_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_DAMAGE_RANK_CHECK_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_DAMAGE_VALUE_CHECK_NOTIFY,this.obf_6_z_4094);
         thisClient.removeEventListener(obf_l_U_3504.MAP_CLEAR_INFO_CHECK_NOTIFY,this.obf_c_3_2666);
         thisClient.removeEventListener(obf_l_U_3504.MAP_CLEARED_NOTIFY,this.obf_c_3_2666);
         thisClient.removeEventListener(obf_l_U_3504.MAP_CLEAR_BONUS_ANSWER,this.obf_c_3_2666);
         thisClient.removeEventListener(obf_l_U_3504.MAP_TOWER_NOTIFY,this.obf_0_3_G_585);
         thisClient.removeEventListener(obf_d_4670.MAP_TRAP_ADDED_NOTIFY,this.obf_g_J_1920);
         thisClient.removeEventListener(obf_d_4670.MAP_TRAP_REMOVED_NOTIFY,this.obf_g_J_1920);
         thisClient.removeEventListener(obf_d_4670.MAP_TRAP_USE_SKILL_NOTIFY,this.obf_g_J_1920);
         thisClient.removeEventListener(obf_0_5_c_303.BLESS_CHECK_NOTIFY,this.obf_7_M_4450);
         thisClient.removeEventListener(obf_0_5_c_303.BLESS_SOLD_NOTIFY,this.obf_7_M_4450);
         thisClient.removeEventListener(obf_0_5_c_303.BLESS_VISIT_ANSWER,this.obf_7_M_4450);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_BAG_CAPACITY_CHANGE_NOTIFY,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_BAG_CHECK_NOTIFY,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_ITEM_USED_NOTIFY,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_ITEM_ADDED_NOTIFY,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_ITEM_CD_CHECK_NOTIFY,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PlayerBagEventType.PLAYER_VIEW_ITEM_ANSWER,this.obf_Q_Z_1048);
         thisClient.removeEventListener(PetEventType.PET_CHECK_NOTIFY,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_ATTR_INT_CHANGE_NOTIFY,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_USE_SKILL_NOTIFY,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_LEARN_SKILL_ANSWER,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_HP_CHANGE_NOTIFY,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_ENHANCE_ANSWER,this.obf_5_p_2638);
         thisClient.removeEventListener(PetEventType.PET_FUSION_ANSWER,this.obf_5_p_2638);
         thisClient.removeEventListener(obf_o_o_1182.PLAYER_GENIE_EXP_CHECK_NOTIFY,this.obf_0_6_d_648);
         thisClient.removeEventListener(obf_o_o_1182.PLAYER_GENIE_ITEM_CHECK_NOTIFY,this.obf_0_6_d_648);
         thisClient.removeEventListener(obf_o_o_1182.PLAYER_GENIE_UPGRADE_ANSWER,this.obf_0_6_d_648);
         thisClient.removeEventListener(obf_o_o_1182.PLAYER_USING_GENIE_CHECK_NOTIFY,this.obf_0_6_d_648);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_MOVE_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_USE_SKILL_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_HP_CHANGE_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_ATTRIBUTES_CHANGE_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_ENTER_TRAINER_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(AnimalEventType.ANIMAL_BUFF_CHANGE_NOTIFY,this.obf_S_E_3433);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_DISEMBED_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_EMBED_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_HOLE_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_REFINE_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_UPGRADE_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_FUSION_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_WASH_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_HOLESKILL_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_HOST_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_CLEAN_SKILL_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_LETTERING_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_UP_EQU_EXP_ANSWER,this.obf_0_1_V_721);
         thisClient.removeEventListener(AgentEventType.AGENT_LIST_ITEM_ANSWER,this.obf_1_j_999);
         thisClient.removeEventListener(AgentEventType.AGENT_VIEW_MY_ITEMS_ANSWER,this.obf_1_j_999);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_INVITE_TRADE_ANSWER,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_RECEIVE_INVITE_TRADE_REQUEST_NOTIFY,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_TRADE_BEGIN_NOTIFY,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_TRADE_CONFIRM_NOTIFY,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_TRADE_END_NOTIFY,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_TRADE_ITEM_SUBMIT_NOTIFY,this.obf_8_3126);
         thisClient.removeEventListener(obf_0_2_J_653.PLAYER_TRADE_CHECK_ANSWER,this.obf_8_3126);
         thisClient.removeEventListener(BoothEvent.BOOTH_CHECK_NOTIFY,this.obf_0_2_U_535);
         thisClient.removeEventListener(BoothEvent.BOOTH_ITEM_SOLD_NOTIFY,this.obf_0_2_U_535);
         thisClient.removeEventListener(BoothEvent.BOOTH_VISIT_ANSWER,this.obf_0_2_U_535);
         thisClient.removeEventListener(BoothEvent.BOOTH_ITEM_PURCHASED_NOTIFY,this.obf_0_2_U_535);
         thisClient.removeEventListener(PlayerEquipEventType.PLAYER_EQUIPMENT_CHECK_NOTIFY,this.obf_M_L_4488);
         thisClient.removeEventListener(PlayerEquipEventType.PLAYER_SWITCH_FASHION_NOTIFY,this.obf_M_L_4488);
         thisClient.removeEventListener(PlayerEquipEventType.PLAYER_REPAIR_EQUIPMENT_ANSWER,this.obf_M_L_4488);
         thisClient.removeEventListener(PlayerEquipEventType.PLAYER_VIEW_REPAIR_INFO_ANSWER,this.obf_M_L_4488);
         thisClient.removeEventListener(PlayerEquipEventType.PLAYER_EQUIP_DUR_CHECK_NOTIFY,this.obf_M_L_4488);
         thisClient.removeEventListener(FarmEventType.FARM_BUILDING_ADDED_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_BUILDING_REMOVED_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_CHECK_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_LIST_CHECK_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_EXP_CHANGE_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_HARVEST_ADDED_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_HARVEST_CHECK_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_HARVEST_REMOVED_NOTIFY,this.onFarmCommand);
         thisClient.removeEventListener(FarmEventType.FARM_HARVEST_QUERY_ANSWER,this.onFarmCommand);
         thisClient.removeEventListener(SysMsgEventType.SYSMSG_NEW_NOTIFY,this.obf_k_y_3983);
         thisClient.removeEventListener(SysMsgEventType.SYSMSG_VIEW_ANSWER,this.obf_k_y_3983);
         thisClient.removeEventListener(obf_0_5_2_727.MAIL_LIST_ANSWER,this.obf_2_h_1719);
         thisClient.removeEventListener(obf_0_5_2_727.MAIL_NEW_NOTIFY,this.obf_2_h_1719);
         thisClient.removeEventListener(obf_0_5_2_727.MAIL_SEND_ANSWER,this.obf_2_h_1719);
         thisClient.removeEventListener(obf_0_5_2_727.MAIL_VIEW_ANSWER,this.obf_2_h_1719);
         thisClient.removeEventListener(obf_L_g_3260.LOTTERY_LOG_NOTIFY,this.obf_I_R_2814);
         thisClient.removeEventListener(obf_L_g_3260.LOTTERY_ANSWER,this.obf_I_R_2814);
         thisClient.removeEventListener(obf_L_g_3260.GAMBLE_START_ANSWER,this.obf_I_R_2814);
         thisClient.removeEventListener(obf_L_g_3260.GAMBLE_STOP_ANSWER,this.obf_I_R_2814);
         thisClient.removeEventListener(obf_L_g_3260.PLAYER_FETCHED_ONLINEAWARD_NOTIFY,this.obf_I_R_2814);
         thisClient.removeEventListener(OnlineBonusEventType.ONLINE_BONUS_CHECK_NOTIFY,this.obf_s_3_4097);
         thisClient.removeEventListener(OnlineBonusEventType.ONLINE_COIN_CHECK_NOTIFY,this.obf_s_3_4097);
         thisClient.removeEventListener(OnlineBonusEventType.OFFLINE_BONUS_CHECK_NOTIFY,this.obf_s_3_4097);
         thisClient.removeEventListener(OnlineBonusEventType.OFFLINE_BONUS_FETCH_ANSWER,this.obf_s_3_4097);
         thisClient.removeEventListener(OnlineBonusEventType.obf_0_8_k_656,this.obf_s_3_4097);
         thisClient.removeEventListener(OnlineBonusEventType.obf_0_0_W_474,this.obf_s_3_4097);
         thisClient.removeEventListener(obf_0___m_220.ROBOT_STATUS_CHECK_NOTIFY,this.obf_6_l_3314);
         thisClient.removeEventListener(RankingEventType.RANKING_LIST_VIEW_ANSWER,this.obf_P_F_2419);
         thisClient.removeEventListener(GMEventType.GM_COMMAND_ANSWER,this.obf_8_U_1246);
         thisClient.removeEventListener(MiscEvent.USE_GIFT_CDKEY_ANSWER,this.obf_X_i_1835);
         thisClient.removeEventListener(obf_0_3_Q_292.ACTIVITY_CHECK_ALL_NOTIFY,this.obf_0_9_A_165);
         thisClient.removeEventListener(obf_0_3_Q_292.ACTIVITY_CHECK_ONE_NOTIFY,this.obf_0_9_A_165);
         thisClient.removeEventListener(obf_0_3_Q_292.PAY_MARK_ACTIVITY_NOTIFY,this.obf_0_9_A_165);
         thisClient.removeEventListener(MiscEvent.PIS_CHECK_NOTIFY,this.obf_0_s_4505);
         thisClient.removeEventListener(ShopEventType.LEAD_ITEM_INFO_NOTIFY,this.obf_4_V_1484);
         thisClient.removeEventListener(ShopEventType.obf_d_9_3617,this.obf_4_V_1484);
         thisClient.removeEventListener(PlayingCardEvent.PLAYER_CARD_START_ANSWER,this.obf_6_e_3438);
         thisClient.removeEventListener(PlayingCardEvent.PLAYER_CARD_TURN_ANSWER,this.obf_6_e_3438);
         thisClient.removeEventListener(PlayingCardEvent.PLAYER_CARD_TURN_NOTIFY,this.obf_6_e_3438);
         thisClient.removeEventListener(PlayingCardEvent.PLAYER_CARD_GAME_TIMES_NOTIFY,this.obf_6_e_3438);
         thisClient.removeEventListener(PlayingCardEvent.PLAYER_CARD_BOUN_ANSWER,this.obf_6_e_3438);
         thisClient.removeEventListener(ConstellationEventType.SET_PLAYER_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.RESET_PLAYER_CONSTELLATION_NOTIFY,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.LUCK_CHANGE_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.LUCK_GET_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.UP_PLAYER_CONSTELLATION_ANSWER,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.CONSTELLATION_LUCK_NOTIFY,this.obf_b_F_3825);
         thisClient.removeEventListener(ConstellationEventType.CONSTELLATION_TASK_NOTIFY,this.obf_b_F_3825);
         thisClient.removeEventListener(StirpEventType.PLAYER_STIRP_LVUP_ANSWER,this.obf_1_n_3102);
         thisClient.removeEventListener(StirpEventType.PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY,this.obf_1_n_3102);
         thisClient.removeEventListener(ArmoryEventType.PLAYER_ARMORY_UPGRADE_ANSWER,this.obf_S_K_2573);
         thisClient.removeEventListener(ArmoryEventType.PLAYER_ARMORY_PROPERTY_NOTIFY,this.obf_S_K_2573);
         thisClient.removeEventListener(ArmoryEventType.PLAYER_ARMORY_UPGRADE_NOTIFY,this.obf_S_K_2573);
         thisClient.removeEventListener(BoneEventType.BONE_MELT_ANSWER,this.obf_2_r_3018);
         thisClient.removeEventListener(BoneEventType.BONE_REFINE_ANSWER,this.obf_2_r_3018);
         thisClient.removeEventListener(BoneEventType.BONE_UP_LEVEL_ANSWER,this.obf_2_r_3018);
         thisClient.removeEventListener(BoneEventType.BONE_ATTR_ANSWER,this.obf_2_r_3018);
         thisClient.removeEventListener(BoneEventType.BONE_OPEN_ANSWER,this.obf_2_r_3018);
         thisClient.removeEventListener(DragonEventType.PLAYER_DRAGON_CHECK_NOTIFY,this.obf_4_N_1466);
         thisClient.removeEventListener(DragonEventType.PLAYER_DRAGON_UPGRADE_ANSWER,this.obf_4_N_1466);
         thisClient.removeEventListener(DragonEventType.PLAYER_BUY_UP_CHANCE_ANSWER,this.obf_4_N_1466);
         thisClient.removeEventListener(TowerEventType.CLICK_LVUP_TOWER_ANSWER,this.obf_0_3_G_585);
         thisClient.removeEventListener(obf_l_4690.GLYPH_INFO_NOTIFY,this.obf_w_U_2533);
         thisClient.removeEventListener(obf_l_4690.GLYPH_MASTER_ANSWER,this.obf_w_U_2533);
         thisClient.removeEventListener(obf_l_4690.GLYPH_UP_ANSWER,this.obf_w_U_2533);
         thisClient.removeEventListener(obf_l_4690.GLYPH_UP_MASTER_NOTIFY,this.obf_w_U_2533);
         thisClient.removeEventListener(MonsterManualEventType.MANUAL_ABSORB_ANSWER,this.obf_6_S_4390);
         thisClient.removeEventListener(MonsterManualEventType.MANUAL_VIEW_ANSWER,this.obf_6_S_4390);
         thisClient.removeEventListener(activityBoxEventType.CONSUME_RANK_ITEM_NOTIFY,this.obf_0_6_J_537);
         thisClient.removeEventListener(activityBoxEventType.CONSUME_RANK_NOTIFY,this.obf_0_6_J_537);
         thisClient.removeEventListener(obf_Y_L_3484.PLAYER_FAVOR_OFFER_ANSWER,this.obf_0_4_4_636);
         thisClient.removeEventListener(ChallengeEventType.ROBOT_OPEN_ANSWER,this.obf_c_Y_1385);
         thisClient.removeEventListener(ChallengeEventType.ROBOT_ADD_CHANCE_ANSWER,this.obf_c_Y_1385);
         thisClient.removeEventListener(ChallengeEventType.ROBOT_CHALLENGE_RESULT_NOTIFY,this.obf_c_Y_1385);
         thisClient.removeEventListener(ChallengeEventType.ROBOT_REPORT_NOTIFY,this.obf_c_Y_1385);
         thisClient.removeEventListener(ChallengeEventType.ROBOT_AWARD_NOTIFY,this.obf_c_Y_1385);
         thisClient.removeEventListener(obf_Y_w_3400.GOD_SOUL_EQUIPMENT_NOTIFY,this.onGodSoul);
         thisClient.removeEventListener(obf_Y_w_3400.GOD_SOUL_INFO_NOTIFY,this.onGodSoul);
         thisClient.removeEventListener(obf_0_5_6_294.REMARK_TIMEINFO_NOTIFY,this.obf_n_f_2241);
         thisClient.removeEventListener(obf_0_5_6_294.REMARK_EXTRACTANT_UP_LV_ANSWER,this.obf_n_f_2241);
         thisClient.removeEventListener(AegisBoxEventType.PLAYER_AEGIS_NOTIFY,this.obf_K_D_4494);
         thisClient.removeEventListener(AegisBoxEventType.PLAYER_PRAY_ANSWER,this.obf_K_D_4494);
         thisClient.removeEventListener(AegisBoxEventType.PLAYER_UP_LEVEL_ANSWER,this.obf_K_D_4494);
         thisClient.removeEventListener(AegisBoxEventType.PLAYER_UPDATE_ANSWER,this.obf_K_D_4494);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_BLOOD_UP_ANSWER,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_BUY_ATTR_MAX_ANSWER,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_EAT_ANSWER,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_INFO_NOTIFY,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_LV_AT_NOTIFY,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_STUDY_ANSWER,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_TRAVEL_ANSWER,this.obf_0_3_C_527);
         thisClient.removeEventListener(BabyEventType.PLAYER_BABY_FOOD_NOTIFY,this.obf_0_3_C_527);
         thisClient.removeEventListener(FateTurntableEventType.START_TURNTABLE_ANSWER,this.obf_f_Z_1205);
         thisClient.removeEventListener(FateTurntableEventType.FATE_UP_LEVEL_ANSWER,this.obf_f_Z_1205);
         thisClient.removeEventListener(FateTurntableEventType.FATE_TURNTABLE_VALUE_NOTIFY,this.obf_f_Z_1205);
         thisClient.removeEventListener(FateTurntableEventType.FATE_TURNTABLE_INFO_NOTIFY,this.obf_f_Z_1205);
         thisClient.removeEventListener(LegendEventType.LEGEND_EMBED_ANSWER,this.onLegend);
         thisClient.removeEventListener(LegendEventType.LEGEND_HOLE_ANSWER,this.onLegend);
         thisClient.removeEventListener(LegendEventType.LEGEND_REMOVE_ANSWER,this.onLegend);
         thisClient.removeEventListener(LegendEventType.LEGENG_UP_LEVEL_ANSWER,this.onLegend);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_SOUL_ANSWER,this.obf_0_8_c_555);
         thisClient.removeEventListener(ArtifactEventType.ARTIFACT_SOUL_MOVE_ANSWER,this.obf_0_8_c_555);
         thisClient.removeEventListener(CloakEventType.PLAYER_CLOAK_CHIP_NOTIFY,this.obf_B_i_1578);
         thisClient.removeEventListener(CloakEventType.PLAYER_CLOAK_GET_UP_ANSWER,this.obf_B_i_1578);
         thisClient.removeEventListener(CloakEventType.PLAYER_CLOAK_GLYPH_NOTIFY,this.obf_B_i_1578);
         thisClient.removeEventListener(CloakEventType.PLAYER_CLOAK_MELT_ANSWER,this.obf_B_i_1578);
         thisClient.removeEventListener(PetDepotEventType.PETDEPOT_ITEMS_NOYIFY,this.obf_w_s_4568);
         thisClient.removeEventListener(PetDepotEventType.PETDEPOT_UPLEVEL_ANSWER,this.obf_w_s_4568);
         thisClient.removeEventListener(RideDepotEventType.RIDEDEPOT_ITEMS_NOYIFY,this.obf_0___F_149);
         thisClient.removeEventListener(RideDepotEventType.RIDEDEPOT_UPLEVEL_ANSWER,this.obf_0___F_149);
         thisClient.removeEventListener(TotemEventType.TOTEM_INFO_NOTIFY,this.obf_z_P_4385);
         thisClient.removeEventListener(TotemEventType.TOTEM_UP_LEVEL_STAGE_ANSWER,this.obf_z_P_4385);
         thisClient.removeEventListener(WardrobeEventType.WARDRODE_UPLEVEL_ANSWER,this.obf_U_x_3272);
         thisClient.removeEventListener(WardrobeEventType.WARDRODE_ITEMS_NOYIFY,this.obf_U_x_3272);
         thisClient.removeEventListener(obf_s_7_755.PLAYER_CHRISTMAS_DRAW_ANSWER,this.obf_0_1_s_80);
         thisClient.removeEventListener(obf_s_7_755.PLAYER_CHRISTMAS_POST_NOTIFY,this.obf_0_1_s_80);
         thisClient.removeEventListener(obf_s_7_755.PLAYER_CHRISTMAS_VALUE_NOTIFY,this.obf_0_1_s_80);
         thisClient.removeEventListener(obf_s_L_1872.PLAYER_RUN_ONLINE_TIME_NOTIFY,this.obf_0_6_m_89);
         thisClient.removeEventListener(obf_s_L_1872.PLAYER_RUN_AWARD_NOTIFY,this.obf_0_6_m_89);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_BUY_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_BUY_NUM_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_REBATE_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_WELFARE_REWARD_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_REBATE_TIMES_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(FundEventType.PLAYER_FUND_CREDIT_NOTIFY,this.obf_R_4671);
         thisClient.removeEventListener(WingSpiritEventType.PLAYER_WING_SPIRIT_ANSWER,this.obf_x_N_3059);
         thisClient.removeEventListener(obf_N_s_2019.PLAYER_USING_DEVIL_CHECK_NOTIFY,this.obf_I_M_3471);
         thisClient.removeEventListener(obf_N_s_2019.PLAYER_DEVIL_ITEM_CHECK_NOTIFY,this.obf_I_M_3471);
         thisClient.removeEventListener(obf_N_s_2019.PLAYER_DEVIL_UPGRADE_ANSWER,this.obf_I_M_3471);
         thisClient.removeEventListener(obf_N_s_2019.PLAYER_DEVIL_EXP_CHECK_NOTIFY,this.obf_I_M_3471);
         thisClient.removeEventListener(obf_2_p_3844.PLAYER_RE_GROW_ANSWER,this.obf_g_1_2097);
         thisClient.removeEventListener(obf_2_p_3844.PLAYER_IN_OUT_EXP_ANSWER,this.obf_g_1_2097);
         thisClient.removeEventListener(obf_2_p_3844.PLAYER_MAKE_ITEM_ANSWER,this.obf_g_1_2097);
         thisClient.removeEventListener(obf_2_p_3844.PLAYER_RE_GROW_NOTIFY,this.obf_g_1_2097);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_COUNTRY_INFO_NOTIFY,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_UP_COUNTRY_ANSWER,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_UP_LAND_ANSWER,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_WILLS_NOTIFY,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_CREATURES_NOTIFY,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_a_o_3243.PLAYER_ORIGINS_NOTIFY,this.obf_0_A_3373);
         thisClient.removeEventListener(obf_T_d_3612.RIDE_EQUIP_RECREATE_ANSWER,this.obf_0_U_1503);
         thisClient.removeEventListener(obf_T_d_3612.RIDE_EQUIP_REFINE_ANSWER,this.obf_0_U_1503);
         thisClient.removeEventListener(obf_T_d_3612.RIDE_EQUIP_UP_ANSWER,this.obf_0_U_1503);
         thisClient.removeEventListener(obf_T_d_3612.RIDE_EQUIP_INHERIT_ANSWER,this.obf_0_U_1503);
         thisClient.removeEventListener(StarAdventureEventType.PLAYER_STARS_INFO_NOTIFY,this.obf_E_b_2262);
         thisClient.removeEventListener(StarAdventureEventType.PLAYER_STARS_ADVENTURE_ANSWER,this.obf_E_b_2262);
         thisClient.removeEventListener(obf_0_3_4_258.PLAYER_BOOK_TIME_POINT_NOTIFY,this.onBook);
         thisClient.removeEventListener(obf_0_3_4_258.PLAYER_BOOK_UP_ANSWER,this.onBook);
         thisClient.removeEventListener(obf_0_3_4_258.PLAYER_BOOK_INFO_NOTIFY,this.onBook);
         thisClient.removeEventListener(obf_j_C_2813.DEVIL_GOD_INFO_NOTIFY,this.obf_h_x_4567);
         thisClient.removeEventListener(obf_j_C_2813.DEVIL_GOD_USE_MONEY_ANSWER,this.obf_h_x_4567);
         thisClient.removeEventListener(obf_j_C_2813.DEVIL_GOD_EAT_PET_ANSWER,this.obf_h_x_4567);
         thisClient.removeEventListener(obf_0_8_m_288.PLAYER_ANGEL_GOD_NOTIFY,this.obf_x_J_1141);
         thisClient.removeEventListener(obf_0_8_m_288.PLAYER_ANGEL_UP_ANSWER,this.obf_x_J_1141);
         thisClient.removeEventListener(obf_0_8_m_288.PLAYER_ANGEL_GOD_UP_ANSWER,this.obf_x_J_1141);
         thisClient.removeEventListener(obf_0_8_m_288.PLAYER_ANGEL_EQU_ANSWER,this.obf_x_J_1141);
         thisClient.removeEventListener(obf_0_8_m_288.PLAYER_ANGEL_INFO_NOTIFY,this.obf_x_J_1141);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_PLAYER_INFO_NOTIFY,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_ALL_TASK_NOTIFY,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_PLAYER_TASK_NOTIFY,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_SUCCESS_NOTIFY,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_PLAYER_AWARD_ANSWER,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_ALL_INFO_NOTIFY,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_9_p_3031.REWARD_OVER_AWARD_ANSWER,this.obf_d_S_2276);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_INFO_NOTIFY,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_ADD_EXP_ANSWER,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_BLESS_ANSWER,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_BREACH_ANSWER,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_TEMPER_ANSWER,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_s_e_4659.KIND_GROW_TEMPER_SAVE_ANSWER,this.obf_P_6_1851);
         thisClient.removeEventListener(obf_u_K_1604.VAR_SHOP_BUY_ANSWER,this.obf_d_0_3474);
         thisClient.removeEventListener(obf_X_N_2669.SOUL_GUARD_UP_ANSWER,this.obf_M_I_4109);
         thisClient.removeEventListener(obf_X_N_2669.SOUL_BLESS_UP_ANSWER,this.obf_M_I_4109);
         thisClient.removeEventListener(obf_X_N_2669.SOUL_GUARD_INFO_NOTIFY,this.obf_M_I_4109);
         thisClient.removeEventListener(obf_z_c_3994.PLAYER_DIVINE_LEVEL_NOTIFY,this.obf_U_4154);
         thisClient.removeEventListener(obf_z_c_3994.PLAYER_DIVINE_VALUE_NOTIFY,this.obf_U_4154);
         thisClient.removeEventListener(obf_z_c_3994.PLAYER_EQUIPMENT_DIVINE_ANSWER,this.obf_U_4154);
         thisClient.removeEventListener(obf_0_3_t_580.POCKET_ADD_STONE_ANSWER,this.obf_I_4656);
         thisClient.removeEventListener(obf_0_3_t_580.POCKET_ITEM_IN_OUT_ANSWER,this.obf_I_4656);
         thisClient.removeEventListener(obf_0_3_t_580.POCKET_INFO_NOTIFY,this.obf_I_4656);
         thisClient.removeEventListener(obf_Y_2_3616.BLOODY_WAR_INFO_NOTIFY,this.obf_B_P_3374);
         thisClient.removeEventListener(obf_Y_2_3616.BLOODY_WAR_KILL_MONSTER_NOTIFY,this.obf_B_P_3374);
         thisClient.removeEventListener(obf_Y_2_3616.BLOODY_WAR_UP_LEVEL_ANSWER,this.obf_B_P_3374);
         thisClient.removeEventListener(obf_Y_2_3616.BLOODY_WAR_CHANGE_ANSWER,this.obf_B_P_3374);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_TAKE_ANSWER,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_DO_ANSWER,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_OVER_ANSWER,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_SAVE_ANSWER,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_POWER_ANSWER,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_INFO_NOTIFY,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_CHANGE_PRESSURE_TEMP_NOTIFY,this.obf_T_r_860);
         thisClient.removeEventListener(obf_0_3_K_435.INCUBATOR_STATE_NOTIFY,this.obf_T_r_860);
         thisClient.removeEventListener(obf_C_I_3780.LOCK_TOWER_INFO_NOTIFY,this.obf_H_H_1912);
         thisClient.removeEventListener(obf_C_I_3780.LOCK_TOWER_ADD_FLOOR_ANSWER,this.obf_H_H_1912);
         thisClient.removeEventListener(obf_u_O_1177.TREASURY_INFO_NOTIFY,this.obf_P_d_2928);
         thisClient.removeEventListener(obf_u_O_1177.TREASURY_ATTR_NOTIFY,this.obf_P_d_2928);
         thisClient.removeEventListener(obf_u_O_1177.TREASURY_LEVEL_NOTIFY,this.obf_P_d_2928);
         thisClient.removeEventListener(obf_u_O_1177.TREASURY_EXP_NOTIFY,this.obf_P_d_2928);
         thisClient.removeEventListener(obf_u_O_1177.TREASURY_USE_ITEM_ANSWER,this.obf_P_d_2928);
         thisClient.removeEventListener(obf_Q_r_1870.GOD_STYLE_NOTIFY,this.obf_N_e_1940);
         thisClient.removeEventListener(obf_Q_r_1870.GOD_STYLE_RANK_NOTIFY,this.obf_N_e_1940);
         thisClient.removeEventListener(obf_v_7_3503.TREE_INFO_NOTIFY,this.obf_Y_b_3518);
         thisClient.removeEventListener(obf_v_7_3503.TREE_ADD_EXP_ANSWER,this.obf_Y_b_3518);
         thisClient.removeEventListener(obf_v_7_3503.TREE_UP_RANK_ANSWER,this.obf_Y_b_3518);
         thisClient.removeEventListener(obf_v_7_3503.TREE_GET_ITEM_ANSWER,this.obf_Y_b_3518);
         thisClient.removeEventListener(obf_Y_j_4077.MAGIC_CIRCLE_INFO_NOTIFY,this.obf_j_m_4117);
         thisClient.removeEventListener(obf_Y_j_4077.MAGIC_CIRCLE_UP_ANSWER,this.obf_j_m_4117);
         thisClient.removeEventListener(obf_Y_j_4077.MAGIC_CIRCLE_USE_ANSWER,this.obf_j_m_4117);
         thisClient.removeEventListener(obf_k_W_1605.VACANT_SPACE_INFO_NOTIFY,this.obf_y_3_2859);
         thisClient.removeEventListener(obf_k_W_1605.VACANT_SPACE_BALL_UP_ANSWER,this.obf_y_3_2859);
         thisClient.removeEventListener(obf_k_W_1605.VACANT_SPACE_BALL_IN_ANSWER,this.obf_y_3_2859);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_INFO_NOTIFY,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_LOTTERY_ANSWER,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_SUCCESS_ANSWER,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_SUCCESS_AWARD_ANSWER,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_STAR_VALUE_NOTIFY,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_LIST_NOTIFY,this.obf_1_5_4574);
         thisClient.removeEventListener(ItemManualEventType.ITEM_MANUAL_SELL_ANSWER,this.obf_1_5_4574);
         thisClient.removeEventListener(PassTicketEventType.PASS_TICKET_INFO_NOTIFY,this.obf_R_M_4195);
         thisClient.removeEventListener(PassTicketEventType.PASS_TICKET_TASK_NOTIFY,this.obf_R_M_4195);
         thisClient.removeEventListener(PassTicketEventType.PASS_TICKET_AWARD_INFO_NOTIFY,this.obf_R_M_4195);
         thisClient.removeEventListener(PassTicketEventType.PASS_TICKET_SYS_INFO_NOTIFY,this.obf_R_M_4195);
         thisClient.removeEventListener(obf_m_8_3515.PLAYER_FEED_GOD_ANSWER,this.obf_4_C_4325);
         thisClient.removeEventListener(obf_m_8_3515.PLAYER_FEED_GOD_NOTIFY,this.obf_4_C_4325);
         thisClient.removeEventListener(obf_m_8_3515.PLAYER_REFINE_GOD_ANSWER,this.obf_4_C_4325);
         thisClient.removeEventListener(obf_m_8_3515.PLAYER_SUM_GOD_ANSWER,this.obf_4_C_4325);
         thisClient.removeEventListener(obf_m_8_3515.PLAYER_USE_GOD_ANSWER,this.obf_4_C_4325);
         thisClient.removeEventListener(obf_Z_2_4564.FORGE_GOD_INFO_NOTIFY,this.obf_K_C_3785);
         thisClient.removeEventListener(obf_Z_2_4564.FORGE_GOD_VALUE_NOTIFY,this.obf_K_C_3785);
         thisClient.removeEventListener(obf_t_x_2606.SKILL_LEVEL_NOTIFY,this.obf_e_2_2629);
         thisClient.removeEventListener(obf_t_x_2606.SKILL_USE_NOTIFY,this.obf_e_2_2629);
         thisClient.removeEventListener(obf_H_J_3193.MAKE_KEY_ANSWER,this.obf_7_a_1137);
         thisClient.removeEventListener(obf_H_J_3193.OPEN_BOX_ANSWER,this.obf_7_a_1137);
         thisClient.removeEventListener(obf_H_J_3193.BREAK_CHIP_ANSWER,this.obf_7_a_1137);
         thisClient.removeEventListener(obf_H_J_3193.MAKE_CHIP_ANSWER,this.obf_7_a_1137);
         thisClient.removeEventListener(obf_H_J_3193.MAKE_CHIP_INFO_NOTIFY,this.obf_7_a_1137);
         thisClient.removeEventListener(obf_H_J_3193.FREE_GET_BAD_KEY_ANSWER,this.obf_7_a_1137);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:WorldPingEcho = null;
         if(Boolean(GameContext.saveConfigInv) && GameContext.saveConfigInv.checkTimeout())
         {
            GameContext.saveConfigNow();
            GameContext.saveConfigInv = null;
         }
         this._mapManager.doRefreshNPCTask();
         if(this.obf_H_L_4047.checkTimeout())
         {
            RemotePlayerBuffer.scanBufferOverload();
         }
         ViewPortManager.showViewPort();
         SkillCDManager.runSkillCD();
         GameItemCDManager.runCD();
         obf_R_6_1363.obf_Q_i_1756();
         if(this.obf_0_e_4025.checkTimeout() && this._player != null)
         {
            _loc2_ = new WorldPingEcho();
            _loc2_.timestamp = getTimer();
            GameContext.worldClient.sendCommand(_loc2_);
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.stage.addEventListener(KeyboardEvent.KEY_UP,this.obf_G_M_4309);
      }
      
      private function obf_G_M_4309(param1:KeyboardEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:IPlayerUI = null;
         var _loc2_:String = String.fromCharCode(param1.charCode).toUpperCase();
         if(param1.keyCode == Keyboard.ENTER)
         {
            obf_K_e_3075.obf_e_q_2572.getInputFocus();
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            MapManager.instance.autoPickUpItem();
         }
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            PlayerMenuUI.closeAllMenu();
            if(GameContext.localPlayer.obf_L_r_3810())
            {
               return;
            }
            if(FarmManager.obf_0_9_2_382)
            {
               FarmManager.hideFarmState();
               return;
            }
            if(SkillAreaAimManager.isPresent)
            {
               SkillAreaAimManager.hideAreaAim();
               return;
            }
            if(Boolean(obf_K_e_3075.mapUI) && obf_K_e_3075.mapUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.mapUI);
            }
            if(Boolean(obf_K_e_3075.worldMapUI) && obf_K_e_3075.worldMapUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.worldMapUI);
            }
            if(obf_K_e_3075.obf_c_D_2721 != obf_K_e_3075.obf_s_r_1801)
            {
               obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
            }
            else
            {
               _loc3_ = [obf_K_e_3075.mapUI,obf_K_e_3075.depotBagUI,obf_K_e_3075.playerBagUI,obf_K_e_3075.rideBoxUI,obf_K_e_3075.refineBoxUI,obf_K_e_3075.npcShopUI,obf_K_e_3075.assembleBoxUI,obf_K_e_3075.petBoxContainerUI,obf_K_e_3075.petAssembleBoxUI];
               for each(_loc4_ in _loc3_)
               {
                  obf_K_e_3075.closeUI(_loc4_);
               }
            }
            GameContext.localPlayer.stopAutoAttack();
            if(this._player.isUsingSkill && !this._player.isCastingSkill)
            {
               this._player.obf_T_9_2144();
            }
            else if(!this._player.isUsingSkill)
            {
               this._player.obf_3_v_4336();
            }
         }
         if(_loc2_ == "`")
         {
            MapManager.instance.seleteRecentTarget();
         }
      }
      
      private function onEnterWorld(param1:obf_0_1_2695) : void
      {
         var commonBag:ResourceBag;
         var resList3:Array;
         var res3:String = null;
         var infoBox:MessageBoxModule = null;
         var e:obf_0_1_2695 = param1;
         var thisCmd:PlayerEnterWorldAnswer = e.cmd as PlayerEnterWorldAnswer;
         if(thisCmd.isWaiting)
         {
            infoBox = WindowManager.getModalWindowByName("LoadingInfo") as MessageBoxModule;
            if(infoBox)
            {
               infoBox.setMessage(DiversityManager.getString("SystemPrompt","waiting",[thisCmd.waitingIndex == 0 ? thisCmd.waitingTotal : thisCmd.waitingIndex,thisCmd.waitingTotal]));
            }
            else
            {
               WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","waiting",[thisCmd.waitingIndex == 0 ? thisCmd.waitingTotal : thisCmd.waitingIndex,thisCmd.waitingTotal]),null,"LoadingInfo",true);
            }
            return;
         }
         WindowManager.closeWindow(WindowManager.getModalWindowByName("LoadingInfo") as IWindow);
         commonBag = ResourceManager.instance.getBag("commonRes3",true);
         resList3 = WorldConfig.getResList("res3");
         for each(res3 in resList3)
         {
            commonBag.obf_z_U_2156(res3);
         }
         commonBag.load(1);
         obf_H_l_800.call("setAccRole",GameContext.obf_0_7_r_135,JSONUtil.getStr(thisCmd.role,["name"]),GameContext.obf_N_G_4080);
         try
         {
            obf_H_l_800.call("onEnterWorld",JSONUtil.getStr(thisCmd.role,["name"]));
         }
         catch(e:Error)
         {
         }
         GameContext.userConfig = thisCmd.clientConfig != "" ? com.adobe.serialization.json.JSON.decode(thisCmd.clientConfig) : new Object();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.limitRemotePlayerNumber(Map.obf_0_2_l_577);
         }
         obf_K_e_3075.shortcutUI.setUserConfigIconItemBag();
         DynamicVars.systemVar = thisCmd.sysVars;
         if(thisCmd.role)
         {
            this.initPlayer(thisCmd.role);
            GameContext.localPlayer = this._player;
            this._player.doCommand(thisCmd);
            TaskManager.doCommand(thisCmd);
            FriendManager.doCommand(thisCmd);
            MateManager.doCommand(thisCmd);
            obf_K_e_3075.playerInfoUI.init(this._player);
            obf_K_e_3075.skillBookUI.setJob(thisCmd.role.jobCode);
            GameContext.applyUserConfig();
            this._mapManager.createMap(thisCmd.role.mapId);
            ConditionScript.updateDynamicVarsCondition();
            GameContext.localPlayer.initCommand(WorldConfig.getObjectSetting("effectCommand") as Array);
            if(obf_K_e_3075.systemSettingUI)
            {
               obf_K_e_3075.systemSettingUI.init();
            }
            obf_K_e_3075.systemSettingUI.showEffectCommand();
            // The original promotional endpoint is offline and leaves a transparent
            // loader over the map in standalone Flash Player.
         }
         else
         {
            WindowManager.destroyWindow();
            WindowManager.showWindow(new BackgroundModule());
            WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","enterWorldError",[thisCmd.failureReason]),GameContext.ssoFailed);
            if(!GameContext.isSso())
            {
               WindowManager.showWindow(new LoginModule());
            }
         }
      }
      
      private function initPlayer(param1:LocalPlayerInfo) : void
      {
         this._player = new obf_U_6_3454(param1.jobCode,param1.sex,param1.hairStyleIndex);
      }
      
      private function onEnterMap(param1:obf_0_1_2695) : void
      {
         var playerLine:int = 0;
         var loadingBG:BackgroundModule = null;
         var failCon:Object = null;
         var e:obf_0_1_2695 = param1;
         var thisCmd:PlayerEnterMapAnswer = e.cmd as PlayerEnterMapAnswer;
         if(thisCmd.toMapId != "")
         {
            PromptsManager.checkEnterMap(thisCmd.toMapId);
            playerLine = GameContext.localPlayer.fullInfo.lineIndex;
            WindowManager.closeAllModalWindow();
            this._player.doCommand(e.cmd);
            if(!this._mapManager.map || thisCmd.toMapId != this._mapManager.map.mapId || thisCmd.lineIndex != playerLine)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               if(WindowManager.getModalWindowByName("ResLoading") == null)
               {
                  loadingBG = new BackgroundModule();
                  loadingBG.name = "LoadingBG";
                  WindowManager.showModalWindow(loadingBG);
               }
               WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","loading"),null,"LoadingInfo",true);
               FarmManager.hideFarmState();
               this._mapManager.createMap(thisCmd.toMapId);
            }
            else if(Boolean(this._mapManager.map) && Boolean(thisCmd.toMapId == this._mapManager.map.mapId) && thisCmd.lineIndex == playerLine)
            {
               this._mapManager.map.setViewPortCenterToObject(this._player,true);
            }
         }
         else
         {
            try
            {
               failCon = com.adobe.serialization.json.JSON.decode(thisCmd.failureReason);
            }
            catch(e:Error)
            {
            }
            if(failCon)
            {
               WindowManager.showMessageBox(ConditionScript.getConditionsHTML(failCon));
            }
            else
            {
               WindowManager.showMessageBox(thisCmd.failureReason);
            }
         }
      }
      
      private function obf_a_0_2514(param1:obf_0_1_2695) : void
      {
         if(param1.cmd.code == CommandCodePlayer.PLAYER_LEAVE_WORLD_ANSWER)
         {
            this.backToRoleList();
         }
         if(this._player)
         {
            this._player.doCommand(param1.cmd);
         }
         else
         {
            obf_x_0_1295.obf_r_w_3556("obf______________13" + getQualifiedClassName(param1.cmd) + ",obf_____4741！");
         }
      }
      
      private function obf_2_S_2318(param1:obf_0_1_2695) : void
      {
         PlayerSkillManager.doCommand(param1.cmd);
      }
      
      private function obf_0_0_X_268(param1:obf_0_1_2695) : void
      {
         FriendManager.doCommand(param1.cmd);
      }
      
      private function obf_5_H_3100(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         MateManager.doCommand(param1.cmd);
      }
      
      private function obf_0_u_3276(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(e.cmd.code == CommandCodeNpc.NPC_ASSEMBLE_ITEM_ANSWER)
         {
            try
            {
               obf_x_c_2855.doCommand(e.cmd);
            }
            catch(err:Error)
            {
               trace("Command Error:" + e.cmd.code + "\n" + err);
            }
         }
         if(e.cmd.code == CommandCodeNpc.NPC_Function_ANSWER)
         {
            try
            {
               obf_K_i_1311.doCommand(e.cmd);
            }
            catch(err:Error)
            {
               trace("Command Error:" + e.cmd.code + "\n" + err);
            }
         }
      }
      
      private function obf_f_Y_3549(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_F_9_1495.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_u_V_3362(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         TeamManager.doCommand(param1.cmd);
      }
      
      private function obf_M_L_4488(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         EquipmentManager.doCommand(param1.cmd);
      }
      
      private function obf_Q_Z_1048(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(GameContext.bagItemManager != null)
         {
            GameContext.bagItemManager.doCommand(param1.cmd);
         }
      }
      
      private function obf_5_p_2638(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_c_4686.doCommand(param1.cmd);
      }
      
      private function obf_0_6_d_648(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_P_e_2948.doCommand(param1.cmd);
      }
      
      private function obf_0_1_V_721(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_A_V_935.doCommand(param1.cmd);
      }
      
      private function obf_1_j_999(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_Y_6_1629.doCommand(param1.cmd);
      }
      
      private function obf_8_3126(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_G_0_3203.doCommand(param1.cmd);
      }
      
      private function obf_0_2_U_535(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_c_o_n_t_i_n_u_e_24.doCommand(param1.cmd);
      }
      
      private function obf_7_M_4450(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_G_4_4620.doCommand(param1.cmd);
      }
      
      private function obf_w_H_3965(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         TaskManager.doCommand(param1.cmd);
      }
      
      private function obf_Q_v_4401(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_j_Y_1351.doCommand(param1.cmd);
      }
      
      private function onFarmCommand(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(this._mapManager.mapState == MapState.ISDONE)
         {
            FarmManager.doCommand(param1.cmd);
         }
      }
      
      private function obf_k_y_3983(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_a_L_2059.doCommand(param1.cmd);
      }
      
      private function obf_2_h_1719(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_G_6_4257.doCommand(param1.cmd);
      }
      
      private function obf_I_R_2814(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_n_x_1562.doCommand(param1.cmd);
      }
      
      private function obf_s_3_4097(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_v_1_1352.doCommand(param1.cmd);
      }
      
      private function obf_6_l_3314(param1:obf_0_1_2695) : void
      {
         obf_R_6_1363.doCommand(param1.cmd);
      }
      
      private function obf_P_F_2419(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         RankingManager.doCommand(param1.cmd);
      }
      
      private function backToRoleList() : void
      {
         WindowManager.destroyWindow();
         WindowManager.showWindow(new BackgroundModule());
         WindowManager.showWindow(new RoleListModule());
      }
      
      private function onViewMap(param1:obf_0_1_2695) : void
      {
         if(!this._mapManager.map || this._mapManager.mapState != MapState.ISDONE)
         {
            return;
         }
         var _loc2_:Array = WorldConfig.getObjectSetting("monsterMaps") as Array;
         if(Boolean(_loc2_) && Boolean(_loc2_.length > 0) && _loc2_[0].mapCode == this._mapManager.map.mapId)
         {
            obf_0_K_4070.showWelcome("idm");
         }
         if(this._mapManager.map.mapId == WorldConfig.getStringSetting("familyWarMap"))
         {
            obf_K_e_3075.showUI(obf_K_e_3075.systemScoreUI);
            obf_K_e_3075.systemScoreUI.setShowStrVars(["#ldzjz1","#ldzjz2","#ldzjz3"],DiversityManager.getString("FamilyListUI","familyWarPoint"));
            obf_K_e_3075.systemScoreUI.setShowIntVars(["#ldzjf1","#ldzjf2","#ldzjf3"]);
         }
         else
         {
            obf_K_e_3075.systemScoreUI.closeSystemVars();
            obf_K_e_3075.closeUI(obf_K_e_3075.systemScoreUI);
         }
         this.obf_S_1036.doCommand(param1.cmd);
         RemotePlayerManager.dispatchCommand(param1.cmd,this._mapManager.map);
         AIMonsterManager.dispatchCommand(param1.cmd,this._mapManager.map);
         obf_C_p_3418.doCommand(param1.cmd);
         FarmManager.doCommand(param1.cmd);
         ConditionScript.updateDynamicVarsCondition();
         this._player.moveToNextMap();
         obf_K_e_3075.obf_L_s_2876();
      }
      
      private function obf_4_L_4387(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(Boolean(this._mapManager.map) && this._mapManager.mapState == MapState.ISDONE)
         {
            RemotePlayerManager.dispatchCommand(param1.cmd,this._mapManager.map);
         }
      }
      
      private function obf_0_Q_759(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(Boolean(this._mapManager.map) && this._mapManager.mapState == MapState.ISDONE)
         {
            AIMonsterManager.dispatchCommand(param1.cmd,this._mapManager.map);
         }
      }
      
      private function obf_6_z_4094(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         this.obf_S_1036.doCommand(param1.cmd);
      }
      
      private function onMapCreateComplete(param1:MapManagerEvent) : void
      {
         WindowManager.closeAllModalWindow();
         obf_q_6_3634.obf_w_z_1201(JSONUtil.getStr(this._mapManager.mapInfo,["rules","musicRule","music"]));
         this._mapManager.obf_5_G_1974();
         GameContext.currentMap = this._mapManager.map;
         this._mapManager.map.setViewPortSize(this.stage.stageWidth,this.stage.stageHeight);
         this._mapSprite.addChild(this._mapManager.map);
         obf_K_e_3075.setSmallMap(this._mapManager.map.mapId);
         obf_K_e_3075.setMap(this._mapManager.map.mapId);
         if(obf_K_e_3075.mapUI)
         {
            obf_K_e_3075.mapUI.refreshList();
         }
         this._mapManager.map.obf_2_T_3874(this._player);
         this._player.obf_Z_E_4144();
         this._player.obf_0_0_4605();
         this._player.obf_F_i_743();
         this._player.obf_8_1_2164();
         this._player.obf_f_s_1651();
         this.obf_S_1036.map = this._mapManager.map;
         ViewPortManager.init(this._mapManager,this._player);
         obf_O_a_3022.obf_g_Q_1361(MapManager.instance.mapInfo);
         obf_K_e_3075.showCenterInfo(DiversityManager.getString("CommonPrompt","enterMap",[MapManager.instance.mapInfo.name]));
         GameContext.worldClient.sendCommand(new PlayerViewMapRequest());
         obf_0_K_4070.showWelcome("idw");
      }
      
      private function onMapStartLoad(param1:MapManagerEvent) : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("ResLoading") as IWindow);
         WindowManager.showProgressBox([param1.mapBag.loader],"ResLoading");
      }
      
      private function obf_g_J_1920(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_C_p_3418.doCommand(param1.cmd);
      }
      
      private function obf_J_H_4400(param1:Event) : void
      {
         WindowManager.destroyWindow();
         WindowManager.showWindow(new BackgroundModule());
         WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","disconnected"),GameContext.refreshPage);
         WindowManager.showWindow(new LoginModule());
      }
      
      public function destroy() : void
      {
         obf_K_e_3075.destroy();
         this.removeListener();
         GameContext.currentMap = null;
         GameContext.localPlayer = null;
         GameContext.bagItemManager.destroy();
         GameContext.bagItemManager = null;
         FarmManager.destroy();
         TaskManager.destroy();
         FriendManager.destroy();
         this._mapManager.release();
         if(this._player)
         {
            this._player.destroy();
         }
      }
      
      private function obf_e_m_3644(param1:obf_0_1_2695) : void
      {
         var _loc2_:WorldPingEcho = param1.cmd as WorldPingEcho;
         if(obf_K_e_3075.playerInfoUI)
         {
            obf_K_e_3075.playerInfoUI.setPingDisplay(getTimer() - _loc2_.timestamp);
         }
      }
      
      private function obf_p_a_c_k_a_g_e_30(param1:obf_0_1_2695) : void
      {
         if(param1.cmd.code == CommandCodeWorld.WORLD_TIME_CHECK_NOTIFY)
         {
            if(obf_K_e_3075.smallMapUI)
            {
               obf_K_e_3075.smallMapUI.setServerTime((param1.cmd as WorldTimeCheckNotify).serverDate,(param1.cmd as WorldTimeCheckNotify).serverTime);
            }
            if(obf_K_e_3075.consumeRankingUI)
            {
               obf_K_e_3075.consumeRankingUI.setServerTime((param1.cmd as WorldTimeCheckNotify).serverDate,(param1.cmd as WorldTimeCheckNotify).serverTime);
            }
            if(obf_K_e_3075.obf_b_M_1918)
            {
               obf_K_e_3075.obf_b_M_1918.setServerTime((param1.cmd as WorldTimeCheckNotify).serverDate,(param1.cmd as WorldTimeCheckNotify).serverTime);
            }
            if(obf_K_e_3075.taxisBoxUI)
            {
               obf_K_e_3075.taxisBoxUI.setServerTime((param1.cmd as WorldTimeCheckNotify).serverDate,(param1.cmd as WorldTimeCheckNotify).serverTime);
            }
         }
      }
      
      private function obf_6_p_864(param1:obf_0_1_2695) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:SysVarChangeNotify = param1.cmd as SysVarChangeNotify;
         if(Boolean(_loc2_) && param1.cmd.code == CommandCodeWorld.SYS_VAR_CHANGE_NOTIFY)
         {
            if(!DynamicVars.systemVar)
            {
               DynamicVars.systemVar = new DynamicVars();
               ConditionScript.updateDynamicVarsCondition();
            }
            for(_loc3_ in _loc2_.boolVars)
            {
               DynamicVars.systemVar.addBoolVar(_loc3_,_loc2_.boolVars[_loc3_]);
            }
            for(_loc4_ in _loc2_.intVars)
            {
               DynamicVars.systemVar.addIntVar(_loc4_,_loc2_.intVars[_loc4_]);
            }
            for(_loc5_ in _loc2_.strVars)
            {
               DynamicVars.systemVar.addStrVar(_loc5_,_loc2_.strVars[_loc5_]);
            }
         }
         obf_Z_j_930.obf_0___O_56(_loc2_.intVars);
      }
      
      private function obf_h_A_3414(param1:obf_0_1_2695) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!DynamicVars.systemVar)
         {
            return;
         }
         var _loc2_:SysVarClearNotify = param1.cmd as SysVarClearNotify;
         if(Boolean(_loc2_) && param1.cmd.code == CommandCodeWorld.SYS_VAR_CLEAR_NOTIFY)
         {
            for each(_loc3_ in _loc2_.boolVars)
            {
               DynamicVars.systemVar.delBoolVar(_loc3_);
            }
            for each(_loc4_ in _loc2_.intVars)
            {
               DynamicVars.systemVar.delIntVar(_loc4_);
            }
            for each(_loc5_ in _loc2_.strVars)
            {
               DynamicVars.systemVar.delStrVar(_loc5_);
            }
         }
      }
      
      private function obf_8_U_1246(param1:obf_0_1_2695) : void
      {
         var _loc2_:GM_CommandAnswer = null;
         if(obf_K_e_3075.gmControlBox)
         {
            _loc2_ = param1.cmd as GM_CommandAnswer;
            obf_K_e_3075.gmControlBox.appendLabelText(_loc2_.result + "\n\n");
         }
      }
      
      private function obf_X_i_1835(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_0_5_9_486.doCommand(param1.cmd);
      }
      
      private function obf_0_9_A_165(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_J_F_3431.doCommand(param1.cmd);
      }
      
      private function obf_0_s_4505(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_j_s_1302.doCommand(param1.cmd);
      }
      
      private function obf_4_V_1484(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(e.cmd.code == CommandCodeShop.LEAD_ITEM_INFO_NOTIFY || e.cmd.code == CommandCodeShop.obf_d_9_3617)
         {
            try
            {
               ShopManager.doCommand(e.cmd);
            }
            catch(err:Error)
            {
               trace("Command Error:" + e.cmd.code + "\n" + err);
            }
         }
      }
      
      private function obf_6_e_3438(param1:obf_0_1_2695) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         obf_V_N_2158.doCommand(param1.cmd);
      }
      
      private function obf_b_F_3825(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_H_B_2569.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_1_n_3102(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_x_B_2963.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_S_K_2573(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_S_M_1257.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_2_r_3018(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_8_D_73.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_4_N_1466(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_Y_1494.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_S_E_3433(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_1_R_3404.dispatchCommand(e.cmd,this._mapManager.map);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_c_3_2666(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_O_a_3022.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_3_G_585(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_H_c_1383.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_w_U_2533(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_Q_J_3925.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_6_S_4390(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_V_C_3520.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_6_J_537(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            activityBoxManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_4_4_636(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_A_S_2214.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_c_Y_1385(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_5_f_69.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function onGodSoul(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_t_a_1082.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_n_f_2241(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_t_f_2299.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_K_D_4494(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_C_E_4362.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_3_C_527(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_s_1265.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_f_Z_1205(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_3_i_1942.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function onLegend(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_P_8_3783.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_8_c_555(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_1_t_884.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_B_i_1578(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_b_T_3041.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_w_s_4568(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_1_a_376.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0___F_149(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_2_l_4040.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_z_P_4385(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_J_w_1685.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_U_x_3272(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_s_o_3993.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_1_s_80(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         trace("Command :" + e.cmd.code + "\n");
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_4_5_176.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_6_m_89(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_s_W_2408.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_R_4671(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_g_0_3344.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_x_N_3059(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_B_5_1274.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_I_M_3471(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_4_6_372.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_g_1_2097(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_o_H_2969.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_A_3373(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_S_x_1774.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_0_U_1503(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_Y_7_1544.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_E_b_2262(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            StarAdventureManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function onBook(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_E_1429.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_h_x_4567(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            DevilGodManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_x_J_1141(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_O_7_1100.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_d_S_2276(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_Z_j_930.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_P_6_1851(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            EquipKindGrowManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_d_0_3474(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_5_M_1027.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_M_I_4109(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_4_3841.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_U_4154(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_1_Y_1502.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_I_4656(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_7_q_3477.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_B_P_3374(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_g_4_2381.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_T_r_860(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_8_m_2284.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_H_H_1912(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_N_9_4230.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_P_d_2928(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_M_a_3122.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_N_e_1940(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_d_M_1152.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_Y_b_3518(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_v_0_1258.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_j_m_4117(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_b_q_889.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_y_3_2859(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_9_Y_4477.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_1_5_4574(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            ItemManualManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_R_M_4195(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            PassTicketManager.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_4_C_4325(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_6_H_238.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_K_C_3785(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_0_4_3_717.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_e_2_2629(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_N_o_3647.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
      
      private function obf_7_a_1137(param1:obf_0_1_2695) : void
      {
         var e:obf_0_1_2695 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            obf_u_Z_4014.doCommand(e.cmd);
         }
         catch(err:Error)
         {
            trace("Command Error:" + e.cmd.code + "\n" + err);
         }
      }
   }
}

