package com.sunweb.game.rpg.module
{
   import obf_0_2_o_501.obf_g_4_2381;
   import obf_0_2_t_601.obf_o_H_2969;
   import obf_0_6_Z_584.obf_5_M_1027;
   import obf_0_7_V_532.obf_N_o_3647;
   import obf_0_7_o_492.obf_b_q_889;
   import obf_5_S_2387.obf_H_c_1383;
   import obf_9_H_3298.PassTicketManager;
   import obf_D_Y_975.obf_7_q_3477;
   import obf_H_I_939.obf_u_Z_4014;
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_R_R_2172.obf_1_Y_1502;
   import obf_R_w_4473.obf_A_S_2214;
   import obf_S_0_4540.DevilGodManager;
   import obf_T_4_4162.obf_0_4_3_717;
   import obf_Z_U_3013.obf_C_p_3418;
   import obf_Z_Y_1344.ItemManualManager;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_b_2_1718.obf_0_8_D_73;
   import obf_b_P_3069.obf_n_x_1562;
   import obf_c_j_3175.obf_0_6_H_238;
   import obf_g_A_3629.ChatDecoder;
   import obf_h_e_3633.obf_8_m_2284;
   import obf_i_X_3487.obf_v_0_1258;
   import obf_l_I_3561.obf_g_0_3344;
   import obf_x_O_4078.obf_1_t_884;
   import obf_x_O_4078.obf_A_V_935;
   import com.adobe.serialization.json.JSON;
   import com.brokenfunction.json.decodeJson;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_e_4650;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.aegis.obf_C_E_4362;
   import com.sunweb.game.rpg.angel.obf_O_7_1100;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.challenge.obf_0_5_f_69;
   import com.sunweb.game.rpg.cloak.obf_b_T_3041;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.country.obf_S_x_1774;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equ.obf_0_4_X_546;
   import com.sunweb.game.rpg.equ.obf_y_a_2168;
   import com.sunweb.game.rpg.extractant.obf_t_f_2299;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.farm.FarmTempletManager;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.farm.obf_F_R_1745;
   import com.sunweb.game.rpg.farm.obf_P_f_3747;
   import com.sunweb.game.rpg.farm.obf_d_8_4301;
   import com.sunweb.game.rpg.fateTurntable.obf_3_i_1942;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.obf_t_v_4376;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.godSoul.obf_t_a_1082;
   import com.sunweb.game.rpg.godStyle.obf_d_M_1152;
   import com.sunweb.game.rpg.lockTower.obf_N_9_4230;
   import com.sunweb.game.rpg.manual.obf_V_C_3520;
   import com.sunweb.game.rpg.netRole.obf_n_u_l_l_2508;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerBook.obf_E_1429;
   import com.sunweb.game.rpg.playerUI.MagicMotionManager;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_9_7_2639;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_o_2392;
   import com.sunweb.game.rpg.script.obf_c_w_2239;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.shop.obf_f_z_1191;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_l_l_940;
   import com.sunweb.game.rpg.soulGuard.obf_4_3841;
   import com.sunweb.game.rpg.starAdventure.StarAdventureManager;
   import com.sunweb.game.rpg.stirp.obf_x_B_2963;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import com.sunweb.game.rpg.treasury.obf_M_a_3122;
   import com.sunweb.game.rpg.vacantSpace.obf_9_Y_4477;
   import com.sunweb.game.rpg.wingSpirit.obf_B_5_1274;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.PromptsManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.obf_2_V_3982;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ResLoadModule extends Sprite implements IWindow
   {
      
      private var resBag:ResourceBag;
      
      private var initInf:int;
      
      public function ResLoadModule()
      {
         super();
         this.resBag = ResourceManager.instance.getBag("common",true);
         this.resBag.loader.maxConn = 6;
         WindowManager.showProgressBox([this.resBag.loader],"ResLoading");
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         ++this.initInf;
         if(this.initInf == 30)
         {
            if(this.resBag.loader.loadingState == obf_e_4650.COMPLETE)
            {
               this.obf_5_g_3787(null);
            }
            else
            {
               this.resBag.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.obf_5_g_3787);
            }
         }
      }
      
      private function initializeModels() : void
      {
         obf_J_F_3431.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ias")));
         obf_9_7_2639.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("inp")));
         obf_F_9_1495.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifc")));
         obf_0_M_3913.pkSafeLevel = WorldConfig.getNumberSetting("pkSafeLevel");
         obf_f_z_1191.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("irp")));
         obf_x_c_2855.init(decodeJson(this.getInfContent("iar")));
         obf_v_1_1352.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iob")));
         obf_n_x_1562.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ild")));
         obf_n_x_1562.initGamble(com.adobe.serialization.json.JSON.decode(this.getInfContent("igs")));
         BuffManager.init(decodeJson(this.getInfContent("ibc")));
         obf_b_p_3604.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imb")));
         TaskManager.init(decodeJson(this.getInfContent("itl")));
         obf_j_Y_1351.init(decodeJson(this.getInfContent("ism")));
         PromptsManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ipp")));
         RoleModel.monsterModelList = com.adobe.serialization.json.JSON.decode(this.getInfContent("imm"));
         obf_C_p_3418.initTrapConfig(com.adobe.serialization.json.JSON.decode(this.getInfContent("itc")));
         obf_o_2392.rideModelList = decodeJson(this.getInfContent("irm"));
         obf_c_4686.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ipc")));
         MonsterInfoUtil.init(decodeJson(this.getInfContent("imn")));
         obf_t_v_4376.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iuc")));
         SkillConfig.skillConfig = decodeJson(this.getInfContent("isc"));
         PlayerSkillManager.initCommonSkill(SkillConfig.skillConfig);
         obf_G_4_4620.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("igb")));
         obf_l_l_940.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifsc")));
         obf_0_9_V_473.initialize(com.adobe.serialization.json.JSON.decode(this.getInfContent("iec")));
         PlayerSkillManager.initSkillBook(com.adobe.serialization.json.JSON.decode(this.getInfContent("isb")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iib")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iic")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iix")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iie")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iir")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iis")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iip")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iig")));
         GameItemManager.addItemConfig(decodeJson(this.getInfContent("iid")));
         obf_A_V_935.initConfig(com.adobe.serialization.json.JSON.decode(this.getInfContent("ieb")));
         EquipmentManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ies")));
         obf_1_t_884.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("irc")));
         obf_y_a_2168.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ieu")));
         obf_0_4_X_546.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifr")));
         WorldMapManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imw")));
         obf_P_f_3747.initialize(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifh")));
         FarmTempletManager.initialize(com.adobe.serialization.json.JSON.decode(this.getInfContent("ift")));
         obf_d_8_4301.initialize(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifb")));
         obf_F_R_1745.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifs")));
         obf_0_1_N_478.emptyFarmSign = DiversityManager.getString("FarmPrompt","emptyFarmSign");
         obf_0_1_N_478.commonFarmSign = DiversityManager.getString("FarmPrompt","commonFarmSign");
         obf_0_1_N_478.playerFarmSign = DiversityManager.getString("FarmPrompt","playerFarmSign");
         ShopManager.initShop(com.adobe.serialization.json.JSON.decode(this.getInfContent("isp")));
         ShopManager.initStore(com.adobe.serialization.json.JSON.decode(this.getInfContent("ist")));
         MagicMotionManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imo")) as Array);
         obf_c_w_2239.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("idv")));
         ButtonToItemManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ibi")));
         obf_n_u_l_l_2508.init();
         obf_H_B_2569.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ict")));
         obf_x_B_2963.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("isd")));
         obf_S_M_1257.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iac")));
         obf_0_8_D_73.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ibon")));
         obf_Y_1494.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("idd")));
         obf_2_V_3982.init(decodeJson(this.getInfContent("iam")));
         obf_H_c_1383.init(decodeJson(this.getInfContent("itp")));
         obf_Q_J_3925.init(decodeJson(this.getInfContent("igc")));
         obf_V_C_3520.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imc")));
         activityBoxManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ite")));
         obf_A_S_2214.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifa")));
         obf_0_5_f_69.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("isa")));
         obf_t_a_1082.goulConfig = com.adobe.serialization.json.JSON.decode(this.getInfContent("igsc"));
         obf_t_f_2299.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iex")));
         obf_C_E_4362.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iae")));
         obf_s_1265.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ibaby")));
         obf_3_i_1942.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iftb")));
         obf_b_T_3041.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("icm")));
         obf_J_w_1685.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ito")));
         obf_g_0_3344.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifm")));
         obf_B_5_1274.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iws")));
         obf_o_H_2969.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("irg")));
         obf_S_x_1774.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("icc")));
         StarAdventureManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ista")));
         obf_E_1429.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ipb")));
         DevilGodManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("idg")));
         obf_O_7_1100.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iag")));
         obf_Z_j_930.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("irwc")));
         obf_5_M_1027.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ivs")));
         obf_4_3841.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("isg")));
         obf_1_Y_1502.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("dim")));
         obf_7_q_3477.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ipk")));
         obf_g_4_2381.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ibw")));
         obf_8_m_2284.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("iibt")));
         obf_N_9_4230.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ilt")));
         obf_M_a_3122.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("itsc")));
         obf_d_M_1152.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("igsl")));
         obf_v_0_1258.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("itr")));
         obf_b_q_889.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imcc")));
         obf_9_Y_4477.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ivsc")));
         ItemManualManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("itm")));
         PassTicketManager.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ipt")));
         obf_0_6_H_238.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifg")));
         obf_0_4_3_717.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("ifgg")));
         obf_N_o_3647.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("igm")));
         obf_u_Z_4014.init(com.adobe.serialization.json.JSON.decode(this.getInfContent("imch")));
         ChatDecoder.obf_3_8_1066(obf_7_6_4416.getItemLinkObject,obf_7_6_4416.getRoleLinkColor,obf_7_6_4416.getNpcLinkName,obf_7_6_4416.getMonsterLinkName);
         ChatDecoder.obf_l_W_4297 = obf_0_3_0_538.obf_m_k_3280.toString(16);
         ChatDecoder.obf_0_4_R_115 = obf_0_3_0_538.obf_e_d_745.toString(16);
         ChatDecoder.obf_H_O_3489 = obf_0_3_0_538.obf_A_b_2659.toString(16);
         ChatDecoder.macroColor = obf_0_3_0_538.obf_H_f_1073.toString(16);
      }
      
      private function getInfContent(param1:String) : String
      {
         var _loc2_:String = ResourceManager.instance.getText(param1);
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            throw new Error("config file " + param1 + " is null!");
         }
         return _loc2_;
      }
      
      private function obf_5_g_3787(param1:obf_J_Y_3494) : void
      {
         var e:obf_J_Y_3494 = param1;
         this.initializeModels();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         try
         {
            this.resBag.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.obf_5_g_3787);
         }
         catch(e:Error)
         {
         }
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new obf_h_q_1976());
      }
      
      public function destroy() : void
      {
      }
   }
}

