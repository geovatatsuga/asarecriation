package com.sunweb.game.rpg.playerUI.map
{
   import obf_0_2_o_501.obf_g_4_2381;
   import obf_0_2_t_601.obf_o_H_2969;
   import obf_0_7_V_532.obf_N_o_3647;
   import obf_0_7_o_492.obf_b_q_889;
   import obf_6_4_3428.obf_s_W_2408;
   import obf_9_H_3298.PassTicketManager;
   import obf_D_Y_975.obf_7_q_3477;
   import obf_H_I_939.obf_u_Z_4014;
   import obf_Q_c_4394.obf_Z_j_930;
   import obf_S_0_4540.DevilGodManager;
   import obf_T_4_4162.obf_0_4_3_717;
   import obf_Z_Y_1344.ItemManualManager;
   import obf_b_2_1718.obf_0_8_D_73;
   import obf_c_j_3175.obf_0_6_H_238;
   import obf_h_e_3633.obf_8_m_2284;
   import obf_i_X_3487.obf_v_0_1258;
   import obf_l_I_3561.obf_g_0_3344;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.aegis.obf_C_E_4362;
   import com.sunweb.game.rpg.angel.obf_O_7_1100;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.challenge.obf_0_5_f_69;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.cloak.obf_b_T_3041;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.country.obf_S_x_1774;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.fateTurntable.obf_3_i_1942;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.godStyle.obf_d_M_1152;
   import com.sunweb.game.rpg.manual.obf_V_C_3520;
   import com.sunweb.game.rpg.playerBook.obf_E_1429;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.soulGuard.obf_4_3841;
   import com.sunweb.game.rpg.starAdventure.StarAdventureManager;
   import com.sunweb.game.rpg.stirp.obf_x_B_2963;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import com.sunweb.game.rpg.treasury.obf_M_a_3122;
   import com.sunweb.game.rpg.vacantSpace.obf_9_Y_4477;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import playerUI.SystemListUIMC;
   
   public class SystemListUI extends SystemListUIMC implements IPlayerUI
   {
      
      private var obf_l_o_3389:Array;
      
      private var obf_n_2_1416:int = 0;
      
      private var obf_j_B_1080:int;
      
      private var obf_R_u_4298:int;
      
      private var obf_h_T_3161:int;
      
      private var obf_D_h_4511:Object;
      
      private var isAward:Boolean = false;
      
      private var isLandAward:Boolean = false;
      
      private var isShowBaby:Boolean;
      
      private var varName:String;
      
      private var magicCdTimel:TimeLimiter = new TimeLimiter(1000);
      
      private var isOpen:Boolean = false;
      
      public function SystemListUI()
      {
         super();
         this.visible = false;
         this.onResize(null);
         this.initStatusButton();
         this.initDiversity();
         this.varName = JSONUtil.getStr(obf_3_i_1942.fateTurntableConfig,["varName"]);
         this.addListener();
      }
      
      private function initStatusButton() : void
      {
         cmdConstellation.visible = WorldConfig.getValue("functionSwitch","showConstellation");
         cmdBone.visible = WorldConfig.getValue("functionSwitch","showBone");
         cmdDragon.visible = WorldConfig.getValue("functionSwitch","showDragon");
         cmdTower.visible = WorldConfig.getValue("functionSwitch","showTower");
         cmdAegis.visible = !WorldConfig.getValue("functionSwitch","showAegis");
         cmdSoul.visible = WorldConfig.getValue("functionSwitch","showSoul");
         cmdBabyBlink.visible = false;
         cmdCloak.visible = WorldConfig.getValue("functionSwitch","showCloak");
         cmdTotem.visible = WorldConfig.getValue("functionSwitch","showTotem");
         cmdChristmas.visible = WorldConfig.getValue("functionSwitch","showChristmas");
         fundBtn.visible = WorldConfig.getValue("functionSwitch","showfund");
         cmdReGrow.visible = WorldConfig.getValue("functionSwitch","showReGrow");
         cmdPlayerDevil.visible = WorldConfig.getValue("functionSwitch","showPlayerDevil");
         cmdCountry.visible = WorldConfig.getValue("functionSwitch","showCountry");
         cmdStarAdventure.visible = WorldConfig.getValue("functionSwitch","showStarAdventure");
         cmdBook.visible = WorldConfig.getValue("functionSwitch","showBook");
         cmdDevilGod.visible = WorldConfig.getValue("functionSwitch","showDevilGod");
         cmdAngel.visible = WorldConfig.getValue("functionSwitch","showAngel");
         cmdReward.visible = WorldConfig.getValue("functionSwitch","showReward");
         cmdSoulGuard.visible = WorldConfig.getValue("functionSwitch","showSoulGuard");
         cmdDivine.visible = WorldConfig.getValue("functionSwitch","showDivine");
         cmdPocket.visible = WorldConfig.getValue("functionSwitch","showPocketConfig");
         cmdBloodyWar.visible = WorldConfig.getValue("functionSwitch","showBloodyWarConfig");
         cmdIncubator.visible = WorldConfig.getValue("functionSwitch","showIncubatorConfig");
         cmdLockTower.visible = WorldConfig.getValue("functionSwitch","showLockTower");
         cmdTreasury.visible = WorldConfig.getValue("functionSwitch","showTreasuryConfig");
         cmdGodStyle.visible = WorldConfig.getValue("functionSwitch","showGodStyle");
         cmdTree.visible = WorldConfig.getValue("functionSwitch","showTreeConfig");
         cmdMagicCircle.visible = WorldConfig.getValue("functionSwitch","showMagicCircleConfig");
         cmdVacantSpace.visible = WorldConfig.getValue("functionSwitch","showVacantSpaceConfig");
         cmdItemManual.visible = WorldConfig.getValue("functionSwitch","showItemManual");
         cmdPassTicket.visible = WorldConfig.getValue("functionSwitch","showPassTicketConfig");
         cmdFeedGod.visible = WorldConfig.getValue("functionSwitch","showFeedGod");
         cmdForgeGod.visible = WorldConfig.getValue("functionSwitch","showForgeGodConfig");
         cmdGenieMagic.visible = WorldConfig.getValue("functionSwitch","showGenieMagic");
         cmdMakeChip.visible = WorldConfig.getValue("functionSwitch","showMakeChip");
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdArmory.addEventListener(MouseEvent.CLICK,this.obf_9_B_3369);
         cmdConstellation.addEventListener(MouseEvent.CLICK,this.obf_0_1_y_206);
         cmdBoss.addEventListener(MouseEvent.CLICK,this.obf_V_m_1051);
         cmdBone.addEventListener(MouseEvent.CLICK,this.obf_u_3_1716);
         cmdDragon.addEventListener(MouseEvent.CLICK,this.obf_0_7_B_602);
         cmdTower.addEventListener(MouseEvent.CLICK,this.obf_s_z_4326);
         cmdFruit.addEventListener(MouseEvent.CLICK,this.obf_b_k_2884);
         cmdStirp.addEventListener(MouseEvent.CLICK,this.onClickStirp);
         cmdGlyph.addEventListener(MouseEvent.CLICK,this.obf_r_C_4411);
         cmdManual.addEventListener(MouseEvent.CLICK,this.obf_M_p_3866);
         cmdFavor.addEventListener(MouseEvent.CLICK,this.obf_0_6_j_570);
         cmdChallge.addEventListener(MouseEvent.CLICK,this.obf_L_a_4294);
         cmdExt.addEventListener(MouseEvent.CLICK,this.obf_A_4268);
         cmdConsume.addEventListener(MouseEvent.CLICK,this.obf_U_u_1011);
         cmdAegis.addEventListener(MouseEvent.CLICK,this.clickAegis);
         cmdBaby.addEventListener(MouseEvent.CLICK,this.obf_0_3_X_437);
         cmdFate.addEventListener(MouseEvent.CLICK,this.obf_w_M_2540);
         cmdSoul.addEventListener(MouseEvent.CLICK,this.clickSoul);
         cmdCloak.addEventListener(MouseEvent.CLICK,this.obf_9_8_4516);
         cmdTotem.addEventListener(MouseEvent.CLICK,this.obf_9_G_1948);
         cmdChristmas.addEventListener(MouseEvent.CLICK,this.obf_q_W_1652);
         cmdRun.addEventListener(MouseEvent.CLICK,this.obf_0_6_m_89);
         fundBtn.addEventListener(MouseEvent.CLICK,this.obf_R_4671);
         cmdPlayerDevil.addEventListener(MouseEvent.CLICK,this.obf_I_M_3471);
         cmdReGrow.addEventListener(MouseEvent.CLICK,this.obf_g_1_2097);
         cmdCountry.addEventListener(MouseEvent.CLICK,this.obf_0_A_3373);
         cmdStarAdventure.addEventListener(MouseEvent.CLICK,this.obf_E_b_2262);
         cmdBook.addEventListener(MouseEvent.CLICK,this.onBook);
         cmdDevilGod.addEventListener(MouseEvent.CLICK,this.obf_h_x_4567);
         cmdAngel.addEventListener(MouseEvent.CLICK,this.obf_x_J_1141);
         cmdReward.addEventListener(MouseEvent.CLICK,this.obf_B_Q_2621);
         cmdSoulGuard.addEventListener(MouseEvent.CLICK,this.obf_M_I_4109);
         cmdDivine.addEventListener(MouseEvent.CLICK,this.obf_U_4154);
         cmdPocket.addEventListener(MouseEvent.CLICK,this.obf_I_4656);
         cmdBloodyWar.addEventListener(MouseEvent.CLICK,this.obf_B_P_3374);
         cmdIncubator.addEventListener(MouseEvent.CLICK,this.obf_T_r_860);
         cmdLockTower.addEventListener(MouseEvent.CLICK,this.obf_T_Q_945);
         cmdTreasury.addEventListener(MouseEvent.CLICK,this.obf_P_d_2928);
         cmdGodStyle.addEventListener(MouseEvent.CLICK,this.obf_Y_M_2958);
         cmdTree.addEventListener(MouseEvent.CLICK,this.obf_Y_b_3518);
         cmdMagicCircle.addEventListener(MouseEvent.CLICK,this.obf_j_m_4117);
         cmdVacantSpace.addEventListener(MouseEvent.CLICK,this.obf_y_3_2859);
         cmdItemManual.addEventListener(MouseEvent.CLICK,this.obf_1_5_4574);
         cmdPassTicket.addEventListener(MouseEvent.CLICK,this.obf_R_M_4195);
         cmdFeedGod.addEventListener(MouseEvent.CLICK,this.obf_4_C_4325);
         cmdForgeGod.addEventListener(MouseEvent.CLICK,this.obf_K_C_3785);
         cmdGenieMagic.addEventListener(MouseEvent.CLICK,this.obf_g_P_1967);
         cmdMakeChip.addEventListener(MouseEvent.CLICK,this.obf_7_a_1137);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdArmory.removeEventListener(MouseEvent.CLICK,this.obf_9_B_3369);
         cmdConstellation.removeEventListener(MouseEvent.CLICK,this.obf_0_1_y_206);
         cmdBoss.removeEventListener(MouseEvent.CLICK,this.obf_V_m_1051);
         cmdBone.removeEventListener(MouseEvent.CLICK,this.obf_u_3_1716);
         cmdDragon.removeEventListener(MouseEvent.CLICK,this.obf_0_7_B_602);
         cmdTower.removeEventListener(MouseEvent.CLICK,this.obf_s_z_4326);
         cmdFruit.removeEventListener(MouseEvent.CLICK,this.obf_b_k_2884);
         cmdStirp.removeEventListener(MouseEvent.CLICK,this.onClickStirp);
         cmdGlyph.removeEventListener(MouseEvent.CLICK,this.obf_r_C_4411);
         cmdManual.removeEventListener(MouseEvent.CLICK,this.obf_M_p_3866);
         cmdFavor.removeEventListener(MouseEvent.CLICK,this.obf_0_6_j_570);
         cmdChallge.removeEventListener(MouseEvent.CLICK,this.obf_L_a_4294);
         cmdExt.removeEventListener(MouseEvent.CLICK,this.obf_A_4268);
         cmdConsume.removeEventListener(MouseEvent.CLICK,this.obf_U_u_1011);
         cmdAegis.removeEventListener(MouseEvent.CLICK,this.clickAegis);
         cmdBaby.removeEventListener(MouseEvent.CLICK,this.obf_0_3_X_437);
         cmdSoul.addEventListener(MouseEvent.CLICK,this.clickSoul);
         cmdFate.removeEventListener(MouseEvent.CLICK,this.obf_w_M_2540);
         cmdCloak.removeEventListener(MouseEvent.CLICK,this.obf_9_8_4516);
         cmdTotem.removeEventListener(MouseEvent.CLICK,this.obf_9_G_1948);
         cmdChristmas.removeEventListener(MouseEvent.CLICK,this.obf_q_W_1652);
         cmdRun.removeEventListener(MouseEvent.CLICK,this.obf_0_6_m_89);
         fundBtn.removeEventListener(MouseEvent.CLICK,this.obf_R_4671);
         cmdPlayerDevil.removeEventListener(MouseEvent.CLICK,this.obf_I_M_3471);
         cmdReGrow.removeEventListener(MouseEvent.CLICK,this.obf_g_1_2097);
         cmdCountry.removeEventListener(MouseEvent.CLICK,this.obf_0_A_3373);
         cmdStarAdventure.removeEventListener(MouseEvent.CLICK,this.obf_E_b_2262);
         cmdBook.removeEventListener(MouseEvent.CLICK,this.onBook);
         cmdDevilGod.removeEventListener(MouseEvent.CLICK,this.obf_h_x_4567);
         cmdAngel.removeEventListener(MouseEvent.CLICK,this.obf_x_J_1141);
         cmdReward.removeEventListener(MouseEvent.CLICK,this.obf_B_Q_2621);
         cmdSoulGuard.removeEventListener(MouseEvent.CLICK,this.obf_M_I_4109);
         cmdDivine.removeEventListener(MouseEvent.CLICK,this.obf_U_4154);
         cmdPocket.removeEventListener(MouseEvent.CLICK,this.obf_I_4656);
         cmdBloodyWar.removeEventListener(MouseEvent.CLICK,this.obf_B_P_3374);
         cmdIncubator.removeEventListener(MouseEvent.CLICK,this.obf_T_r_860);
         cmdLockTower.removeEventListener(MouseEvent.CLICK,this.obf_T_Q_945);
         cmdTreasury.removeEventListener(MouseEvent.CLICK,this.obf_P_d_2928);
         cmdGodStyle.removeEventListener(MouseEvent.CLICK,this.obf_Y_M_2958);
         cmdTree.removeEventListener(MouseEvent.CLICK,this.obf_Y_b_3518);
         cmdMagicCircle.removeEventListener(MouseEvent.CLICK,this.obf_j_m_4117);
         cmdVacantSpace.removeEventListener(MouseEvent.CLICK,this.obf_y_3_2859);
         cmdItemManual.removeEventListener(MouseEvent.CLICK,this.obf_1_5_4574);
         cmdPassTicket.removeEventListener(MouseEvent.CLICK,this.obf_R_M_4195);
         cmdFeedGod.removeEventListener(MouseEvent.CLICK,this.obf_4_C_4325);
         cmdForgeGod.removeEventListener(MouseEvent.CLICK,this.obf_K_C_3785);
         cmdGenieMagic.removeEventListener(MouseEvent.CLICK,this.obf_g_P_1967);
         cmdMakeChip.removeEventListener(MouseEvent.CLICK,this.obf_7_a_1137);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - obf_K_e_3075.smallMapUI.width + 150;
         this.y = 50;
      }
      
      private function obf_9_B_3369(param1:Event) : void
      {
         if(obf_K_e_3075.obf_s_g_3090.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui ArmoryUI");
         }
         else if(obf_S_M_1257.obf_a_3592(true))
         {
            obf_F_2_2975.obf_O_p_3236("showui ArmoryUI");
         }
         this.closeUI();
      }
      
      private function obf_0_1_y_206(param1:Event) : void
      {
         if(!obf_K_e_3075.constellationUI)
         {
            return;
         }
         if(obf_K_e_3075.constellationUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.constellationUI);
         }
         else if(obf_H_B_2569.obf_M_4_3195())
         {
            obf_K_e_3075.showUI(obf_K_e_3075.constellationUI);
         }
         this.closeUI();
      }
      
      private function obf_V_m_1051(param1:MouseEvent) : void
      {
         if(!obf_K_e_3075.bossFeedUI)
         {
            return;
         }
         if(obf_K_e_3075.bossFeedUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.bossFeedUI);
         }
         else if(obf_F_9_1495.obf_0___q_426(true))
         {
            obf_K_e_3075.showUI(obf_K_e_3075.bossFeedUI);
         }
         this.closeUI();
      }
      
      private function obf_u_3_1716(param1:Event) : void
      {
         if(!obf_K_e_3075.boneUI)
         {
            return;
         }
         if(obf_K_e_3075.boneUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.boneUI);
         }
         else if(GameContext.localPlayer.fullInfo.boneLevel < 1)
         {
            if(obf_0_8_D_73.openBoneCon)
            {
               obf_0_8_D_73.sendOpenBone();
            }
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.boneUI);
         }
         this.closeUI();
      }
      
      private function obf_0_7_B_602(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.dragonBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.dragonBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.dragonBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_s_z_4326(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.towerBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.towerBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.towerBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_b_k_2884(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.fruitBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.fruitBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.fruitBoxUI);
         }
         this.closeUI();
      }
      
      private function onClickStirp(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.stirpBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.stirpBoxUI);
         }
         else if(obf_x_B_2963.checkOpenStirp())
         {
            obf_K_e_3075.showUI(obf_K_e_3075.stirpBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_r_C_4411(param1:MouseEvent) : void
      {
         if(!obf_K_e_3075.glyphBoxUI)
         {
            return;
         }
         if(obf_K_e_3075.glyphBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.glyphBoxUI);
         }
         else if(obf_Q_J_3925.obf_l_x_2668(true))
         {
            obf_K_e_3075.showUI(obf_K_e_3075.glyphBoxUI);
         }
         this.closeUI();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.magicCdTimel.checkTimeout())
         {
            if(this.isOpen == false)
            {
               if(ConditionScript.checkCondition(obf_V_C_3520.openCondition))
               {
                  cmdManual.filters = [];
                  this.isOpen = true;
               }
               else
               {
                  cmdManual.filters = [obf_9_V_1635.getGrayFilter()];
               }
            }
            if(obf_J_F_3431.obf_4_4696(JSONUtil.getStr(obf_s_W_2408.runConfig,["activityCode"])))
            {
               cmdRun.visible = true;
            }
            else
            {
               cmdRun.visible = false;
            }
         }
      }
      
      private function obf_M_p_3866(param1:Event) : void
      {
         if(!obf_K_e_3075.manualUI)
         {
            return;
         }
         if(obf_K_e_3075.manualUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.manualUI);
         }
         else if(obf_V_C_3520.obf_m_Z_1822(true))
         {
            obf_K_e_3075.showUI(obf_K_e_3075.manualUI);
         }
         this.closeUI();
      }
      
      private function obf_0_6_j_570(param1:Event) : void
      {
         if(!obf_K_e_3075.favorUI)
         {
            return;
         }
         if(obf_K_e_3075.favorUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.favorUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.favorUI);
         }
         this.closeUI();
      }
      
      private function obf_L_a_4294(param1:Event) : void
      {
         var _loc2_:int = obf_0_5_f_69.getOpenLevel();
         if(!obf_K_e_3075.obf_v_3_1831)
         {
            return;
         }
         if(obf_K_e_3075.obf_v_3_1831.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_v_3_1831);
         }
         else
         {
            if(GameContext.localPlayer.fullInfo.level < _loc2_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleLevel>=",[_loc2_]),null);
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.obf_v_3_1831);
            obf_0_5_f_69.sendRobotOpenRequest();
         }
         this.closeUI();
      }
      
      private function obf_A_4268(param1:Event) : void
      {
         if(!obf_K_e_3075.extractantUI)
         {
            return;
         }
         if(obf_K_e_3075.extractantUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.extractantUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.extractantUI);
         }
         this.closeUI();
      }
      
      private function obf_U_u_1011(param1:Event) : void
      {
         var _loc2_:Object = activityBoxManager.getConsumeRank();
         if(!_loc2_.activityCode || !obf_J_F_3431.obf_4_4696(_loc2_.activityCode))
         {
            WindowManager.showMessageBox(DiversityManager.getString("AstrictTimeUI","noOpen"));
            return;
         }
         if(!obf_K_e_3075.consumeRankingUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.consumeRankingUI);
         }
         this.closeUI();
      }
      
      private function clickAegis(param1:Event) : void
      {
         var _loc2_:int = obf_C_E_4362.getOpenLevel();
         if(!obf_K_e_3075.obf_L_G_3097)
         {
            return;
         }
         if(obf_K_e_3075.obf_L_G_3097.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_L_G_3097);
         }
         else
         {
            if(GameContext.localPlayer.fullInfo.level < _loc2_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleLevel>=",[_loc2_]),null);
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.obf_L_G_3097);
         }
         this.closeUI();
      }
      
      private function obf_0_3_X_437(param1:Event) : void
      {
         if(obf_K_e_3075.obf_7_S_4368.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_7_S_4368);
         }
         else if(obf_s_1265.obf_Z_x_4178())
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_7_S_4368);
         }
         this.closeUI();
      }
      
      private function obf_w_M_2540(param1:Event) : void
      {
         if(obf_K_e_3075.obf_P_2_4217.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_P_2_4217);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_P_2_4217);
         }
         this.closeUI();
      }
      
      private function clickSoul(param1:Event) : void
      {
         if(obf_K_e_3075.equAddSoulUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.equAddSoulUI);
         }
         else
         {
            if(obf_K_e_3075.devolveUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.devolveUI);
            }
            obf_K_e_3075.showUI(obf_K_e_3075.equAddSoulUI);
         }
         this.closeUI();
      }
      
      private function obf_9_8_4516(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.level < obf_b_T_3041.playerLv)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","maxLv",[obf_b_T_3041.playerLv]));
            return;
         }
         if(obf_K_e_3075.cloakBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.cloakBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.cloakBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_9_G_1948(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.level < obf_J_w_1685.playerLv)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemBoxUI","maxLv",[obf_J_w_1685.playerLv]));
            return;
         }
         if(obf_K_e_3075.totemBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.totemBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.totemBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_q_W_1652(param1:Event) : void
      {
         if(obf_K_e_3075.obf_T_j_1737.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_T_j_1737);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_T_j_1737);
         }
         this.closeUI();
      }
      
      private function obf_0_6_m_89(param1:Event) : void
      {
         if(!obf_K_e_3075.runningMan)
         {
            return;
         }
         if(obf_K_e_3075.runningMan.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.runningMan);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.runningMan);
         }
         this.closeUI();
      }
      
      private function obf_R_4671(param1:Event) : void
      {
         if(obf_K_e_3075.fundBgBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.fundBgBoxUI);
         }
         else
         {
            if(GameContext.localPlayer.fullInfo.level < obf_g_0_3344.getOpenLv)
            {
               WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleLevel>=",[obf_g_0_3344.getOpenLv]),null);
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.fundBgBoxUI);
         }
         this.closeUI();
      }
      
      private function obf_I_M_3471(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.rebornTimes < 3)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleRebornTimes>=",[3]),null);
            return;
         }
         if(obf_K_e_3075.playerDevilUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.playerDevilUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerDevilUI);
         }
      }
      
      private function obf_g_1_2097(param1:Event) : void
      {
         param1.stopPropagation();
         if(GameContext.localPlayer.fullInfo.rebornTimes < obf_o_H_2969.obf_1_Z_2231)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleRebornTimes>=",[obf_o_H_2969.obf_1_Z_2231]),null);
            return;
         }
         if(obf_K_e_3075.obf_a_A_1284.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_a_A_1284);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_a_A_1284);
         }
      }
      
      private function obf_0_A_3373(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_S_x_1774.countryOpenCond,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.countryUI)
         {
            return;
         }
         if(obf_K_e_3075.countryUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.countryUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.countryUI);
         }
         this.closeUI();
      }
      
      private function obf_E_b_2262(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(StarAdventureManager.starOpenCond,null,true))
         {
            return;
         }
         if(obf_K_e_3075.starAdventureUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.starAdventureUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.starAdventureUI);
         }
      }
      
      private function onBook(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_E_1429.obf_3_j_4189,null,true))
         {
            return;
         }
         if(obf_K_e_3075.playerBookUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.playerBookUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerBookUI);
         }
      }
      
      private function obf_h_x_4567(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(DevilGodManager.devilGodOpenCond,null,true))
         {
            return;
         }
         if(obf_K_e_3075.devilGodUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.devilGodUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.devilGodUI);
         }
      }
      
      private function obf_x_J_1141(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_O_7_1100.angelOpenCond,null,true))
         {
            return;
         }
         if(obf_K_e_3075.angelBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.angelBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.angelBoxUI);
         }
      }
      
      private function obf_B_Q_2621(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_Z_j_930.obf_0_9_J_142,null,true))
         {
            return;
         }
         if(obf_K_e_3075.obf_L_P_3638.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_L_P_3638);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_L_P_3638);
         }
      }
      
      private function obf_M_I_4109(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_4_3841.soulGuardOpenCond,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.soulGuardUI)
         {
            return;
         }
         if(obf_K_e_3075.soulGuardUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.soulGuardUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.soulGuardUI);
         }
      }
      
      private function obf_U_4154(param1:Event) : void
      {
         if(obf_K_e_3075.obf_O_S_1448.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_O_S_1448);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_O_S_1448);
         }
      }
      
      private function obf_I_4656(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_7_q_3477.openCondition,null,true))
         {
            return;
         }
         if(obf_K_e_3075.pocketSlotUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.pocketSlotUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.pocketSlotUI);
         }
      }
      
      private function obf_B_P_3374(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_g_4_2381.openCondition,null,true))
         {
            return;
         }
         if(obf_K_e_3075.bloodyWarUI.attackLevel <= 0 || obf_K_e_3075.bloodyWarUI.defenseLevel <= 0)
         {
            return;
         }
         if(obf_K_e_3075.bloodyWarUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.bloodyWarUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.bloodyWarUI);
         }
      }
      
      private function obf_T_r_860(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_8_m_2284.openCon,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.obf_P_I_3025)
         {
            return;
         }
         if(obf_K_e_3075.obf_P_I_3025.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_P_I_3025);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_P_I_3025);
         }
      }
      
      private function obf_T_Q_945(param1:Event) : void
      {
         param1.stopPropagation();
         if(!obf_K_e_3075.lockTowerUI.obf_t_R_1627)
         {
            return;
         }
         if(obf_K_e_3075.lockTowerUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.lockTowerUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.lockTowerUI);
         }
      }
      
      private function obf_P_d_2928(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_M_a_3122.openCon,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.obf_0___I_542)
         {
            return;
         }
         if(obf_K_e_3075.obf_0___I_542.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_0___I_542);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_0___I_542);
         }
      }
      
      private function obf_Y_M_2958(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_d_M_1152.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.godStyleUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.godStyleUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.godStyleUI);
         }
      }
      
      private function obf_Y_b_3518(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_v_0_1258.openCondition,null,true))
         {
            return;
         }
         if(obf_K_e_3075.treeBoxUI.obf_N_8_3570 <= 0 || obf_K_e_3075.treeBoxUI.obf_z_q_3358 <= 0)
         {
            return;
         }
         if(obf_K_e_3075.treeBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.treeBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.treeBoxUI);
         }
      }
      
      private function obf_j_m_4117(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_b_q_889.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.magicCircleUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.magicCircleUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.magicCircleUI);
         }
      }
      
      private function obf_y_3_2859(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_9_Y_4477.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.vacantSpaceUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.vacantSpaceUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.vacantSpaceUI);
         }
      }
      
      private function obf_1_5_4574(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(ItemManualManager.itemManualOpenCond,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.itemManualUI)
         {
            return;
         }
         if(obf_K_e_3075.itemManualUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.itemManualUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.itemManualUI);
         }
      }
      
      private function obf_R_M_4195(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(PassTicketManager.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.passTicketUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.passTicketUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.passTicketUI);
         }
      }
      
      private function obf_4_C_4325(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_0_6_H_238.obf_O_i_1541,null,true))
         {
            return;
         }
         if(obf_K_e_3075.obf_0_0_s_385.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_0_0_s_385);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_0_0_s_385);
         }
      }
      
      private function obf_K_C_3785(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_0_4_3_717.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.forgeGodUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.forgeGodUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.forgeGodUI);
         }
      }
      
      private function obf_g_P_1967(param1:Event) : void
      {
         if(!ConditionScript.checkCondition(obf_N_o_3647.genieMagicConfig.condition,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.genieMagicBoxUI)
         {
            return;
         }
         if(obf_K_e_3075.genieMagicBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.genieMagicBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.genieMagicBoxUI);
         }
      }
      
      private function obf_7_a_1137(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_u_Z_4014.makeChipOpenCond,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.makeChipBoxUI)
         {
            return;
         }
         if(obf_K_e_3075.makeChipBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.makeChipBoxUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.makeChipBoxUI);
         }
      }
      
      public function obf_Y_P_3051(param1:Object) : void
      {
         this.obf_D_h_4511 = param1;
         this.checkTime();
      }
      
      public function obf_0___E_374(param1:int, param2:int) : void
      {
         this.obf_R_u_4298 = param1;
         this.obf_h_T_3161 = param2;
         this.checkTime();
      }
      
      private function checkTime() : void
      {
         var _loc2_:* = undefined;
         this.obf_l_o_3389 = new Array();
         var _loc1_:int = 0;
         for each(_loc2_ in this.obf_D_h_4511)
         {
            this.obf_l_o_3389.push(_loc2_);
            _loc1_++;
         }
         if(_loc1_ > 0)
         {
            this.isAward = true;
         }
         else
         {
            this.isAward = false;
         }
         if(this.obf_R_u_4298 >= 0 && this.obf_h_T_3161 > -1)
         {
            this.obf_l_o_3389.push(this.obf_R_u_4298);
            this.isLandAward = true;
         }
         else
         {
            this.isLandAward = false;
         }
         this.obf_l_o_3389.sort();
         if(this.obf_l_o_3389.length > 0)
         {
            this.obf_n_2_1416 = this.obf_l_o_3389[0] * 1000;
         }
         this.obf_j_B_1080 = getTimer();
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         obf_9_V_1635.setSimpleButtonTooltip(cmdConstellation,DiversityManager.getString("SystemListUI","cmdConstellation"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdArmory,DiversityManager.getString("SystemListUI","cmdArmory"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBoss,DiversityManager.getString("SystemListUI","cmdBoss"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBone,DiversityManager.getString("SystemListUI","cmdBone"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDragon,DiversityManager.getString("SystemListUI","cmdDragon"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTower,DiversityManager.getString("SystemListUI","cmdTower"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFruit,DiversityManager.getString("SystemListUI","cmdFruit"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdStirp,DiversityManager.getString("SystemListUI","cmdStirp"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdGlyph,DiversityManager.getString("SystemListUI","cmdGlyph"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdManual,DiversityManager.getString("SystemListUI","cmdManual"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFavor,DiversityManager.getString("SystemListUI","cmdFavor"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdChallge,DiversityManager.getString("SystemListUI","cmdChallge"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdExt,DiversityManager.getString("SystemListUI","cmdExt"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdConsume,DiversityManager.getString("SystemListUI","cmdConsume"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdAegis,DiversityManager.getString("SystemListUI","cmdAegis"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBaby,DiversityManager.getString("SystemListUI","cmdBaby"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFate,DiversityManager.getString("SystemListUI","cmdFate"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSoul,DiversityManager.getString("SystemListUI","cmdSoul"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdCloak,DiversityManager.getString("SystemListUI","cmdCloak"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTotem,DiversityManager.getString("SystemListUI","cmdTotem"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdChristmas,DiversityManager.getString("SystemListUI","cmdChristmas"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRun,DiversityManager.getString("SystemListUI","cmdRun"));
         obf_9_V_1635.setSimpleButtonTooltip(fundBtn,DiversityManager.getString("SystemListUI","cmdFundBtn"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdPlayerDevil,DiversityManager.getString("SystemListUI","cmdPlayerDevil"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdReGrow,DiversityManager.getString("SystemListUI","cmdReGrow"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdCountry,DiversityManager.getString("SystemListUI","cmdCountry"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdStarAdventure,DiversityManager.getString("SystemListUI","cmdStarAdventure"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBook,DiversityManager.getString("SystemListUI","cmdBook"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDevilGod,DiversityManager.getString("SystemListUI","cmdDevilGod"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdAngel,DiversityManager.getString("SystemListUI","cmdAngel"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdReward,DiversityManager.getString("SystemListUI","cmdReward"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSoulGuard,DiversityManager.getString("SystemListUI","cmdSoulGuard"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDivine,DiversityManager.getString("SystemListUI","cmdDivine"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdPocket,DiversityManager.getString("SystemListUI","cmdPocket"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBloodyWar,DiversityManager.getString("ControlBarUI","cmdBloodyWar"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdIncubator,DiversityManager.getString("ControlBarUI","cmdIncubator"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdLockTower,DiversityManager.getString("ControlBarUI","cmdLockTower"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTreasury,DiversityManager.getString("ControlBarUI","cmdTreasury"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdGodStyle,DiversityManager.getString("ControlBarUI","cmdGodStyle"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTree,DiversityManager.getString("ControlBarUI","cmdTree"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdMagicCircle,DiversityManager.getString("ControlBarUI","cmdMagicCircle"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdVacantSpace,DiversityManager.getString("ControlBarUI","cmdVacantSpace"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdItemManual,DiversityManager.getString("SystemListUI","cmdItemManual"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdPassTicket,DiversityManager.getString("SystemListUI","cmdPassTicket"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFeedGod,DiversityManager.getString("SystemListUI","cmdFeedGod"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdForgeGod,DiversityManager.getString("ControlBarUI","cmdForgeGod"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdGenieMagic,DiversityManager.getString("ControlBarUI","cmdGenieMagic"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdMakeChip,DiversityManager.getString("ControlBarUI","cmdMakeChip"));
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

