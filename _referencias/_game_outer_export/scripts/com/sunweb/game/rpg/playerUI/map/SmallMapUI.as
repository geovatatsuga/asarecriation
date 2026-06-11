package com.sunweb.game.rpg.playerUI.map
{
   import obf_b_2_1718.obf_0_8_D_73;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.PlayerMenuItem;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.StatusButton;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_W_s_2093;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import playerUI.SmallMapUIMC;
   
   public class SmallMapUI extends SmallMapUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      private var mapSprite:Sprite = new Sprite();
      
      private var monsterSprite:Sprite = new Sprite();
      
      private var playerSprite:Sprite = new Sprite();
      
      private var animalSprite:Sprite = new Sprite();
      
      private var npcSprite:Sprite = new Sprite();
      
      private var obf_f_A_2243:Bitmap;
      
      private var obf_7_n_2060:uint;
      
      private var _mapId:String;
      
      private var cmdRemoteDisplay:StatusButton;
      
      private var cmdSkillEffectDisplay:StatusButton;
      
      private var appFlash:Loader;
      
      public var serverDate:String;
      
      public var serverTime:String;
      
      private var _noviceSprite:Sprite;
      
      private var onlineBonusTimeLimit:TimeLimiter;
      
      private var obf_0_0_e_560:int;
      
      private var updateTime:TimeLimiter = new TimeLimiter(100);
      
      public function SmallMapUI()
      {
         super();
         this.x = GameContext.gameStage.stageWidth;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         cmdDrgLottery.visible = !WorldConfig.getValue("functionSwitch","lotteryDrg");
         cmdShop.visible = !WorldConfig.getValue("functionSwitch","store");
         cmdDayBonus.visible = !WorldConfig.getValue("functionSwitch","onlineBonus");
         cmdWheelAward.visible = !WorldConfig.getValue("functionSwitch","wheelAward");
         cmdResult.visible = false;
         cmdWiki.visible = false;
         cmdSite.visible = false;
         cmdTower.visible = false;
         cmdBone.visible = false;
         cmdConstellation.visible = false;
         cmdArmory.visible = false;
         cmdBoss.visible = false;
         cmdDragon.visible = false;
         cmdFruit.visible = false;
         cmdPay.visible = false;
         this.obf_7_n_2060 = 2000;
         mapRootPoint.addChild(this.mapSprite);
         mapRootPoint.scrollRect = new Rectangle(0,0,125,130);
         this.mapSprite.addChild(this.monsterSprite);
         this.mapSprite.addChild(this.playerSprite);
         this.mapSprite.addChild(this.animalSprite);
         this.mapSprite.addChild(this.npcSprite);
         this.initStatusButton();
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         obf_9_V_1635.setSimpleButtonTooltip(cmdZoomOut,DiversityManager.getString("SmallMapUI","cmdZoomOut"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdZoomIn,DiversityManager.getString("SmallMapUI","cmdZoomIn"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdMap,DiversityManager.getString("SmallMapUI","cmdMap"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdWorldMap,DiversityManager.getString("SmallMapUI","cmdWorldMap"));
         this.cmdRemoteDisplay.obf_S_F_2079 = DiversityManager.getString("SmallMapUI","cmdRemoteDisplay");
         this.cmdSkillEffectDisplay.obf_S_F_2079 = DiversityManager.getString("SmallMapUI","cmdSkillEffectDisplay");
         obf_9_V_1635.setSimpleButtonTooltip(cmdDrgLottery,DiversityManager.getString("SmallMapUI","cmdDrgLottery"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdWheelAward,DiversityManager.getString("SmallMapUI","cmdWheelAward"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdResult,DiversityManager.getString("SmallMapUI","cmdResult"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSite,DiversityManager.getString("SmallMapUI","cmdSite"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDayBonus,DiversityManager.getString("SmallMapUI","cmdDayBonus"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRanking,DiversityManager.getString("SmallMapUI","cmdRanking"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDaysPrompt,DiversityManager.getString("SmallMapUI","cmdWanfa"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdShop,DiversityManager.getString("SmallMapUI","cmdShop"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdWiki,DiversityManager.getString("SmallMapUI","cmdWiki"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdConstellation,DiversityManager.getString("SmallMapUI","cmdConstellation"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdArmory,DiversityManager.getString("SmallMapUI","cmdArmory"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBoss,DiversityManager.getString("SmallMapUI","cmdBoss"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBone,DiversityManager.getString("SmallMapUI","cmdBone"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdDragon,DiversityManager.getString("SmallMapUI","cmdDragon"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTower,DiversityManager.getString("SmallMapUI","cmdTower"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFruit,DiversityManager.getString("SmallMapUI","cmdFruit"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSystemList,DiversityManager.getString("SmallMapUI","cmdSystemList"));
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "SmallMapUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = JSONUtil.getObject(this,[param1]) as DisplayObject;
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      private function initStatusButton() : void
      {
         this.cmdRemoteDisplay = new StatusButton(_cmdRemoteDisplay,false);
         this.cmdSkillEffectDisplay = new StatusButton(_cmdSkillEffectDisplay,false);
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this.addEventListener(Event.ENTER_FRAME,this.updateSmallMap);
         this.mapSprite.addEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         cmdZoomOut.addEventListener(MouseEvent.CLICK,this.obf_6_g_2354);
         cmdZoomIn.addEventListener(MouseEvent.CLICK,this.obf_g_j_1413);
         txtMapName.addEventListener(MouseEvent.CLICK,this.obf_u_0_4132);
         txtPlayerLocation.addEventListener(MouseEvent.CLICK,this.obf_u_0_4132);
         txtLineNumber.addEventListener(MouseEvent.CLICK,this.obf_0_4_G_395);
         cmdMap.addEventListener(MouseEvent.CLICK,this.obf_E_q_4112);
         cmdWorldMap.addEventListener(MouseEvent.CLICK,this.obf_7_c_1553);
         this.cmdRemoteDisplay.addEventListener(MouseEvent.CLICK,this.obf_0_8_V_287);
         this.cmdSkillEffectDisplay.addEventListener(MouseEvent.CLICK,this.obf_X_y_1031);
         cmdShop.addEventListener(MouseEvent.CLICK,this.obf_W_Q_750);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdSite.addEventListener(MouseEvent.CLICK,this.onClickOfficialSite);
         cmdDaysPrompt.addEventListener(MouseEvent.CLICK,this.obf_e_0_802);
         cmdRanking.addEventListener(MouseEvent.CLICK,this.obf_f_E_2982);
         iconOnlineBonus.addEventListener(MouseEvent.CLICK,this.obf_0_2_G_443);
         cmdDayBonus.addEventListener(MouseEvent.CLICK,this.obf_J_W_4008);
         cmdDrgLottery.addEventListener(MouseEvent.CLICK,this.obf_X_m_4467);
         cmdWheelAward.addEventListener(MouseEvent.CLICK,this.obf_8_z_1349);
         obf_h_r_2123.addEventListener(MouseEvent.MOUSE_OVER,this.onShowServerTime);
         obf_h_r_2123.addEventListener(MouseEvent.MOUSE_OUT,this.onShowServerTime);
         cmdWiki.addEventListener(MouseEvent.CLICK,this.obf_Y_x_4440);
         cmdArmory.addEventListener(MouseEvent.CLICK,this.obf_9_B_3369);
         cmdConstellation.addEventListener(MouseEvent.CLICK,this.obf_0_1_y_206);
         cmdBoss.addEventListener(MouseEvent.CLICK,this.obf_V_m_1051);
         cmdPay.addEventListener(MouseEvent.CLICK,this.obf_h_h_2237);
         cmdBone.addEventListener(MouseEvent.CLICK,this.obf_u_3_1716);
         cmdDragon.addEventListener(MouseEvent.CLICK,this.obf_0_7_B_602);
         cmdTower.addEventListener(MouseEvent.CLICK,this.obf_s_z_4326);
         cmdFruit.addEventListener(MouseEvent.CLICK,this.obf_b_k_2884);
         cmdSystemList.addEventListener(MouseEvent.CLICK,this.onClickSystemList);
         speciallyBtn.addEventListener(MouseEvent.CLICK,this.obf_b_r_2788);
         obf_0_2_d_422.addEventListener(MouseEvent.CLICK,this.obf_A_h_3967);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(Event.ENTER_FRAME,this.updateSmallMap);
         this.mapSprite.removeEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         cmdZoomOut.removeEventListener(MouseEvent.CLICK,this.obf_6_g_2354);
         cmdZoomIn.removeEventListener(MouseEvent.CLICK,this.obf_g_j_1413);
         txtMapName.removeEventListener(MouseEvent.CLICK,this.obf_u_0_4132);
         txtPlayerLocation.removeEventListener(MouseEvent.CLICK,this.obf_u_0_4132);
         txtLineNumber.removeEventListener(MouseEvent.CLICK,this.obf_0_4_G_395);
         cmdMap.removeEventListener(MouseEvent.CLICK,this.obf_E_q_4112);
         cmdWorldMap.removeEventListener(MouseEvent.CLICK,this.obf_7_c_1553);
         this.cmdRemoteDisplay.removeEventListener(MouseEvent.CLICK,this.obf_0_8_V_287);
         this.cmdSkillEffectDisplay.removeEventListener(MouseEvent.CLICK,this.obf_X_y_1031);
         cmdShop.removeEventListener(MouseEvent.CLICK,this.obf_W_Q_750);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdSite.removeEventListener(MouseEvent.CLICK,this.onClickOfficialSite);
         cmdDaysPrompt.removeEventListener(MouseEvent.CLICK,this.obf_e_0_802);
         cmdRanking.removeEventListener(MouseEvent.CLICK,this.obf_f_E_2982);
         iconOnlineBonus.removeEventListener(MouseEvent.CLICK,this.obf_0_2_G_443);
         cmdDayBonus.removeEventListener(MouseEvent.CLICK,this.obf_J_W_4008);
         cmdDrgLottery.removeEventListener(MouseEvent.CLICK,this.obf_X_m_4467);
         cmdWheelAward.removeEventListener(MouseEvent.CLICK,this.obf_8_z_1349);
         obf_h_r_2123.removeEventListener(MouseEvent.MOUSE_OVER,this.onShowServerTime);
         obf_h_r_2123.removeEventListener(MouseEvent.MOUSE_OUT,this.onShowServerTime);
         cmdWiki.removeEventListener(MouseEvent.CLICK,this.obf_Y_x_4440);
         cmdArmory.removeEventListener(MouseEvent.CLICK,this.obf_9_B_3369);
         cmdConstellation.removeEventListener(MouseEvent.CLICK,this.obf_0_1_y_206);
         cmdBoss.removeEventListener(MouseEvent.CLICK,this.obf_V_m_1051);
         cmdPay.removeEventListener(MouseEvent.CLICK,this.obf_h_h_2237);
         cmdBone.removeEventListener(MouseEvent.CLICK,this.obf_u_3_1716);
         cmdDragon.removeEventListener(MouseEvent.CLICK,this.obf_0_7_B_602);
         cmdTower.removeEventListener(MouseEvent.CLICK,this.obf_s_z_4326);
         cmdFruit.removeEventListener(MouseEvent.CLICK,this.obf_b_k_2884);
         cmdSystemList.removeEventListener(MouseEvent.CLICK,this.onClickSystemList);
         speciallyBtn.removeEventListener(MouseEvent.CLICK,this.obf_b_r_2788);
         obf_0_2_d_422.removeEventListener(MouseEvent.CLICK,this.obf_A_h_3967);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth;
      }
      
      private function onClickOfficialSite(param1:Event) : void
      {
         var _loc2_:String = obf_r_8_1121.getParameter(["ost"]);
         if(!obf_L_l_4100.isEmpty(_loc2_))
         {
            navigateToURL(new URLRequest(_loc2_));
         }
         else
         {
            obf_C_o_3363.openActionURL("OfficialSite");
         }
      }
      
      private function onClickOfficialBBS(param1:Event) : void
      {
         obf_C_o_3363.openActionURL("OfficialBBS");
      }
      
      private function onClickResult(param1:Event) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      private function obf_e_0_802(param1:Event) : void
      {
         if(!obf_K_e_3075.activityUI)
         {
            return;
         }
         if(obf_K_e_3075.activityUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.activityUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.activityUI);
         }
      }
      
      private function obf_Q_u_1916(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.locationTagUI);
      }
      
      private function obf_f_E_2982(param1:Event) : void
      {
         if(!obf_K_e_3075.rankingUI)
         {
            return;
         }
         if(obf_K_e_3075.rankingUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.rankingUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.rankingUI);
         }
      }
      
      private function onShowServerTime(param1:Event) : void
      {
         var _loc2_:GameTipUI = null;
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            _loc2_ = new GameTipUI("ServerTime");
            _loc2_.addTipInfo(DiversityManager.getString("SmallMapUI","serverClock",[this.serverDate,this.serverTime]),200,0);
            GameTipManager.showTip(_loc2_);
         }
         else if(param1.type == MouseEvent.MOUSE_OUT)
         {
            GameTipManager.closeTip("ServerTime");
         }
      }
      
      public function setServerTime(param1:String, param2:String) : void
      {
         this.serverDate = param1;
         this.serverTime = param2;
      }
      
      private function obf_Y_x_4440(param1:Event) : void
      {
         obf_C_o_3363.openActionURL("wiki");
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
      }
      
      private function obf_h_h_2237(param1:Event) : void
      {
         obf_C_o_3363.openActionURL("FaceBookPay");
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
      }
      
      private function onClickSystemList(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.systemListUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.systemListUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.systemListUI);
         }
      }
      
      private function obf_b_r_2788(param1:MouseEvent) : void
      {
         var _loc2_:Object = activityBoxManager.getSpeciallyItemConfig();
         if(!obf_K_e_3075.obf_b_M_1918.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_b_M_1918);
         }
      }
      
      private function obf_A_h_3967(param1:MouseEvent) : void
      {
         var _loc2_:Object = activityBoxManager.getSpecially214();
         if(!obf_J_F_3431.obf_4_4696(_loc2_.activityCode))
         {
            WindowManager.showMessageBox(DiversityManager.getString("taxisBoxUI","noOpen"));
            return;
         }
         if(!obf_K_e_3075.taxisBoxUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.taxisBoxUI);
         }
      }
      
      public function showOnlineBonus(param1:int) : void
      {
         iconOnlineBonus.gotoAndStop(2);
         iconOnlineBonus.visible = true;
         this.onlineBonusTimeLimit = new TimeLimiter(param1 * 1000);
      }
      
      public function disableOnlineBonus() : void
      {
         iconOnlineBonus.gotoAndStop(1);
         iconOnlineBonus.txtTime.text = "";
         iconOnlineBonus.visible = false;
         this.onlineBonusTimeLimit = null;
      }
      
      private function obf_q_C_4496() : void
      {
         if(!this.onlineBonusTimeLimit)
         {
            return;
         }
         if(this.onlineBonusTimeLimit.totalTimeInMS < this.onlineBonusTimeLimit.timelimit)
         {
            iconOnlineBonus.txtTime.text = obf_l_y_733.getTimeStringHHMMSS(this.onlineBonusTimeLimit.timelimit - this.onlineBonusTimeLimit.totalTimeInMS);
         }
         else if(iconOnlineBonus.currentFrame != 3)
         {
            DiversityManager.setTextField(iconOnlineBonus.txtTime,"OnlineBonusUI","canGetBonus",null,true);
            iconOnlineBonus.gotoAndStop(3);
         }
      }
      
      private function obf_0_2_G_443(param1:Event) : void
      {
         if(!this.onlineBonusTimeLimit || this.onlineBonusTimeLimit.totalTimeInMS < this.onlineBonusTimeLimit.timelimit)
         {
            return;
         }
         obf_v_1_1352.obf_M_S_2137();
      }
      
      private function obf_J_W_4008(param1:Event) : void
      {
         if(WorldConfig.getValue("functionSwitch","showNewLoginReward"))
         {
            if(!obf_K_e_3075.obf_r_d_3196)
            {
               return;
            }
            if(obf_K_e_3075.obf_r_d_3196.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.obf_r_d_3196);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.obf_r_d_3196);
            }
         }
         else
         {
            if(!obf_K_e_3075.dayBonusUI)
            {
               return;
            }
            if(obf_K_e_3075.dayBonusUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.dayBonusUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.dayBonusUI);
            }
         }
      }
      
      private function obf_X_m_4467(param1:Event) : void
      {
         if(!obf_K_e_3075.drgTreasureUI)
         {
            return;
         }
         if(obf_K_e_3075.drgTreasureUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.drgTreasureUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.drgTreasureUI);
         }
      }
      
      private function obf_8_z_1349(param1:Event) : void
      {
         if(!obf_K_e_3075.wheelAwardUI)
         {
            return;
         }
         if(obf_K_e_3075.wheelAwardUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.wheelAwardUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.wheelAwardUI);
         }
      }
      
      private function obf_E_q_4112(param1:Event) : void
      {
         if(!obf_K_e_3075.mapUI)
         {
            return;
         }
         if(obf_K_e_3075.mapUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.mapUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.mapUI);
         }
      }
      
      private function obf_7_c_1553(param1:Event) : void
      {
         if(!obf_K_e_3075.worldMapUI)
         {
            return;
         }
         if(obf_K_e_3075.worldMapUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.worldMapUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.worldMapUI);
         }
      }
      
      private function obf_6_g_2354(param1:Event) : void
      {
         this.obf_7_n_2060 -= 1000;
         if(this.obf_7_n_2060 < 1000)
         {
            this.obf_7_n_2060 = 1000;
         }
      }
      
      private function obf_g_j_1413(param1:Event) : void
      {
         this.obf_7_n_2060 += 1000;
         if(this.obf_7_n_2060 > 3000)
         {
            this.obf_7_n_2060 = 3000;
         }
      }
      
      private function obf_s_c_4323(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_f_a_l_s_e_334);
      }
      
      private function obf_w_v_1681(param1:Event) : void
      {
         obf_C_o_3363.openActionURL("HelpPage");
      }
      
      private function obf_0_8_V_287(param1:Event) : void
      {
         this.setRemoteDisplay();
      }
      
      public function obf_X_y_1031(param1:Event) : void
      {
         obf_W_s_2093.showSkillEffect = !obf_W_s_2093.showSkillEffect;
         this.cmdSkillEffectDisplay.obf_f_C_851 = obf_W_s_2093.showSkillEffect ? uint(StatusButton.obf_F_z_2485) : uint(StatusButton.STATUS_1);
      }
      
      private function obf_W_Q_750(param1:Event) : void
      {
         if(WorldConfig.getValue("functionSwitch","store") == true)
         {
            return;
         }
         if(WorldConfig.getValue("functionSwitch","showNewShop"))
         {
            if(!obf_K_e_3075.newShopBoxUI)
            {
               return;
            }
            if(obf_K_e_3075.newShopBoxUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.newShopBoxUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.newShopBoxUI);
            }
         }
         else
         {
            if(!obf_K_e_3075.obf_N_i_3901)
            {
               return;
            }
            if(obf_K_e_3075.obf_N_i_3901.visible)
            {
               obf_F_2_2975.obf_O_p_3236("closeui ShopUI");
            }
            else
            {
               obf_F_2_2975.obf_O_p_3236("showui ShopUI");
            }
         }
      }
      
      private function obf_m_b_1464(param1:Event) : void
      {
         if(obf_K_e_3075.systemSettingUI)
         {
            if(obf_K_e_3075.systemSettingUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.systemSettingUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.systemSettingUI);
            }
         }
      }
      
      private function onClickMonsterMaps(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc5_:PlayerMenuItem = null;
         var _loc2_:Array = WorldConfig.getObjectSetting("monsterMaps") as Array;
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("monsterMaps");
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = new PlayerMenuItem(WorldMapManager.getMapName(_loc4_.mapCode) + _loc4_.mapPrompt,obf_K_e_3075.worldMapUI.teleportToMap,[_loc4_.mapCode]);
            _loc3_.addMenuItem(_loc5_,_loc4_.mapCode);
         }
         PlayerMenuUI.showMenu(_loc3_,GameContext.gameStage.mouseX - _loc3_.width,GameContext.gameStage.mouseY);
      }
      
      public function setRemoteDisplay() : void
      {
         if(Map.obf_0_2_l_577 == 0)
         {
            Map.obf_0_2_l_577 = JSONUtil.getInt(GameContext.userConfig,["sst","mpn"],10);
            this.cmdRemoteDisplay.obf_f_C_851 = StatusButton.obf_F_z_2485;
            this.obf_0_0_e_560 = StatusButton.obf_F_z_2485;
         }
         else
         {
            Map.obf_0_2_l_577 = 0;
            this.cmdRemoteDisplay.obf_f_C_851 = StatusButton.STATUS_1;
            this.obf_0_0_e_560 = StatusButton.STATUS_1;
         }
         if(GameContext.currentMap)
         {
            GameContext.currentMap.limitRemotePlayerNumber(Map.obf_0_2_l_577);
         }
         obf_K_e_3075.systemSettingUI.showEffectCommand();
      }
      
      public function get getStatus() : int
      {
         return this.obf_0_0_e_560;
      }
      
      private function obf_k_w_2692(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(Boolean(this.obf_f_A_2243) && Boolean(GameContext.localPlayer) && Boolean(GameContext.currentMap))
         {
            _loc2_ = this.mapSprite.mouseX / this.obf_f_A_2243.width;
            _loc3_ = this.mapSprite.mouseY / this.obf_f_A_2243.height;
            _loc4_ = _loc2_ * (GameContext.currentMap.mapWidth * Map.obf_7_7_3297);
            _loc5_ = _loc3_ * (GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL);
            GameContext.localPlayer.obf_I_V_3724(_loc4_,_loc5_);
         }
      }
      
      public function setSpecially() : void
      {
         var _loc1_:Object = activityBoxManager.getSpeciallyItemConfig();
         if(obf_J_F_3431.obf_4_4696(_loc1_.activityCode))
         {
            speciallyBtn.visible = true;
         }
         else
         {
            speciallyBtn.visible = false;
         }
         var _loc2_:Object = activityBoxManager.getSpecially214();
         if(obf_J_F_3431.obf_4_4696(_loc2_.activityCode))
         {
            obf_0_2_d_422.visible = true;
         }
         else
         {
            obf_0_2_d_422.visible = false;
         }
      }
      
      public function showMap(param1:String) : void
      {
         if(!param1 || param1 == "")
         {
            return;
         }
         this._mapId = param1;
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
         }
         this.obf_f_A_2243 = WorldMapManager.getSmallMap(param1);
         this.mapSprite.addChildAt(this.obf_f_A_2243,0);
         var _loc2_:Object = WorldMapManager.getMapConfig(param1);
         DiversityManager.setTextField(txtLineNumber,"SmallMapUI","txtMultiline",[1],true);
         if(JSONUtil.getBoolean(_loc2_,["isMultiline"]))
         {
            DiversityManager.setTextField(txtLineNumber,"SmallMapUI","txtMultiline",[GameContext.localPlayer.fullInfo.lineIndex + 1],true);
         }
         if(Boolean(GameContext.currentMap) && GameContext.currentMap.mapId == this._mapId)
         {
            if(GameContext.currentMap.enablePK)
            {
               txtMapName.textColor = 16711680;
            }
            else
            {
               txtMapName.textColor = 65280;
            }
         }
         else
         {
            txtMapName.textColor = 16777215;
         }
      }
      
      public function setMap(param1:Bitmap) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
         }
         this.obf_f_A_2243 = param1;
         this.mapSprite.addChildAt(this.obf_f_A_2243,0);
      }
      
      public function setViewSize(param1:uint) : void
      {
         this.obf_7_n_2060 = param1;
      }
      
      private function obf_u_0_4132(param1:MouseEvent) : void
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_e_q_2572)
         {
            return;
         }
         obf_K_e_3075.obf_e_q_2572.addMapPointLink(GameContext.currentMap.mapName + "(" + txtPlayerLocation.text + ")",GameContext.currentMap.mapId,GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY);
      }
      
      private function obf_0_4_G_395(param1:Event) : void
      {
         var _loc3_:PlayerMenuUI = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Object = WorldMapManager.getMapConfig(this._mapId);
         if(!_loc2_)
         {
            return;
         }
         if(JSONUtil.getBoolean(_loc2_,["isMultiline"]) && JSONUtil.getBoolean(_loc2_,["allowSelectLine"]))
         {
            _loc3_ = new PlayerMenuUI("SelectMapLine",180);
            _loc4_ = JSONUtil.getInt(_loc2_,["lineNumber"]);
            _loc5_ = 1;
            while(_loc5_ <= _loc4_)
            {
               if(_loc5_ - 1 != GameContext.localPlayer.fullInfo.lineIndex)
               {
                  _loc3_.addMenuItem(new PlayerMenuItem(DiversityManager.getString("SmallMapUI","menuSelectLine",[_loc5_]),GameContext.localPlayer.sendSelectMapLine,[_loc5_ - 1]),"SelectLine" + _loc5_);
               }
               _loc5_++;
            }
            _loc3_.addMenuItem(new PlayerMenuItem(DiversityManager.getString("MenuUI","cancelMenu"),PlayerMenuUI.closeMenuById,["SelectMapLine"]),"cancleMenu");
            PlayerMenuUI.showMenu(_loc3_,GameContext.gameStage.mouseX,GameContext.gameStage.mouseY);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("SmallMapUI","prompt_CantSelectLine"));
         }
      }
      
      private function updateSmallMap(param1:Event) : void
      {
         var _loc11_:Object = null;
         var _loc12_:TeamMemberInfo = null;
         var _loc13_:RemotePlayer = null;
         if(!this.updateTime.checkTimeout())
         {
            return;
         }
         this.obf_q_C_4496();
         if(!this.obf_f_A_2243 || !GameContext.localPlayer || !GameContext.currentMap)
         {
            return;
         }
         txtMapName.text = GameContext.currentMap.mapName;
         txtPlayerLocation.text = "X:" + GameContext.localPlayer.rootX + " Y:" + int(GameContext.localPlayer.rootY / 2);
         var _loc2_:Number = GameContext.currentMap.mapWidth * Map.obf_7_7_3297 / this.obf_f_A_2243.bitmapData.width / (this.obf_7_n_2060 / mapRootPoint.scrollRect.width);
         var _loc3_:Number = GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL / this.obf_f_A_2243.bitmapData.height / (this.obf_7_n_2060 / mapRootPoint.scrollRect.height);
         if(this.obf_f_A_2243.scaleX != _loc2_)
         {
            this.obf_f_A_2243.scaleX = _loc2_;
         }
         if(this.obf_f_A_2243.scaleY != _loc3_)
         {
            this.obf_f_A_2243.scaleY = _loc3_;
         }
         var _loc4_:Number = GameContext.localPlayer.rootPX / (GameContext.currentMap.mapWidth * Map.obf_7_7_3297);
         var _loc5_:Number = GameContext.localPlayer.rootPY / (GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL);
         var _loc6_:Rectangle = new Rectangle(0,0,this.obf_f_A_2243.width - mapRootPoint.scrollRect.width,this.obf_f_A_2243.height - mapRootPoint.scrollRect.height);
         var _loc7_:Point = new Point(this.obf_f_A_2243.width * _loc4_ - mapRootPoint.scrollRect.width / 2,this.obf_f_A_2243.height * _loc5_ - mapRootPoint.scrollRect.height / 2);
         this.mapSprite.x = -Math.min(Math.max(_loc7_.x,0),_loc6_.width);
         this.mapSprite.y = -Math.min(Math.max(_loc7_.y,0),_loc6_.height);
         var _loc8_:Point = new Point();
         if(_loc7_.x < 0)
         {
            _loc8_.x = _loc7_.x;
         }
         if(_loc7_.x > _loc6_.width)
         {
            _loc8_.x = _loc7_.x - _loc6_.width;
         }
         if(_loc7_.y < 0)
         {
            _loc8_.y = _loc7_.y;
         }
         if(_loc7_.y > _loc6_.height)
         {
            _loc8_.y = _loc7_.y - _loc6_.height;
         }
         playerCenter.x = mapRootPoint.x + mapRootPoint.scrollRect.width / 2 + _loc8_.x;
         playerCenter.y = mapRootPoint.y + mapRootPoint.scrollRect.height / 2 + _loc8_.y;
         var _loc9_:int = GameContext.currentMap.mapWidth * Map.obf_7_7_3297;
         var _loc10_:int = GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL;
         WorldMapManager.drawMapObjectPoint(_loc9_,_loc10_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.monsterSprite,GameContext.currentMap.monsterSet.obf_3_C_4291,16711680,16711680);
         WorldMapManager.drawMapObjectPoint(_loc9_,_loc10_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.animalSprite,GameContext.currentMap.animalSet.obf_3_C_4291,11802581,11802581);
         WorldMapManager.drawMapObjectPoint(_loc9_,_loc10_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.playerSprite,GameContext.currentMap.remotePlayerSet.obf_3_C_4291,255,255);
         if(TeamManager.teamName != "")
         {
            _loc11_ = new Object();
            for each(_loc12_ in TeamManager.teamMembers)
            {
               if(_loc12_.name != GameContext.localPlayer.id)
               {
                  _loc13_ = GameContext.currentMap.remotePlayerSet.getObject(_loc12_.name) as RemotePlayer;
                  if(_loc13_)
                  {
                     _loc11_[_loc13_.id] = _loc13_;
                  }
               }
            }
            WorldMapManager.drawMapObjectPoint(_loc9_,_loc10_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.playerSprite,_loc11_,65280,16776960,1,3,false);
         }
         WorldMapManager.drawMapObjectPoint(_loc9_,_loc10_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.playerSprite,GameContext.currentMap.npcSet.obf_3_C_4291,6711039,255,1,3,false);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return obf_K_e_3075.hitTestXY(this,this.mouseX,this.mouseY);
         }
         return false;
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
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
         }
      }
   }
}

