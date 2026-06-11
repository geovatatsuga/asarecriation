package com.sunweb.game.rpg
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   
   public class SystemPrompt
   {
      
      public static const obf_U_h_3909:int = 256;
      
      public static const obf_j_w_3347:int = 257;
      
      public static const obf_U_f_1709:int = 258;
      
      public static const obf_D_a_3944:int = 259;
      
      public static const obf_z_K_1568:int = 260;
      
      public static const obf_g_T_1271:int = 261;
      
      public static const obf_0_6_c_729:int = 262;
      
      public static const obf_s_a_3032:int = 263;
      
      public static const obf_d_r_2774:int = 264;
      
      public static const obf_e_c_2581:int = 265;
      
      public static const obf_N_D_4579:int = 266;
      
      public static const obf_L_I_1727:int = 267;
      
      public static const obf_M_G_1138:int = 288;
      
      public static const obf_j_A_1109:int = 289;
      
      public static const obf_S_Z_4244:int = 290;
      
      public static const obf_r_O_1696:int = 291;
      
      public static const obf_5_6_1346:int = 295;
      
      public static const obf_k_c_2875:int = 304;
      
      public static const obf_E_M_1367:int = 305;
      
      public static const obf_q_1_2252:int = 306;
      
      public static const obf_0_4_z_351:int = 307;
      
      public static const TARGET_ALREADY_IN_TEAM:int = 308;
      
      public static const obf_K_P_1203:int = 309;
      
      public static const obf_P_g_3380:int = 310;
      
      public static const obf_z_a_3311:int = 320;
      
      public static const TARGET_FRIEND_NUMBER_FULL:int = 321;
      
      public static const MY_MAP_DISABLE_TEAM:int = 322;
      
      public static const TARGET_MAP_DISABLE_TEAM:int = 323;
      
      public static const obf_L_u_3952:int = 336;
      
      public static const obf_r_2_3427:int = 337;
      
      public static const obf_W_A_2195:int = 353;
      
      public static const obf_j_N_928:int = 354;
      
      public static const obf_2_6_4140:int = 355;
      
      public static const obf_0_0_1_159:int = 356;
      
      public static const obf_f_1_2293:int = 357;
      
      public static const obf_g_6_1881:int = 358;
      
      public static const obf_D_A_3430:int = 359;
      
      public static const PET_DIED:int = 360;
      
      public static const obf_3_W_4203:int = 368;
      
      public static const obf_0_0_u_634:int = 369;
      
      public static const obf_n_Y_4073:int = 370;
      
      public static const obf_y_w_1596:int = 371;
      
      public static const TARGET_ALREADY_IN_FAMILY:int = 372;
      
      public static const obf_b_K_2130:int = 373;
      
      public static const obf_0_3_e_506:int = 374;
      
      public static const obf_i_m_p_l_e_m_e_n_t_s_15:int = 375;
      
      public static const obf_j_e_2438:int = 376;
      
      public static const obf_0_6_1_366:int = 377;
      
      public static const obf_a_y_3229:int = 384;
      
      public static const TARGET_DISABLE_TRADE:int = 385;
      
      public static const CAN_NOT_TRADE_WITH_TARGET:int = 386;
      
      public static const obf_Y_C_738:int = 387;
      
      public static const obf_z_3_1023:int = 400;
      
      public static const obf_S_J_1042:int = 401;
      
      public static const obf_d_3_753:int = 402;
      
      public static const CAPTURE_MONSTER_HP_ERROR:int = 416;
      
      public static const CAPTURE_PET_FAILED:int = 417;
      
      public static const MUST_IN_SAME_SIDE:int = 432;
      
      public static const FAMILY_MAX_SKILLS_OUT:int = 448;
      
      public static const MY_CAN_NOT_GOTO:int = 464;
      
      public static const MY_MAP_CAN_NOT_LEAVE:int = 465;
      
      public static const TARGET_MAP_CAN_NOT_GOTO:int = 466;
      
      public static const TARGET_CAN_NOT_GOTO:int = 467;
      
      public static const MY_MAP_CAN_NOT_GOTO:int = 468;
      
      public static const TARGET_MAP_CAN_NOT_LEAVE:int = 469;
      
      public static const obf_6_N_874:int = 4095;
      
      public static const OUT_CONSUME_QUOTAS:int = 472;
      
      public static const ANIMAL_DIED:int = 473;
      
      public static const NO_FRIEND_REL_VALUE:int = 474;
      
      public function SystemPrompt()
      {
         super();
      }
      
      public static function showSystemPrompt(param1:int) : void
      {
         var _loc2_:Object = {
            (obf_U_h_3909 + ""):DiversityManager.getString("ServerPrompt","ride_state_error"),
            (obf_U_f_1709 + ""):DiversityManager.getString("ServerPrompt","ride_out_of_range"),
            (obf_j_w_3347 + ""):DiversityManager.getString("ServerPrompt","ride_out_of_capacity"),
            (obf_z_K_1568 + ""):DiversityManager.getString("ServerPrompt","ride_failed_in_fighting"),
            (obf_g_T_1271 + ""):DiversityManager.getString("ServerPrompt","ride_request_refused"),
            (obf_0_6_c_729 + ""):DiversityManager.getString("ServerPrompt","ride_invite_refused"),
            (obf_s_a_3032 + ""):DiversityManager.getString("ServerPrompt","player_not_online"),
            (obf_d_r_2774 + ""):DiversityManager.getString("ServerPrompt","player_was_bitten"),
            (obf_e_c_2581 + ""):DiversityManager.getString("ServerPrompt","player_was_robbed"),
            (obf_L_I_1727 + ""):DiversityManager.getString("ServerPrompt","has_accelerated"),
            (obf_M_G_1138 + ""):DiversityManager.getString("ServerPrompt","exceed_time_limit"),
            (obf_j_A_1109 + ""):DiversityManager.getString("ServerPrompt","exceed_number_limit"),
            (obf_S_Z_4244 + ""):DiversityManager.getString("ServerPrompt","exceed_distance_limit"),
            (obf_r_O_1696 + ""):DiversityManager.getString("ServerPrompt","no_such_role"),
            (obf_5_6_1346 + ""):DiversityManager.getString("ServerPrompt","not_pay_money"),
            (obf_k_c_2875 + ""):DiversityManager.getString("ServerPrompt","team_name_invalid"),
            (obf_E_M_1367 + ""):DiversityManager.getString("ServerPrompt","team_is_full"),
            (obf_q_1_2252 + ""):DiversityManager.getString("ServerPrompt","team_not_exists"),
            (obf_0_4_z_351 + ""):DiversityManager.getString("ServerPrompt","team_leader_only"),
            (TARGET_ALREADY_IN_TEAM + ""):DiversityManager.getString("ServerPrompt","target_already_in_team"),
            (obf_K_P_1203 + ""):DiversityManager.getString("ServerPrompt","self_already_in_team"),
            (obf_P_g_3380 + ""):DiversityManager.getString("ServerPrompt","must_in_same_team"),
            (obf_z_a_3311 + ""):DiversityManager.getString("ServerPrompt","my_friend_number_full"),
            (TARGET_FRIEND_NUMBER_FULL + ""):DiversityManager.getString("ServerPrompt","target_friend_number_full"),
            (MY_MAP_DISABLE_TEAM + ""):DiversityManager.getString("ServerPrompt","MY_MAP_DISABLE_TEAM"),
            (TARGET_MAP_DISABLE_TEAM + ""):DiversityManager.getString("ServerPrompt","TARGET_MAP_DISABLE_TEAM"),
            (obf_L_u_3952 + ""):DiversityManager.getString("ServerPrompt","agent_number_full"),
            (obf_r_2_3427 + ""):DiversityManager.getString("ServerPrompt","agent_not_selling_state"),
            (obf_W_A_2195 + ""):DiversityManager.getString("ServerPrompt","not_enough_bag_room"),
            (obf_j_N_928 + ""):DiversityManager.getString("ServerPrompt","renew_done"),
            (obf_3_W_4203 + ""):DiversityManager.getString("ServerPrompt","family_name_invalid"),
            (obf_0_0_u_634 + ""):DiversityManager.getString("ServerPrompt","family_is_full"),
            (obf_n_Y_4073 + ""):DiversityManager.getString("ServerPrompt","family_not_exists"),
            (obf_y_w_1596 + ""):DiversityManager.getString("ServerPrompt","family_op_failed"),
            (TARGET_ALREADY_IN_FAMILY + ""):DiversityManager.getString("ServerPrompt","target_already_in_family"),
            (obf_b_K_2130 + ""):DiversityManager.getString("ServerPrompt","self_already_in_family"),
            (obf_0_3_e_506 + ""):DiversityManager.getString("ServerPrompt","must_in_same_family"),
            (obf_i_m_p_l_e_m_e_n_t_s_15 + ""):DiversityManager.getString("ServerPrompt","rejoin_family_in_cd",[WorldConfig.getNumberSetting("rejoinFamilyCDInHour")]),
            (obf_j_e_2438 + ""):DiversityManager.getString("ServerPrompt","post_is_full"),
            (obf_0_6_1_366 + ""):DiversityManager.getString("ServerPrompt","family_task_unavailable"),
            (obf_a_y_3229 + ""):DiversityManager.getString("ServerPrompt","self_disable_trade"),
            (TARGET_DISABLE_TRADE + ""):DiversityManager.getString("ServerPrompt","target_disable_trade"),
            (CAN_NOT_TRADE_WITH_TARGET + ""):DiversityManager.getString("ServerPrompt","can_not_trade_with_target"),
            (obf_Y_C_738 + ""):DiversityManager.getString("ServerPrompt","trade_state_error"),
            (obf_2_6_4140 + ""):DiversityManager.getString("ServerPrompt","item_expired"),
            (obf_0_0_1_159 + ""):DiversityManager.getString("ServerPrompt","pet_over_level",[JSONUtil.getInt(obf_c_4686.config,["overRoleLevel"])]),
            (obf_f_1_2293 + ""):DiversityManager.getString("ServerPrompt","pet_loyalty_low"),
            (obf_g_6_1881 + ""):DiversityManager.getString("ServerPrompt","pet_no_life"),
            (obf_D_A_3430 + ""):DiversityManager.getString("ServerPrompt","equip_no_durability"),
            (obf_z_3_1023 + ""):DiversityManager.getString("ServerPrompt","can_not_booth"),
            (obf_S_J_1042 + ""):DiversityManager.getString("ServerPrompt","not_enough_booth_space"),
            (obf_d_3_753 + ""):DiversityManager.getString("ServerPrompt","booth_item_has_sold"),
            (CAPTURE_MONSTER_HP_ERROR + ""):DiversityManager.getString("ServerPrompt","CAPTURE_MONSTER_HP_ERROR"),
            (CAPTURE_PET_FAILED + ""):DiversityManager.getString("ServerPrompt","CAPTURE_PET_FAILED"),
            (MUST_IN_SAME_SIDE + ""):DiversityManager.getString("ServerPrompt","MUST_IN_SAME_SIDE"),
            (FAMILY_MAX_SKILLS_OUT + ""):DiversityManager.getString("ServerPrompt","FAMILY_MAX_SKILLS_OUT"),
            (MY_CAN_NOT_GOTO + ""):DiversityManager.getString("ServerPrompt","MY_CAN_NOT_GOTO"),
            (MY_MAP_CAN_NOT_LEAVE + ""):DiversityManager.getString("ServerPrompt","MY_MAP_CAN_NOT_LEAVE"),
            (TARGET_MAP_CAN_NOT_GOTO + ""):DiversityManager.getString("ServerPrompt","TARGET_MAP_CAN_NOT_GOTO"),
            (TARGET_CAN_NOT_GOTO + ""):DiversityManager.getString("ServerPrompt","TARGET_CAN_NOT_GOTO"),
            (MY_MAP_CAN_NOT_GOTO + ""):DiversityManager.getString("ServerPrompt","MY_MAP_CAN_NOT_GOTO"),
            (TARGET_MAP_CAN_NOT_LEAVE + ""):DiversityManager.getString("ServerPrompt","TARGET_MAP_CAN_NOT_LEAVE"),
            (OUT_CONSUME_QUOTAS + ""):DiversityManager.getString("ServerPrompt","OUT_CONSUME_QUOTAS"),
            (NO_FRIEND_REL_VALUE + ""):DiversityManager.getString("ServerPrompt","NO_FRIEND_REL_VALUE"),
            (obf_6_N_874 + ""):DiversityManager.getString("ServerPrompt","unkown_error")
         };
         if(_loc2_[param1])
         {
            obf_K_e_3075.showTipInfo(_loc2_[param1]);
         }
         var _loc3_:Object = {
            (PET_DIED + ""):DiversityManager.getString("ServerPrompt","PET_DIED"),
            (ANIMAL_DIED + ""):DiversityManager.getString("ServerPrompt","ANIMAL_DIED")
         };
         if(_loc3_[param1])
         {
            obf_K_e_3075.showCenterInfo(_loc3_[param1]);
         }
         if(Boolean(GameContext.currentMap) && Boolean(GameContext.localPlayer))
         {
            if(param1 == obf_d_r_2774)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,GameContext.localPlayer,"C_DogAttack");
            }
            else if(param1 == obf_e_c_2581)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,GameContext.localPlayer,"C_ScarecrowGold");
            }
         }
      }
   }
}

