package com.sunweb.game.rpg.playerUI.managers
{
   import obf_0___l_113.obf_o_z_3061;
   import obf_0_0_k_571.ConsumeRankingUI;
   import obf_0_0_k_571.obf_d_2906;
   import obf_0_0_k_571.obf_m_O_840;
   import obf_0_2_E_513.ReGrowUI;
   import obf_0_3_8_668.TreasuryMsgUI1;
   import obf_0_3_8_668.TreasuryMsgUI2;
   import obf_0_3_8_668.TreasuryUI;
   import obf_0_3_P_222.FateSkillUI;
   import obf_0_3_h_199.PassBonusUI;
   import obf_0_3_h_199.PassBoxUI;
   import obf_0_5_Z_663.*;
   import obf_0_6_V_260.SoulGuardUI;
   import obf_0_7_3_389.obf_0_3_b_114;
   import obf_0_7_3_389.obf_n_z_4508;
   import obf_0_8_3_434.AssembleBoxUI;
   import obf_0_8_3_434.AssembleListUI;
   import obf_0_8_s_590.AllOfPeopleBoonUI;
   import obf_0_8_s_590.FundUI;
   import obf_0_8_s_590.LocalTyrantFundUI;
   import obf_0_8_s_590.MonthCardUI;
   import obf_0_8_s_590.obf_j_g_2253;
   import obf_0_9_D_86.*;
   import obf_2_Q_4093.VarShopBoxUI;
   import obf_2_f_4313.RunningManUI;
   import obf_2_w_1664.DrgTreasureUI;
   import obf_8_d_4188.obf_q_s_2314;
   import obf_A_z_3492.BlessBoothUI;
   import obf_A_z_3492.obf_F_k_1994;
   import obf_A_z_3492.obf_J_X_3789;
   import obf_E_Z_3756.PlayerDevilUI;
   import obf_E_d_1594.*;
   import obf_H_1_3903.WheelAwardUI;
   import obf_I_Q_4451.SoulWeaponAssembleUI;
   import obf_I_Q_4451.SoulWeaponBoxUI;
   import obf_I_Q_4451.SoulWeaponEmbedUI;
   import obf_I_Q_4451.SoulWeaponLevelUpUI;
   import obf_I_x_2551.*;
   import obf_K_y_1096.*;
   import obf_L_D_4146.*;
   import obf_N_r_3650.DevilGodUI;
   import obf_N_r_3650.DevilGodUseMoneyUI;
   import obf_N_r_3650.DevilGodUsePetUI;
   import obf_U_i_2841.obf_0_6_r_163;
   import obf_V_K_965.CentShopUI;
   import obf_V_K_965.ChristmasUI;
   import obf_V_n_3191.ArtifactBoxUI;
   import obf_V_n_3191.ArtifactFusionUI;
   import obf_V_n_3191.ArtifactUpgradeUI;
   import obf_V_n_3191.obf_D_v_4539;
   import obf_V_n_3191.obf_T_X_2585;
   import obf_Z_P_2758.FateTurntableUI;
   import obf_a_2_2914.DivineUI;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_a_K_831.obf_n_W_1885;
   import obf_a_l_3879.PlayingCardUI;
   import obf_a_l_3879.obf_N_Q_1998;
   import obf_b_m_2084.obf_u_G_3778;
   import obf_c_C_2026.*;
   import obf_d_v_1084.obf_M_y_2523;
   import obf_e_7_2635.BotUI;
   import obf_g_4695.PassTicketBuyUI;
   import obf_g_4695.PassTicketUI;
   import obf_g_h_3906.obf_0___J_620;
   import obf_g_h_3906.obf_o_x_1741;
   import obf_g_v_3502.DayBonusUI;
   import obf_g_v_3502.obf_9_I_2505;
   import obf_g_v_3502.obf_d_F_1601;
   import obf_g_v_3502.obf_d_X_1947;
   import obf_g_v_3502.obf_p_3_4085;
   import obf_l_e_4270.SuccessUI;
   import obf_n_k_1384.IncubatorUI;
   import obf_p_w_3235.*;
   import obf_t_1_3551.obf_0_0_9_431;
   import obf_y_c_1778.obf_0_5_K_355;
   import obf_y_c_1778.obf_7_o_1130;
   import obf_y_c_1778.obf_v_8_2756;
   import obf_y_y_3106.*;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.module.GMControlBox;
   import com.sunweb.game.rpg.module.obf_y_g_4410;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.*;
   import com.sunweb.game.rpg.playerUI.activity.ActivityUI;
   import com.sunweb.game.rpg.playerUI.aegis.AegisBoxUI;
   import com.sunweb.game.rpg.playerUI.angel.AngelBoxUI;
   import com.sunweb.game.rpg.playerUI.armory.ArmoryUI;
   import com.sunweb.game.rpg.playerUI.armory.obf_i_4634;
   import com.sunweb.game.rpg.playerUI.armory.obf_q_8_3582;
   import com.sunweb.game.rpg.playerUI.baby.obf_0_5_U_359;
   import com.sunweb.game.rpg.playerUI.baby.obf_1_G_942;
   import com.sunweb.game.rpg.playerUI.baby.obf_F_6_4136;
   import com.sunweb.game.rpg.playerUI.baby.obf_a_r_3881;
   import com.sunweb.game.rpg.playerUI.baby.obf_x_A_3522;
   import com.sunweb.game.rpg.playerUI.bone.obf_L_B_2784;
   import com.sunweb.game.rpg.playerUI.cloak.CloakBoxUI;
   import com.sunweb.game.rpg.playerUI.constellation.ConstellationUI;
   import com.sunweb.game.rpg.playerUI.country.CountryUI;
   import com.sunweb.game.rpg.playerUI.dragon.obf_p_k_2342;
   import com.sunweb.game.rpg.playerUI.druid.obf_S_8_3817;
   import com.sunweb.game.rpg.playerUI.equ.kindGrow.EquipKindGrowBlessUI;
   import com.sunweb.game.rpg.playerUI.equ.kindGrow.obf_0_1_e_423;
   import com.sunweb.game.rpg.playerUI.equ.kindGrow.obf_D_r_3256;
   import com.sunweb.game.rpg.playerUI.extractant.obf_S_1_1969;
   import com.sunweb.game.rpg.playerUI.extractant.obf_f_d_4224;
   import com.sunweb.game.rpg.playerUI.family.*;
   import com.sunweb.game.rpg.playerUI.favor.obf_0_9_B_282;
   import com.sunweb.game.rpg.playerUI.feedGod.FeedGodUI;
   import com.sunweb.game.rpg.playerUI.genie.GenieBoxUI;
   import com.sunweb.game.rpg.playerUI.glyph.obf_B_q_4166;
   import com.sunweb.game.rpg.playerUI.glyph.obf_Q_m_1583;
   import com.sunweb.game.rpg.playerUI.glyph.obf_p_B_4082;
   import com.sunweb.game.rpg.playerUI.godStyle.obf_0___K_424;
   import com.sunweb.game.rpg.playerUI.itemManual.ItemManualUI;
   import com.sunweb.game.rpg.playerUI.legend.EnchaseUI;
   import com.sunweb.game.rpg.playerUI.legend.LegendUI;
   import com.sunweb.game.rpg.playerUI.legend.MonsterNumUI;
   import com.sunweb.game.rpg.playerUI.legend.UpgradeUI;
   import com.sunweb.game.rpg.playerUI.mail.*;
   import com.sunweb.game.rpg.playerUI.manual.ManualUI;
   import com.sunweb.game.rpg.playerUI.map.*;
   import com.sunweb.game.rpg.playerUI.mapWrapper.CopyWorldInfoUI;
   import com.sunweb.game.rpg.playerUI.pet.*;
   import com.sunweb.game.rpg.playerUI.petDepot.PetDepotUI;
   import com.sunweb.game.rpg.playerUI.playerBook.obf_g_b_924;
   import com.sunweb.game.rpg.playerUI.playerInfo.*;
   import com.sunweb.game.rpg.playerUI.ranking.RankingUI;
   import com.sunweb.game.rpg.playerUI.renew.*;
   import com.sunweb.game.rpg.playerUI.ride.*;
   import com.sunweb.game.rpg.playerUI.rideDepot.RideDepotUI;
   import com.sunweb.game.rpg.playerUI.roulette.RouletteUI;
   import com.sunweb.game.rpg.playerUI.shop.*;
   import com.sunweb.game.rpg.playerUI.skill.*;
   import com.sunweb.game.rpg.playerUI.starAdventure.StarAdventureUI;
   import com.sunweb.game.rpg.playerUI.stirp.obf_O_0_3870;
   import com.sunweb.game.rpg.playerUI.systems.*;
   import com.sunweb.game.rpg.playerUI.team.*;
   import com.sunweb.game.rpg.playerUI.totem.TotemBoxUI;
   import com.sunweb.game.rpg.playerUI.totem.TotemEvolveUI;
   import com.sunweb.game.rpg.playerUI.totem.TotemOfferUI;
   import com.sunweb.game.rpg.playerUI.totem.TotemTrialUI;
   import com.sunweb.game.rpg.playerUI.tower.obf_9_y_2827;
   import com.sunweb.game.rpg.playerUI.wardrobe.WardrobeUI;
   import com.sunweb.game.rpg.playerUI.wing.WingBoxUI;
   import com.sunweb.game.rpg.playerUI.wingSpirit.WingSpiritUI;
   import com.sunweb.game.rpg.role.LocalPlayerInfo;
   import com.sunweb.game.rpg.role.RemotePlayerViewInfo;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.world.ui.MouseCursor;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gs.TweenLite;
   import gs.easing.obf_u_l_3524;
   
   public class obf_K_e_3075
   {
      
      private static var _uiSprite:Sprite;
      
      public static var playerInfoUI:PlayerInfoUI;
      
      public static var targetInfoUI:TargetInfoUI;
      
      public static var wingBoxUI:WingBoxUI;
      
      public static var obf_N_Y_1566:Object;
      
      public static var rideControlUI:RideControlUI;
      
      public static var shortcutUI:ShortcutUI;
      
      public static var singBarUI:SingBarUI;
      
      public static var systemInfoUI:obf_2_5_1204;
      
      public static var systemAlwaysInfoUI:obf_y_4399;
      
      public static var systemScoreUI:obf_p_q_2942;
      
      public static var obf_e_q_2572:GameInfoUI;
      
      public static var obf_e_H_1407:obf_0_8_2_554;
      
      public static var equipLowDurUI:obf_D_v_4539;
      
      public static var smallMapUI:SmallMapUI;
      
      public static var mapUI:MapUI;
      
      public static var worldMapUI:WorldMapUI;
      
      public static var systemListUI:SystemListUI;
      
      public static var obf_a_S_1814:ControlBarUI;
      
      public static var activityUI:ActivityUI;
      
      public static var obf_w_f_4556:obf_b_4_4102;
      
      public static var familyBoxUI:FamilyBoxUI;
      
      public static var familyListUI:FamilyListUI;
      
      public static var familyViewUI:FamilyViewUI;
      
      public static var familyPostListUI:FamilyPostListUI;
      
      public static var familyJoinListUI:FamilyJoinListUI;
      
      public static var familyTaskListUI:FamilyTaskListUI;
      
      public static var familyVarListUI:obf_k_H_3776;
      
      public static var expBarUI:obf_T_F_4253;
      
      public static var singeSpUI:obf_L_W_1229;
      
      public static var systemSettingUI:obf_i_w_3105;
      
      public static var systemTipUI:SystemTipUI;
      
      public static var fashionViewUI:FashionShowUI;
      
      public static var obf_8_r_4095:RenewListUI;
      
      public static var obf_t_q_3040:RenewPlanUI;
      
      public static var obf_5_i_2480:EmbedBoxUI;
      
      public static var refineBoxUI:RefineBoxUI;
      
      public static var obf_4_S_4444:DecBoxUI;
      
      public static var drgTreasureUI:DrgTreasureUI;
      
      public static var wheelAwardUI:WheelAwardUI;
      
      public static var mailListUI:MailListUI;
      
      public static var mailViewUI:MailViewUI;
      
      public static var mailSendUI:MailSendUI;
      
      public static var obf_o_J_3931:obf_0_3_b_114;
      
      public static var playerBoxUI:obf_V_U_1704;
      
      public static var playerFullInfoUI:obf_0_3_z_548;
      
      public static var obf_J_K_2135:MindBox;
      
      public static var animalBoxUI:obf_B_K_856;
      
      public static var obf_G_K_2049:obf_B_x_944;
      
      public static var playerTitleUI:PlayerTitleUI;
      
      public static var skillBookUI:SkillBookUI;
      
      public static var fateSkillUI:FateSkillUI;
      
      public static var playerBlessUI:obf_J_X_3789;
      
      public static var blessBoothUI:BlessBoothUI;
      
      public static var obf_d_7_1584:obf_F_k_1994;
      
      public static var playerBagUI:PlayerBagUI;
      
      public static var depotBagUI:DepotBagUI;
      
      public static var depotTwoBagUI:DepotTwoBagUI;
      
      public static var depotThreeBagUI:DepotThreeBagUI;
      
      public static var tempBagUI:TempBagUI;
      
      public static var rideBoxUI:RideBoxUI;
      
      public static var petBoxContainerUI:PetBoxContainerUI;
      
      public static var petBoxUI:PetBoxUI;
      
      public static var genieBoxUI:GenieBoxUI;
      
      public static var petEnhanceUI:PetEnhanceUI;
      
      public static var petAssembleBoxUI:obf_O_U_751;
      
      public static var petFusionUI:PetFusionUI;
      
      public static var obf_N_i_3901:ShopBoxUI;
      
      public static var equipRepairUI:EquipRepairUI;
      
      public static var npcShopUI:NpcShopUI;
      
      public static var obf_W_a_1063:PlayerFarmManagerUI;
      
      public static var magicMotionUI:MagicMotionUI;
      
      public static var npcTalkBox:NpcTalkBoxUI;
      
      public static var playerTaskUI:PlayerTaskUI;
      
      public static var obf_0___5_510:TaskTracerUI;
      
      public static var successUI:SuccessUI;
      
      public static var obf_G_u_2663:obf_0_5_K_355;
      
      public static var obf_u_p_3828:obf_v_8_2756;
      
      public static var obf_P_c_3266:obf_7_o_1130;
      
      public static var assembleBoxUI:AssembleBoxUI;
      
      public static var assembleListUI:AssembleListUI;
      
      public static var artifactBoxUI:ArtifactBoxUI;
      
      public static var artifactUpgradeUI:ArtifactUpgradeUI;
      
      public static var artifactFusionUI:ArtifactFusionUI;
      
      public static var equipmentLetteringUI:obf_T_X_2585;
      
      public static var soulWeaponBoxUI:SoulWeaponBoxUI;
      
      public static var soulLevelUpUI:SoulWeaponLevelUpUI;
      
      public static var soulAssembleUI:SoulWeaponAssembleUI;
      
      public static var soulEmbedUI:SoulWeaponEmbedUI;
      
      public static var teamUI:TeamUI;
      
      public static var teamManagerUI:TeamManagerUI;
      
      public static var itemRollUI:obf_0_0_9_431;
      
      public static var dayBonusUI:DayBonusUI;
      
      public static var onlineBonusUI:OnlineBonusUI;
      
      public static var offlineBonusUI:OfflineBonusUI;
      
      public static var obf_L_9_3749:SysMsgUI;
      
      public static var daysActPromptUI:DaysActPromptUI;
      
      public static var rankingUI:RankingUI;
      
      public static var locationTagUI:LocationTagUI;
      
      public static var obf_l_H_2916:AgentUI;
      
      public static var tradeUI:TradeUI;
      
      public static var tradeCheckUI:obf_j_i_3132;
      
      public static var boothUI:BoothUI;
      
      public static var boothSellUI:obf_g_Z_3839;
      
      public static var boothBfmUI:obf_0___4_699;
      
      public static var boothViewUI:obf_h_N_1687;
      
      public static var boothSellViewUI:obf_0_6_O_278;
      
      public static var boothBfmViewUI:obf_0_8_U_592;
      
      public static var boothItemUI:obf_b_4658;
      
      public static var boothBfmWim:obf_s_h_3802;
      
      public static var buffUI:BuffUI;
      
      public static var debuffUI:BuffUI;
      
      public static var obf_f_a_l_s_e_334:BotUI;
      
      public static var obf_z_1_3064:obf_s_A_2037;
      
      public static var gmControlBox:GMControlBox;
      
      public static var facebookUI:obf_4_B_1970;
      
      public static var newShopBoxUI:NewShopBoxUI;
      
      public static var obf_r_d_3196:obf_d_X_1947;
      
      public static var obf_N_5_4623:obf_9_I_2505;
      
      public static var obf_S_w_2923:obf_d_F_1601;
      
      public static var obf_1_p_1763:obf_p_3_4085;
      
      public static var obf_0_3_j_588:PlayingCardUI;
      
      public static var obf_Z_G_2885:obf_N_Q_1998;
      
      public static var obf_y_P_4288:RouletteUI;
      
      public static var constellationUI:ConstellationUI;
      
      public static var stirpBoxUI:obf_O_0_3870;
      
      public static var obf_s_g_3090:ArmoryUI;
      
      public static var armoryUpgradeUI:obf_i_4634;
      
      public static var armoryComposeUI:obf_q_8_3582;
      
      public static var bossFeedUI:obf_M_y_2523;
      
      public static var boneUI:obf_L_B_2784;
      
      public static var dragonBoxUI:obf_p_k_2342;
      
      public static var passBoxUI:PassBoxUI;
      
      public static var obf_R_k_2832:PassBonusUI;
      
      public static var obf_7_u_1223:obf_n_z_4508;
      
      public static var towerBoxUI:obf_9_y_2827;
      
      public static var armyShopUI:ArmyShopBoxUI;
      
      public static var rideFusionUI:RideFusionUI;
      
      public static var fruitBoxUI:obf_o_z_3061;
      
      public static var glyphBoxUI:obf_p_B_4082;
      
      public static var depictBoxUI:obf_B_q_4166;
      
      public static var roomBoxUI:obf_Q_m_1583;
      
      public static var manualUI:ManualUI;
      
      public static var obf_b_M_1918:obf_m_O_840;
      
      public static var consumeRankingUI:ConsumeRankingUI;
      
      public static var taxisBoxUI:obf_d_2906;
      
      public static var favorUI:obf_0_9_B_282;
      
      public static var obf_v_3_1831:obf_u_G_3778;
      
      public static var druidBoxUI:obf_S_8_3817;
      
      public static var extractantUI:obf_S_1_1969;
      
      public static var extractantUpUI:obf_f_d_4224;
      
      public static var obf_L_G_3097:AegisBoxUI;
      
      public static var obf_y_X_2167:obf_1_G_942;
      
      public static var obf_R_v_3742:obf_0_5_U_359;
      
      public static var worldUI:obf_F_6_4136;
      
      public static var obf_g_7_4476:obf_a_r_3881;
      
      public static var obf_7_S_4368:obf_x_A_3522;
      
      public static var obf_P_2_4217:FateTurntableUI;
      
      public static var legendUI:LegendUI;
      
      public static var upgradeUI:UpgradeUI;
      
      public static var obf_8_C_1943:EnchaseUI;
      
      public static var monsterNumUI:MonsterNumUI;
      
      public static var equAddSoulUI:EquAddSoulUI;
      
      public static var devolveUI:DevolveUI;
      
      public static var cloakBoxUI:CloakBoxUI;
      
      public static var petDepotUI:PetDepotUI;
      
      public static var playerAttrChangeUI:PlayerAttrChangeUI;
      
      public static var rideDepotUI:RideDepotUI;
      
      public static var totemBoxUI:TotemBoxUI;
      
      public static var totemTrialUI:TotemTrialUI;
      
      public static var totemOfferUI:TotemOfferUI;
      
      public static var totemEvolveUI:TotemEvolveUI;
      
      public static var obf_0___Z_558:WardrobeUI;
      
      public static var obf_T_j_1737:ChristmasUI;
      
      public static var centShopUI:CentShopUI;
      
      public static var runningMan:RunningManUI;
      
      public static var fundBgBoxUI:obf_j_g_2253;
      
      public static var fundUI:FundUI;
      
      public static var allOfPeopleBoonUI:AllOfPeopleBoonUI;
      
      public static var localTyrantFundUI:LocalTyrantFundUI;
      
      public static var monthCardUI:MonthCardUI;
      
      public static var wingSpiritUI:WingSpiritUI;
      
      public static var playerDevilUI:PlayerDevilUI;
      
      public static var obf_a_A_1284:ReGrowUI;
      
      public static var countryUI:CountryUI;
      
      public static var rideEquipUI:obf_A_f_3024;
      
      public static var rideStrengthUI:obf_0_3_H_64;
      
      public static var rideEquipRefineUI:RideEquipRefineUI;
      
      public static var rideEquipRecreateUI:obf_5_t_2132;
      
      public static var rideEquipInheritUI:obf_s_e_4550;
      
      public static var starAdventureUI:StarAdventureUI;
      
      public static var playerBookUI:obf_g_b_924;
      
      public static var devilGodUI:DevilGodUI;
      
      public static var devilGodUseMoneyUI:DevilGodUseMoneyUI;
      
      public static var devilGodUsePetUI:DevilGodUsePetUI;
      
      public static var angelBoxUI:AngelBoxUI;
      
      public static var obf_L_P_3638:obf_D_o_4484;
      
      public static var obf_w_0_3587:obf_H_F_3333;
      
      public static var obf_0_8_g_462:obf_9_s_996;
      
      public static var obf_F_e_3603:obf_K_x_958;
      
      public static var obf_t_6_3555:obf_F_j_4177;
      
      public static var obf_0___i_152:obf_z_6_2219;
      
      public static var equipKindGrowUI:obf_D_r_3256;
      
      public static var equipKindGrowBlessUI:EquipKindGrowBlessUI;
      
      public static var equipKindGrowTemperUI:obf_0_1_e_423;
      
      public static var varShopBoxUI:VarShopBoxUI;
      
      public static var soulGuardUI:SoulGuardUI;
      
      public static var obf_O_S_1448:DivineUI;
      
      public static var pocketSlotUI:obf_C_5_3793;
      
      public static var pocketItemUI:obf_z_4632;
      
      public static var inOutItemUI:obf_5_O_3402;
      
      public static var bloodyWarUI:obf_5_X_1155;
      
      public static var obf_t_P_3183:obf_M_Z_1297;
      
      public static var obf_P_I_3025:IncubatorUI;
      
      public static var lockTowerUI:obf_a_6_3688;
      
      public static var lockTowerUpUI:obf_y_A_3392;
      
      public static var lockTowerEatUI:obf_T_7_2588;
      
      public static var lockTowerFreeUI:obf_p_J_2393;
      
      public static var lockTowerInitUI:obf_U_4_1625;
      
      public static var obf_0___I_542:TreasuryUI;
      
      public static var obf_n_q_2526:TreasuryMsgUI1;
      
      public static var obf_t_h_r_o_w_539:TreasuryMsgUI2;
      
      public static var godStyleUI:obf_0___K_424;
      
      public static var treeBoxUI:obf_n_W_1885;
      
      public static var magicCircleUI:obf_0_6_r_163;
      
      public static var vacantSpaceUI:obf_o_x_1741;
      
      public static var vacantSpaceBallUI:obf_0___J_620;
      
      public static var itemManualUI:ItemManualUI;
      
      public static var passTicketUI:PassTicketUI;
      
      public static var passTicketBuyUI:PassTicketBuyUI;
      
      public static var obf_0_0_s_385:FeedGodUI;
      
      public static var forgeGodUI:obf_q_s_2314;
      
      public static var genieMagicBloodUI:obf_2_a_2127;
      
      public static var genieMagicSummonUI:obf_0_9_N_71;
      
      public static var genieMagicSkillUI:obf_N_h_2881;
      
      public static var genieMagicBoxUI:GenieMagicBoxUI;
      
      public static var makeChipBoxUI:MakeChipBoxUI;
      
      public static var makeChipUI:MakeChipUI;
      
      public static var obf_6_R_3560:CopyWorldInfoUI;
      
      private static var obf_p_K_2036:Boolean;
      
      private static var obf_s_v_3083:String;
      
      private static var uiTween:TweenLite;
      
      private static var obf_0_5_x_233:TimeLimiter = new TimeLimiter(1000);
      
      public static const obf_s_r_1801:String = "none";
      
      public static const obf_m_J_4374:String = "sell";
      
      public static const obf_o_7_2612:String = "split";
      
      public static const obf_2_N_1475:String = "repair";
      
      public static const obf_J_o_4558:String = "use";
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      public function obf_K_e_3075()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         var _loc3_:Object = null;
         if(_uiSprite)
         {
            while(_uiSprite.numChildren > 0)
            {
               _uiSprite.removeChildAt(0);
            }
         }
         _uiSprite = param1;
         obf_c_D_2721 = obf_s_r_1801;
         addListener();
         obf_z_1_3064 = new obf_s_A_2037();
         systemInfoUI = new obf_2_5_1204();
         systemAlwaysInfoUI = new obf_y_4399();
         systemScoreUI = new obf_p_q_2942();
         _uiSprite.addChild(systemInfoUI);
         obf_L_9_3749 = new SysMsgUI();
         mailListUI = new MailListUI();
         mailViewUI = new MailViewUI();
         mailSendUI = new MailSendUI();
         playerInfoUI = new PlayerInfoUI();
         _uiSprite.addChild(playerInfoUI);
         obf_e_q_2572 = new GameInfoUI();
         _uiSprite.addChild(obf_e_q_2572);
         obf_e_H_1407 = new obf_0_8_2_554();
         _uiSprite.addChild(obf_e_H_1407);
         obf_a_S_1814 = new ControlBarUI();
         _uiSprite.addChild(obf_a_S_1814);
         shortcutUI = new ShortcutUI();
         _uiSprite.addChild(shortcutUI);
         expBarUI = new obf_T_F_4253();
         showUI(expBarUI);
         singeSpUI = new obf_L_W_1229();
         showUI(singeSpUI);
         equipLowDurUI = new obf_D_v_4539();
         targetInfoUI = new TargetInfoUI();
         rideControlUI = new RideControlUI();
         singBarUI = new SingBarUI();
         _uiSprite.addChild(singBarUI);
         teamUI = new TeamUI();
         showUI(teamUI);
         teamManagerUI = new TeamManagerUI();
         itemRollUI = new obf_0_0_9_431();
         buffUI = new BuffUI();
         buffUI.x = 255;
         buffUI.y = 0;
         showUI(buffUI);
         debuffUI = new BuffUI();
         debuffUI.x = buffUI.x;
         debuffUI.y = buffUI.y + 45;
         showUI(debuffUI);
         smallMapUI = new SmallMapUI();
         _uiSprite.addChild(smallMapUI);
         systemListUI = new SystemListUI();
         facebookUI = new obf_4_B_1970();
         _uiSprite.addChild(facebookUI);
         mapUI = new MapUI();
         mapUI.x = GameContext.gameStage.stageWidth / 2;
         mapUI.y = GameContext.gameStage.stageHeight / 2;
         mapUI.visible = false;
         obf_W_a_1063 = new PlayerFarmManagerUI();
         obf_W_a_1063.x = GameContext.gameStage.stageWidth / 2;
         obf_W_a_1063.y = GameContext.gameStage.stageHeight / 2;
         magicMotionUI = new MagicMotionUI();
         obf_w_f_4556 = new obf_b_4_4102();
         familyBoxUI = new FamilyBoxUI();
         familyListUI = new FamilyListUI();
         familyViewUI = new FamilyViewUI();
         familyPostListUI = new FamilyPostListUI();
         familyJoinListUI = new FamilyJoinListUI();
         familyTaskListUI = new FamilyTaskListUI();
         familyVarListUI = new obf_k_H_3776();
         skillBookUI = new SkillBookUI();
         fateSkillUI = new FateSkillUI();
         playerBlessUI = new obf_J_X_3789();
         blessBoothUI = new BlessBoothUI();
         obf_d_7_1584 = new obf_F_k_1994();
         playerFullInfoUI = new obf_0_3_z_548();
         obf_J_K_2135 = new MindBox();
         animalBoxUI = new obf_B_K_856();
         obf_G_K_2049 = new obf_B_x_944();
         playerBoxUI = new obf_V_U_1704();
         playerTitleUI = new PlayerTitleUI();
         petBoxUI = new PetBoxUI();
         petAssembleBoxUI = new obf_O_U_751();
         petEnhanceUI = new PetEnhanceUI();
         petFusionUI = new PetFusionUI();
         genieBoxUI = new GenieBoxUI();
         obf_G_u_2663 = new obf_0_5_K_355();
         obf_P_c_3266 = new obf_7_o_1130();
         obf_u_p_3828 = new obf_v_8_2756();
         petBoxContainerUI = new PetBoxContainerUI();
         playerBagUI = new PlayerBagUI();
         rideBoxUI = new RideBoxUI();
         wingBoxUI = new WingBoxUI();
         depotBagUI = new DepotBagUI();
         depotTwoBagUI = new DepotTwoBagUI();
         depotThreeBagUI = new DepotThreeBagUI();
         tempBagUI = new TempBagUI();
         obf_8_r_4095 = new RenewListUI();
         obf_t_q_3040 = new RenewPlanUI();
         obf_5_i_2480 = new EmbedBoxUI();
         refineBoxUI = new RefineBoxUI();
         obf_4_S_4444 = new DecBoxUI();
         drgTreasureUI = new DrgTreasureUI();
         wheelAwardUI = new WheelAwardUI();
         playerTaskUI = new PlayerTaskUI();
         obf_0___5_510 = new TaskTracerUI();
         successUI = new SuccessUI();
         assembleBoxUI = new AssembleBoxUI();
         assembleListUI = new AssembleListUI();
         artifactUpgradeUI = new ArtifactUpgradeUI();
         artifactFusionUI = new ArtifactFusionUI();
         artifactBoxUI = new ArtifactBoxUI();
         equipmentLetteringUI = new obf_T_X_2585();
         soulLevelUpUI = new SoulWeaponLevelUpUI();
         soulAssembleUI = new SoulWeaponAssembleUI();
         soulEmbedUI = new SoulWeaponEmbedUI();
         soulWeaponBoxUI = new SoulWeaponBoxUI();
         npcShopUI = new NpcShopUI();
         obf_N_i_3901 = new ShopBoxUI();
         obf_N_i_3901.visible = false;
         obf_N_i_3901.x = GameContext.gameStage.stageWidth / 2;
         obf_N_i_3901.y = GameContext.gameStage.stageHeight / 2;
         armyShopUI = new ArmyShopBoxUI();
         equipRepairUI = new EquipRepairUI();
         fashionViewUI = new FashionShowUI();
         obf_l_H_2916 = new AgentUI();
         tradeUI = new TradeUI();
         tradeCheckUI = new obf_j_i_3132();
         boothBfmUI = new obf_0___4_699();
         boothSellUI = new obf_g_Z_3839();
         boothUI = new BoothUI();
         boothSellViewUI = new obf_0_6_O_278();
         boothBfmViewUI = new obf_0_8_U_592();
         boothViewUI = new obf_h_N_1687();
         boothItemUI = new obf_b_4658();
         worldMapUI = new WorldMapUI();
         worldMapUI.x = GameContext.gameStage.stageWidth / 2;
         worldMapUI.y = GameContext.gameStage.stageHeight / 2;
         worldMapUI.visible = false;
         obf_f_a_l_s_e_334 = new BotUI();
         onlineBonusUI = new OnlineBonusUI();
         offlineBonusUI = new OfflineBonusUI();
         dayBonusUI = new DayBonusUI();
         daysActPromptUI = new DaysActPromptUI();
         activityUI = new ActivityUI();
         rankingUI = new RankingUI();
         locationTagUI = new LocationTagUI();
         gmControlBox = new GMControlBox();
         obf_o_J_3931 = new obf_0_3_b_114();
         obf_7_u_1223 = new obf_n_z_4508();
         newShopBoxUI = new NewShopBoxUI();
         obf_S_w_2923 = new obf_d_F_1601();
         obf_1_p_1763 = new obf_p_3_4085();
         obf_N_5_4623 = new obf_9_I_2505();
         obf_r_d_3196 = new obf_d_X_1947();
         systemSettingUI = new obf_i_w_3105();
         _uiSprite.addChild(systemSettingUI);
         _uiSprite.removeChild(systemSettingUI);
         obf_0_3_j_588 = new PlayingCardUI();
         obf_Z_G_2885 = new obf_N_Q_1998();
         obf_y_P_4288 = new RouletteUI();
         constellationUI = new ConstellationUI();
         stirpBoxUI = new obf_O_0_3870();
         armoryUpgradeUI = new obf_i_4634();
         armoryComposeUI = new obf_q_8_3582();
         obf_s_g_3090 = new ArmoryUI();
         bossFeedUI = new obf_M_y_2523();
         boneUI = new obf_L_B_2784();
         dragonBoxUI = new obf_p_k_2342();
         passBoxUI = new PassBoxUI();
         obf_R_k_2832 = new PassBonusUI();
         towerBoxUI = new obf_9_y_2827();
         rideFusionUI = new RideFusionUI();
         fruitBoxUI = new obf_o_z_3061();
         depictBoxUI = new obf_B_q_4166();
         roomBoxUI = new obf_Q_m_1583();
         glyphBoxUI = new obf_p_B_4082();
         manualUI = new ManualUI();
         obf_b_M_1918 = new obf_m_O_840();
         consumeRankingUI = new ConsumeRankingUI();
         taxisBoxUI = new obf_d_2906();
         favorUI = new obf_0_9_B_282();
         obf_v_3_1831 = new obf_u_G_3778();
         druidBoxUI = new obf_S_8_3817();
         extractantUI = new obf_S_1_1969();
         extractantUpUI = new obf_f_d_4224();
         obf_L_G_3097 = new AegisBoxUI();
         obf_y_X_2167 = new obf_1_G_942();
         obf_R_v_3742 = new obf_0_5_U_359();
         worldUI = new obf_F_6_4136();
         obf_g_7_4476 = new obf_a_r_3881();
         obf_7_S_4368 = new obf_x_A_3522();
         obf_P_2_4217 = new FateTurntableUI();
         monsterNumUI = new MonsterNumUI();
         upgradeUI = new UpgradeUI();
         obf_8_C_1943 = new EnchaseUI();
         legendUI = new LegendUI();
         equAddSoulUI = new EquAddSoulUI();
         devolveUI = new DevolveUI();
         cloakBoxUI = new CloakBoxUI();
         petDepotUI = new PetDepotUI();
         playerAttrChangeUI = new PlayerAttrChangeUI();
         rideDepotUI = new RideDepotUI();
         totemTrialUI = new TotemTrialUI();
         totemOfferUI = new TotemOfferUI();
         totemEvolveUI = new TotemEvolveUI();
         totemBoxUI = new TotemBoxUI();
         obf_0___Z_558 = new WardrobeUI();
         obf_T_j_1737 = new ChristmasUI();
         centShopUI = new CentShopUI();
         runningMan = new RunningManUI();
         fundUI = new FundUI();
         localTyrantFundUI = new LocalTyrantFundUI();
         allOfPeopleBoonUI = new AllOfPeopleBoonUI();
         monthCardUI = new MonthCardUI();
         fundBgBoxUI = new obf_j_g_2253();
         wingSpiritUI = new WingSpiritUI();
         playerDevilUI = new PlayerDevilUI();
         obf_a_A_1284 = new ReGrowUI();
         countryUI = new CountryUI();
         rideStrengthUI = new obf_0_3_H_64();
         rideEquipRefineUI = new RideEquipRefineUI();
         rideEquipRecreateUI = new obf_5_t_2132();
         rideEquipInheritUI = new obf_s_e_4550();
         rideEquipUI = new obf_A_f_3024();
         starAdventureUI = new StarAdventureUI();
         playerBookUI = new obf_g_b_924();
         devilGodUI = new DevilGodUI();
         devilGodUseMoneyUI = new DevilGodUseMoneyUI();
         devilGodUsePetUI = new DevilGodUsePetUI();
         angelBoxUI = new AngelBoxUI();
         obf_w_0_3587 = new obf_H_F_3333();
         obf_0_8_g_462 = new obf_9_s_996();
         obf_F_e_3603 = new obf_K_x_958();
         obf_t_6_3555 = new obf_F_j_4177();
         obf_0___i_152 = new obf_z_6_2219();
         obf_L_P_3638 = new obf_D_o_4484();
         equipKindGrowUI = new obf_D_r_3256();
         equipKindGrowBlessUI = new EquipKindGrowBlessUI();
         equipKindGrowTemperUI = new obf_0_1_e_423();
         varShopBoxUI = new VarShopBoxUI();
         soulGuardUI = new SoulGuardUI();
         obf_O_S_1448 = new DivineUI();
         pocketSlotUI = new obf_C_5_3793();
         pocketItemUI = new obf_z_4632();
         inOutItemUI = new obf_5_O_3402();
         bloodyWarUI = new obf_5_X_1155();
         obf_t_P_3183 = new obf_M_Z_1297();
         obf_P_I_3025 = new IncubatorUI();
         lockTowerUI = new obf_a_6_3688();
         lockTowerEatUI = new obf_T_7_2588();
         lockTowerFreeUI = new obf_p_J_2393();
         lockTowerInitUI = new obf_U_4_1625();
         lockTowerUpUI = new obf_y_A_3392();
         obf_0___I_542 = new TreasuryUI();
         obf_n_q_2526 = new TreasuryMsgUI1();
         obf_t_h_r_o_w_539 = new TreasuryMsgUI2();
         godStyleUI = new obf_0___K_424();
         treeBoxUI = new obf_n_W_1885();
         magicCircleUI = new obf_0_6_r_163();
         vacantSpaceUI = new obf_o_x_1741();
         vacantSpaceBallUI = new obf_0___J_620();
         itemManualUI = new ItemManualUI();
         passTicketUI = new PassTicketUI();
         passTicketBuyUI = new PassTicketBuyUI();
         obf_0_0_s_385 = new FeedGodUI();
         forgeGodUI = new obf_q_s_2314();
         genieMagicBloodUI = new obf_2_a_2127();
         genieMagicSummonUI = new obf_0_9_N_71();
         genieMagicSkillUI = new obf_N_h_2881();
         genieMagicBoxUI = new GenieMagicBoxUI();
         makeChipBoxUI = new MakeChipBoxUI();
         makeChipUI = new MakeChipUI();
         obf_6_R_3560 = new CopyWorldInfoUI();
         var _loc2_:Array = getAllUI();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ is obf_0_d_4341)
            {
               obf_9_7_2639.initNoviceSprite(_loc3_ as obf_0_d_4341);
            }
         }
         IconItemManager.init(param1);
      }
      
      private static function addListener() : void
      {
         _uiSprite.addEventListener(MouseEvent.CLICK,obf_4_x_1621);
         _uiSprite.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         GameContext.gameStage.addEventListener(Event.RESIZE,onResize);
      }
      
      private static function removeListener() : void
      {
         _uiSprite.removeEventListener(MouseEvent.CLICK,obf_4_x_1621);
         _uiSprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
         GameContext.gameStage.removeEventListener(Event.RESIZE,onResize);
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         if(obf_0_5_x_233.checkTimeout())
         {
            obf_a_X_819();
            obf_p_K_2036 = false;
         }
      }
      
      private static function onResize(param1:Event) : void
      {
         if(!GameContext.currentMap || !GameContext.localPlayer)
         {
            return;
         }
         GameContext.currentMap.setViewPortSize(GameContext.gameStage.stageWidth,GameContext.gameStage.stageHeight);
         GameContext.currentMap.setViewPortCenterToObject(GameContext.localPlayer,true);
      }
      
      private static function obf_4_x_1621(param1:MouseEvent) : void
      {
         var _loc2_:IPlayerUI = getUIModuleUnderPoint(_uiSprite.stage.mouseX,_uiSprite.stage.mouseY);
         if(_loc2_)
         {
            setUITop(_loc2_);
         }
      }
      
      public static function getAllUI() : Array
      {
         return [playerInfoUI,targetInfoUI,obf_N_Y_1566,rideControlUI,shortcutUI,singBarUI,systemInfoUI,systemAlwaysInfoUI,systemScoreUI,obf_e_q_2572,obf_e_H_1407,equipLowDurUI,systemListUI,smallMapUI,mapUI,worldMapUI,obf_a_S_1814,playerBoxUI,playerFullInfoUI,obf_J_K_2135,animalBoxUI,obf_G_K_2049,playerTitleUI,skillBookUI,fateSkillUI,playerBlessUI,blessBoothUI,obf_d_7_1584,playerBagUI,depotBagUI,depotTwoBagUI,depotThreeBagUI,tempBagUI,rideBoxUI,wingBoxUI,petBoxContainerUI,petBoxUI,genieBoxUI,petAssembleBoxUI,petEnhanceUI,petFusionUI,obf_N_i_3901,equipRepairUI,npcShopUI,obf_W_a_1063,obf_w_f_4556,familyBoxUI,familyListUI,familyViewUI,familyPostListUI,familyJoinListUI,familyTaskListUI,familyVarListUI,magicMotionUI,npcTalkBox,playerTaskUI,obf_0___5_510,successUI,obf_G_u_2663,obf_u_p_3828,obf_P_c_3266,systemSettingUI,mailListUI,mailViewUI,mailSendUI,obf_o_J_3931,obf_7_u_1223,assembleBoxUI,assembleListUI,artifactBoxUI,artifactUpgradeUI,artifactFusionUI,equipmentLetteringUI,soulWeaponBoxUI,soulLevelUpUI,soulAssembleUI,soulEmbedUI,teamUI,teamManagerUI,itemRollUI,expBarUI,obf_L_9_3749,systemTipUI,dayBonusUI
         ,onlineBonusUI,offlineBonusUI,daysActPromptUI,activityUI,rankingUI,obf_l_H_2916,tradeUI,tradeCheckUI,boothBfmUI,boothSellUI,boothUI,boothSellViewUI,boothBfmViewUI,boothViewUI,boothItemUI,buffUI,debuffUI,locationTagUI,fashionViewUI,obf_8_r_4095,obf_t_q_3040,obf_5_i_2480,refineBoxUI,obf_4_S_4444,drgTreasureUI,wheelAwardUI,obf_f_a_l_s_e_334,obf_z_1_3064,gmControlBox,newShopBoxUI,obf_r_d_3196,obf_N_5_4623,obf_S_w_2923,obf_1_p_1763,facebookUI,obf_0_3_j_588,obf_Z_G_2885,obf_y_P_4288,constellationUI,stirpBoxUI,obf_s_g_3090,armoryUpgradeUI,armoryComposeUI,bossFeedUI,boneUI,dragonBoxUI,passBoxUI,obf_R_k_2832,towerBoxUI,armyShopUI,rideFusionUI,fruitBoxUI,depictBoxUI,roomBoxUI,glyphBoxUI,manualUI,obf_b_M_1918,consumeRankingUI,taxisBoxUI,favorUI,obf_v_3_1831,druidBoxUI,extractantUI,extractantUpUI,obf_L_G_3097,obf_y_X_2167,obf_R_v_3742,worldUI,obf_g_7_4476,obf_7_S_4368,obf_P_2_4217,monsterNumUI,upgradeUI,obf_8_C_1943,legendUI,equAddSoulUI,devolveUI,cloakBoxUI,petDepotUI,playerAttrChangeUI,rideDepotUI,totemTrialUI,totemOfferUI,totemEvolveUI,totemBoxUI,obf_0___Z_558,obf_T_j_1737,centShopUI,runningMan,fundBgBoxUI,fundUI,localTyrantFundUI,allOfPeopleBoonUI,monthCardUI
         ,wingSpiritUI,playerDevilUI,obf_a_A_1284,countryUI,rideEquipUI,rideStrengthUI,rideEquipRefineUI,rideEquipRecreateUI,rideEquipInheritUI,starAdventureUI,playerBookUI,devilGodUI,devilGodUseMoneyUI,devilGodUsePetUI,angelBoxUI,obf_L_P_3638,obf_w_0_3587,obf_0_8_g_462,obf_F_e_3603,obf_t_6_3555,obf_0___i_152,equipKindGrowUI,equipKindGrowBlessUI,equipKindGrowTemperUI,varShopBoxUI,soulGuardUI,obf_O_S_1448,pocketSlotUI,pocketItemUI,inOutItemUI,bloodyWarUI,obf_t_P_3183,obf_P_I_3025,lockTowerUI,lockTowerEatUI,lockTowerFreeUI,lockTowerInitUI,lockTowerUpUI,obf_0___I_542,obf_n_q_2526,obf_t_h_r_o_w_539,godStyleUI,treeBoxUI,magicCircleUI,vacantSpaceUI,vacantSpaceBallUI,itemManualUI,passTicketUI,passTicketBuyUI,obf_0_0_s_385,forgeGodUI,genieMagicBoxUI,genieMagicBloodUI,genieMagicSummonUI,genieMagicSkillUI,obf_6_R_3560];
      }
      
      public static function destroy() : void
      {
         var allUI:Array;
         var uiObj:Object = null;
         var allChildUI:Array = null;
         var thisChildUI:IPlayerUI = null;
         removeListener();
         allUI = getAllUI();
         for each(uiObj in allUI)
         {
            try
            {
               if(uiObj is obf_0_d_4341)
               {
                  obf_9_7_2639.obf_0___V_239(uiObj as obf_0_d_4341);
               }
               if(uiObj is obf_z_A_3653)
               {
                  allChildUI = (uiObj as obf_z_A_3653).obf_l_v_2495;
                  for each(thisChildUI in allChildUI)
                  {
                     thisChildUI.destroy();
                  }
               }
               uiObj.destroy();
            }
            catch(e:Error)
            {
            }
         }
         while(_uiSprite.numChildren > 0)
         {
            _uiSprite.removeChildAt(0);
         }
         IconItemManager.destroy();
      }
      
      public static function setUIChildIndex(param1:IPlayerUI, param2:int) : void
      {
         var ui:IPlayerUI = param1;
         var index:int = param2;
         if(!_uiSprite || !ui)
         {
            return;
         }
         try
         {
            _uiSprite.setChildIndex(ui as DisplayObject,index);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function showUI(param1:IPlayerUI) : void
      {
         if(!param1)
         {
            return;
         }
         _uiSprite.addChildAt(param1 as DisplayObject,_uiSprite.numChildren - 1);
         param1.showUI();
         if(Boolean(singBarUI) && _uiSprite.contains(singBarUI))
         {
            _uiSprite.setChildIndex(singBarUI,_uiSprite.numChildren - 1);
         }
         _uiSprite.setChildIndex(systemInfoUI,_uiSprite.numChildren - 1);
         if(Boolean(playerAttrChangeUI) && _uiSprite.contains(playerAttrChangeUI))
         {
            _uiSprite.setChildIndex(playerAttrChangeUI,0);
         }
      }
      
      public static function closeUI(param1:IPlayerUI) : void
      {
         if(!param1)
         {
            return;
         }
         param1.closeUI();
         if(_uiSprite.contains(param1 as DisplayObject))
         {
            _uiSprite.removeChild(param1 as DisplayObject);
         }
         if(GameContext.gameFocusManager.getFocus() != obf_e_q_2572.txtInput)
         {
            GameContext.gameStage.focus = _uiSprite;
         }
      }
      
      public static function showChildUI(param1:obf_z_A_3653, param2:IPlayerUI) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.obf_l_v_2495.indexOf(param2) > -1)
         {
            return;
         }
         param1.obf_R_4_1122.addChild(param2 as DisplayObject);
         param1.obf_l_v_2495.push(param2);
         param1.obf_7_h_998(param2);
         param2.showUI();
      }
      
      public static function closeChildUI(param1:obf_z_A_3653, param2:IPlayerUI) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.obf_l_v_2495.indexOf(param2) <= -1)
         {
            return;
         }
         param1.removeChildPlayerUI(param2);
         param2.closeUI();
         if(param1.obf_R_4_1122.contains(param2 as DisplayObject))
         {
            param1.obf_R_4_1122.removeChild(param2 as DisplayObject);
         }
         param1.obf_l_v_2495.splice(param1.obf_l_v_2495.indexOf(param2),1);
      }
      
      public static function closeAllChildUI(param1:obf_z_A_3653) : void
      {
         var _loc2_:IPlayerUI = null;
         for each(_loc2_ in param1.obf_l_v_2495)
         {
            if(_loc2_)
            {
               closeChildUI(param1,_loc2_);
            }
         }
      }
      
      public static function get obf_c_D_2721() : String
      {
         return obf_s_v_3083;
      }
      
      public static function set obf_c_D_2721(param1:String) : void
      {
         obf_s_v_3083 = param1;
         if(obf_s_v_3083 == obf_m_J_4374)
         {
            obf_e_P_918.useCursor(MouseCursor.CURSOR_SELL);
         }
         else if(obf_s_v_3083 == obf_o_7_2612)
         {
            obf_e_P_918.useCursor(MouseCursor.obf_Y_t_2491);
         }
         else if(obf_s_v_3083 == obf_2_N_1475)
         {
            obf_e_P_918.useCursor(MouseCursor.obf_0_n_4352);
         }
         else
         {
            obf_e_P_918.useDefaultCursor();
         }
      }
      
      public static function obf_S_Y_4185() : void
      {
         obf_c_D_2721 = obf_s_v_3083;
      }
      
      public static function addUIMouseToolTip(param1:InteractiveObject, param2:String) : void
      {
         mouseTipMap[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
      }
      
      public static function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function obf_Z_l_1286(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("UIMouseTip");
         _loc2_.addTipInfo(DiversityManager.getString("MouseToolTip",mouseTipMap[param1.currentTarget]),250,0);
         GameTipManager.showTip(_loc2_);
      }
      
      public static function obf_0_6_9_109(param1:Event) : void
      {
         GameTipManager.closeTip("UIMouseTip");
      }
      
      public static function showUITween(param1:DisplayObject, param2:int, param3:int, param4:int, param5:DisplayObjectContainer = null, param6:Number = 1, param7:Number = 1, param8:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         if(!param5)
         {
            param5 = _uiSprite;
         }
         param5.addChild(param1);
         uiTween = TweenLite.to(param1,param2,{
            "x":param3,
            "y":param4,
            "scaleX":param6,
            "scaleY":param7,
            "ease":obf_u_l_3524.easeInOut,
            "onComplete":obf_0_3_y_696,
            "onCompleteParams":[param1,param5,param8]
         });
      }
      
      private static function obf_0_3_y_696(param1:DisplayObject, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         if(param2.contains(param1))
         {
            param2.removeChild(param1);
         }
         if(param3)
         {
            stirpBoxUI.setBlueLv(GameContext.localPlayer.fullInfo.stirpLevel);
         }
      }
      
      public static function showUITweenActs(param1:DisplayObject, param2:Array = null) : void
      {
         if(!param1 || !param2 || param2.length == 0)
         {
            return;
         }
         var _loc3_:Object = param2.shift();
         if(!_loc3_)
         {
            return;
         }
         _loc3_.onComplete = obf_r_o_3493;
         _loc3_.onCompleteParams = [param1,param2];
         _uiSprite.addChild(param1);
         uiTween = TweenLite.to(param1,_loc3_.showTimeSec,_loc3_);
      }
      
      private static function obf_r_o_3493(param1:DisplayObject, param2:Array = null) : void
      {
         if(Boolean(param2) && param2.length > 0)
         {
            showUITweenActs(param1,param2);
            return;
         }
         if(_uiSprite.contains(param1))
         {
            _uiSprite.removeChild(param1);
         }
      }
      
      public static function showBoothBfmWin(param1:String, param2:int, param3:String, param4:int = 1, param5:int = 1, param6:String = "", param7:int = 0) : void
      {
         if(boothBfmWim)
         {
            closeUI(boothBfmWim);
         }
         boothBfmWim = new obf_s_h_3802(param1,param2,param3,param4,param5,param6,param7);
         showUI(boothBfmWim);
      }
      
      public static function obf_L_s_2876() : void
      {
         obf_p_K_2036 = true;
      }
      
      public static function obf_a_X_819() : void
      {
         var _loc2_:Object = null;
         if(Boolean(!GameContext.userConfig) || Boolean(GameContext.userConfig["dnc"]) || !JSONUtil.getBoolean(GameContext.userConfig,["pai","idw"]))
         {
            return;
         }
         obf_9_7_2639.obf_L_L_4010 = !obf_9_7_2639.obf_L_L_4010;
         var _loc1_:Array = getAllUI();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_ is obf_0_d_4341)
            {
               obf_9_7_2639.obf_L_s_2876(_loc2_ as obf_0_d_4341);
            }
         }
      }
      
      public static function obf_0___V_239() : void
      {
         var _loc2_:Object = null;
         var _loc1_:Array = getAllUI();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_ is obf_0_d_4341)
            {
               obf_9_7_2639.obf_0___V_239(_loc2_ as obf_0_d_4341);
            }
         }
      }
      
      public static function obf_T_w_922(param1:Number, param2:Number) : void
      {
         if(playerInfoUI)
         {
            playerInfoUI.hpChange(param1,param2);
         }
         if(playerFullInfoUI)
         {
            playerFullInfoUI.hpChange(param1,param2);
         }
      }
      
      public static function obf_V_z_3564(param1:int, param2:int) : void
      {
         if(playerInfoUI)
         {
            playerInfoUI.mpChange(param1,param2);
         }
         if(playerFullInfoUI)
         {
            playerFullInfoUI.mpChange(param1,param2);
         }
      }
      
      public static function obf_Q_Y_4182(param1:int, param2:int) : void
      {
         if(playerInfoUI)
         {
            playerInfoUI.spChange(param1,param2);
         }
         if(playerFullInfoUI)
         {
            playerFullInfoUI.spChange(param1,param2);
         }
      }
      
      public static function obf_x_e_1087(param1:int) : void
      {
         if(playerFullInfoUI)
         {
            playerFullInfoUI.txtLevel.text = param1 + "";
         }
         if(playerInfoUI)
         {
            playerInfoUI.txtLevel.text = param1 + "";
         }
         if(skillBookUI)
         {
            skillBookUI.refreshSkillPoint();
         }
      }
      
      public static function obf_a_E_3085(param1:uint, param2:uint) : void
      {
         if(playerFullInfoUI)
         {
            playerFullInfoUI.expChange(param1,param2);
         }
         if(expBarUI)
         {
            expBarUI.setExp(param1,param2);
         }
         if(obf_J_K_2135)
         {
            obf_J_K_2135.allExp = param1;
         }
         if(obf_a_A_1284)
         {
            obf_a_A_1284.setExp(param1,param2);
         }
      }
      
      public static function setPKMode(param1:int) : void
      {
         if(playerInfoUI)
         {
            playerInfoUI.setPKMode(param1);
         }
      }
      
      public static function setPlayerAttr(param1:LocalPlayerInfo) : void
      {
         if(playerFullInfoUI)
         {
            playerFullInfoUI.setRoleAttr(param1);
         }
      }
      
      public static function showNpcTalkBox(param1:AINpc) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param1.id,true))
         {
            return;
         }
         closeUI(npcTalkBox);
         GameContext.localPlayer.obf_K_2_1118();
         npcTalkBox = new NpcTalkBoxUI(param1);
         _uiSprite.addChild(npcTalkBox);
      }
      
      public static function refreshTask() : void
      {
         if(playerTaskUI)
         {
            playerTaskUI.refreshTask();
         }
      }
      
      public static function obf_P_r_4199(param1:int, param2:int, param3:int) : void
      {
      }
      
      public static function obf_Y_N_3077(param1:int, param2:int) : void
      {
      }
      
      public static function setFarmInfo(param1:Array) : void
      {
      }
      
      public static function obf_0_7_E_147(param1:String, param2:int, param3:int) : void
      {
      }
      
      public static function obf_j_v_3331(param1:String, param2:int) : void
      {
      }
      
      public static function setTargetInfo(param1:MapInteractiveObject) : void
      {
         if(targetInfoUI)
         {
            showUI(targetInfoUI);
            targetInfoUI.setTargetInfo(param1);
         }
      }
      
      public static function setTargetInfoHpPercent(param1:int) : void
      {
         if(targetInfoUI)
         {
            targetInfoUI.setHpPercent(param1);
         }
      }
      
      public static function showRebirth() : void
      {
         var _loc1_:obf_y_g_4410 = new obf_y_g_4410();
         _loc1_.name = "_RebirthWindow";
         WindowManager.showModalWindow(_loc1_,null,false,true);
      }
      
      public static function closeRebirth() : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("_RebirthWindow") as IWindow);
      }
      
      public static function receiveMsg(param1:String, param2:int, param3:String) : void
      {
         if(obf_e_q_2572)
         {
            obf_e_q_2572.receiveMsg(param1,param2,param3);
         }
      }
      
      public static function showSystemInfo(param1:String) : void
      {
         if(systemInfoUI)
         {
            systemInfoUI.showSystemInfo(param1);
         }
      }
      
      public static function showTipInfo(param1:String) : void
      {
         if(systemInfoUI)
         {
            systemInfoUI.showTipInfo(param1);
         }
      }
      
      public static function obf_n_h_4389() : void
      {
         if(systemInfoUI)
         {
            systemInfoUI.obf_0_4_K_719();
         }
      }
      
      public static function showCenterInfo(param1:String) : void
      {
         showInfoOnUI(param1,null,new Point(GameContext.gameStage.stageWidth / 2,180));
      }
      
      public static function showInfoOnUI(param1:String, param2:DisplayObjectContainer = null, param3:Point = null, param4:Boolean = true) : void
      {
         var _loc6_:obf_0_0_y_425 = null;
         var _loc5_:obf_0_0_y_425 = new obf_0_0_y_425(param1);
         _loc5_.name = "_CenterInfo";
         if(!param2)
         {
            param2 = _uiSprite;
         }
         if(!param3)
         {
            param3 = new Point();
         }
         if(param4)
         {
            _loc6_ = param2.getChildByName("_CenterInfo") as obf_0_0_y_425;
            if(_loc6_)
            {
               _loc6_.destroy();
            }
         }
         _loc5_.x = param3.x;
         _loc5_.y = param3.y;
         param2.addChild(_loc5_);
      }
      
      public static function showShortOfMoney() : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("CommonPrompt","noMoreMoneyConfirmResult"),confirmResultRMB);
      }
      
      private static function confirmResultRMB(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_C_o_3363.openResultUrl();
         }
      }
      
      public static function setSmallMap(param1:String) : void
      {
         if(smallMapUI)
         {
            smallMapUI.showMap(param1);
         }
      }
      
      public static function setMap(param1:String) : void
      {
         if(mapUI)
         {
            mapUI.showMap(param1);
         }
      }
      
      public static function setTeleportMapCD(param1:int) : void
      {
         if(worldMapUI)
         {
            worldMapUI.setTeleportCDTime(param1);
         }
      }
      
      public static function openRemoteView(param1:RemotePlayerViewInfo) : void
      {
         if(obf_G_u_2663)
         {
            obf_G_u_2663.updataRemoteViewUI(param1);
         }
         if(obf_P_c_3266)
         {
            obf_P_c_3266.updataBaseAnimal(param1.animalAtr,param1.attributes.walkSpeed);
         }
         showUI(obf_u_p_3828);
         if(param1.jobCode == obf_I_5_1944.obf_0_1_133)
         {
            obf_u_p_3828.setNoAnimalUI(false);
         }
         else
         {
            obf_u_p_3828.setNoAnimalUI();
         }
      }
      
      public static function showSingBar(param1:Boolean, param2:String, param3:int = 0) : void
      {
         if(singBarUI)
         {
            if(param1)
            {
               singBarUI.singSkill(param3,param2);
            }
            else
            {
               singBarUI.skillDone();
            }
         }
      }
      
      public static function setRideGuestIds(param1:Array) : void
      {
         if(rideControlUI)
         {
            rideControlUI.obf_0_8_3469 = param1;
         }
      }
      
      public static function getSwitchString(param1:String) : String
      {
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc2_:String = param1;
         var _loc3_:RegExp = /%ExpGem,([0-9.]+)%/ig;
         var _loc4_:Object = _loc3_.exec(param1);
         while(_loc4_)
         {
            _loc31_ = NumberConfig.getPlayerLevelExpGemValue(GameContext.localPlayer.fullInfo.level);
            _loc2_ = _loc2_.replace(_loc4_[0],int(_loc31_ * JSONUtil.getNumber(_loc4_,[1])) + "");
            _loc4_ = _loc3_.exec(param1);
         }
         var _loc5_:RegExp = /%GoldGem,([0-9.]+)%/ig;
         var _loc6_:Object = _loc5_.exec(param1);
         while(_loc6_)
         {
            _loc32_ = NumberConfig.getPlayerLevelGoldGemValue(GameContext.localPlayer.fullInfo.level);
            _loc2_ = _loc2_.replace(_loc6_[0],obf_a_f_2935.getGoldString(_loc32_ * JSONUtil.getNumber(_loc6_,[1])));
            _loc6_ = _loc5_.exec(param1);
         }
         var _loc7_:RegExp = /%PlayerName%/ig;
         var _loc8_:Object = _loc7_.exec(param1);
         while(_loc8_)
         {
            _loc2_ = _loc2_.replace(_loc8_[0],GameContext.localPlayer.fullInfo.name);
            _loc8_ = _loc7_.exec(param1);
         }
         var _loc9_:RegExp = /%JobName%/ig;
         var _loc10_:Object = _loc9_.exec(param1);
         while(_loc10_)
         {
            _loc2_ = _loc2_.replace(_loc10_[0],obf_I_5_1944.getJobShowName(GameContext.localPlayer.fullInfo.jobCode));
            _loc10_ = _loc9_.exec(param1);
         }
         var _loc11_:RegExp = /%SysStringVar,([^%]*)%/ig;
         var _loc12_:Object = _loc11_.exec(param1);
         while(_loc12_)
         {
            _loc2_ = _loc2_.replace(_loc12_[0],DynamicVars.systemVar.getStrVar(_loc12_[1]));
            _loc12_ = _loc11_.exec(param1);
         }
         var _loc13_:RegExp = /%SysBooleanVar,([^%]*)%/ig;
         var _loc14_:Object = _loc13_.exec(param1);
         while(_loc14_)
         {
            _loc2_ = _loc2_.replace(_loc14_[0],DynamicVars.systemVar.getBoolVar(_loc14_[1]) + "");
            _loc14_ = _loc13_.exec(param1);
         }
         var _loc15_:RegExp = /%SysIntVar,([^%]*)%/ig;
         var _loc16_:Object = _loc15_.exec(param1);
         while(_loc16_)
         {
            _loc2_ = _loc2_.replace(_loc16_[0],DynamicVars.systemVar.getIntVar(_loc16_[1]) + "");
            _loc16_ = _loc15_.exec(param1);
         }
         var _loc17_:RegExp = /%PlayerStringVar,([^%]*)%/ig;
         var _loc18_:Object = _loc17_.exec(param1);
         while(_loc18_)
         {
            _loc2_ = _loc2_.replace(_loc18_[0],GameContext.localPlayer.dynamicVars.getStrVar(_loc18_[1]));
            _loc18_ = _loc17_.exec(param1);
         }
         var _loc19_:RegExp = /%PlayerBooleanVar,([^%]*)%/ig;
         var _loc20_:Object = _loc19_.exec(param1);
         while(_loc20_)
         {
            _loc2_ = _loc2_.replace(_loc20_[0],GameContext.localPlayer.dynamicVars.getBoolVar(_loc20_[1]) + "");
            _loc20_ = _loc19_.exec(param1);
         }
         var _loc21_:RegExp = /%PlayerIntVar,([^%]*)%/ig;
         var _loc22_:Object = _loc21_.exec(param1);
         while(_loc22_)
         {
            _loc2_ = _loc2_.replace(_loc22_[0],GameContext.localPlayer.dynamicVars.getIntVar(_loc22_[1]) + "");
            _loc22_ = _loc21_.exec(param1);
         }
         var _loc23_:RegExp = /%MapStringVar,([^%]*)%/ig;
         var _loc24_:Object = _loc23_.exec(param1);
         while(_loc24_)
         {
            _loc2_ = _loc2_.replace(_loc24_[0],DynamicVars.mapVar.getStrVar(_loc24_[1]) + "");
            _loc24_ = _loc23_.exec(param1);
         }
         var _loc25_:RegExp = /%MapBooleanVar,([^%]*)%/ig;
         var _loc26_:Object = _loc25_.exec(param1);
         while(_loc26_)
         {
            _loc2_ = _loc2_.replace(_loc26_[0],DynamicVars.mapVar.getBoolVar(_loc26_[1]) + "");
            _loc26_ = _loc25_.exec(param1);
         }
         var _loc27_:RegExp = /%MapIntVar,([^%]*)%/ig;
         var _loc28_:Object = _loc27_.exec(param1);
         while(_loc28_)
         {
            _loc2_ = _loc2_.replace(_loc28_[0],DynamicVars.mapVar.getIntVar(_loc28_[1]) + "");
            _loc28_ = _loc27_.exec(param1);
         }
         var _loc29_:RegExp = /%FamilyIntVar,([^%]*)%/ig;
         var _loc30_:Object = _loc29_.exec(param1);
         while(_loc30_)
         {
            _loc2_ = _loc2_.replace(_loc30_[0],DynamicVars.familyVar.getIntVar(_loc30_[1]) + "");
            _loc30_ = _loc29_.exec(param1);
         }
         return _loc2_;
      }
      
      public static function getUIModuleUnderPoint(param1:int, param2:int) : IPlayerUI
      {
         var _loc4_:IPlayerUI = null;
         var _loc3_:* = int(_uiSprite.numChildren - 1);
         while(_loc3_ >= 0)
         {
            if(_uiSprite.getChildAt(_loc3_) is IPlayerUI)
            {
               _loc4_ = _uiSprite.getChildAt(_loc3_) as IPlayerUI;
               if(_loc4_.mouseOn)
               {
                  return _loc4_;
               }
            }
            _loc3_--;
         }
         return null;
      }
      
      public static function setUITop(param1:IPlayerUI) : void
      {
         if(!param1)
         {
            return;
         }
         _uiSprite.swapChildren(param1 as DisplayObject,_uiSprite.getChildAt(_uiSprite.numChildren - 1));
         if(Boolean(singBarUI) && _uiSprite.contains(singBarUI))
         {
            _uiSprite.setChildIndex(singBarUI,_uiSprite.numChildren - 1);
         }
         _uiSprite.setChildIndex(systemInfoUI,_uiSprite.numChildren - 1);
         if(Boolean(druidBoxUI) && _uiSprite.contains(druidBoxUI))
         {
            _uiSprite.setChildIndex(druidBoxUI,_uiSprite.numChildren - 1);
         }
      }
      
      public static function hitTestXY(param1:DisplayObject, param2:int, param3:int) : Boolean
      {
         if(!param1 || param1.width == 0 && param1.height == 0)
         {
            return false;
         }
         var _loc4_:BitmapData = new BitmapData(1,1,true,0);
         _loc4_.draw(param1,new Matrix(1,0,0,1,-param2,-param3));
         return _loc4_.hitTest(new Point(0,0),51,new Point(0,0));
      }
   }
}

