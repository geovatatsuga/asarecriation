package com.sunweb.game.rpg.playerUI.playerInfo
{
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.pet.obf_V_e_1630;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.PKMode;
   import com.sunweb.game.rpg.role.obf_0_5_V_226;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import playerUI.PlayerInfoUIMC;
   
   public class PlayerInfoUI extends PlayerInfoUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      public var obf_f_k_1032:TimeLimiter;
      
      public var obf_x_q_3716:TimeLimiter;
      
      public var obf_0___C_332:TimeLimiter;
      
      public var obf_G_g_1104:TimeLimiter;
      
      private var _noviceSprite:Sprite;
      
      private var ms:int = 0;
      
      private var obf_a_e_1735:int = 0;
      
      private var frameTimeInv:TimeLimiter = new TimeLimiter(200);
      
      private var showPetId:String;
      
      public function PlayerInfoUI()
      {
         super();
         this.initDiversity();
         cmdFateSkill.visible = !WorldConfig.getValue("functionSwitch","fateSkill");
         hpBar.gotoAndStop(100);
         mpBar.gotoAndStop(100);
         barBKHP.gotoAndStop(1);
         barBKMP.gotoAndStop(1);
         bkHpMask.gotoAndStop(1);
         bkMpMask.gotoAndStop(1);
         barPetBKHP.gotoAndStop(1);
         barPetBKMP.gotoAndStop(1);
         bkPetHpMask.gotoAndStop(1);
         bkPetMpMask.gotoAndStop(1);
         fpsIcon.stop();
         pingIcon.stop();
         bkHpMask.mouseEnabled = false;
         bkMpMask.mouseEnabled = false;
         barBKHP.mouseEnabled = false;
         barBKMP.mouseEnabled = false;
         bkPetHpMask.mouseEnabled = false;
         bkPetMpMask.mouseEnabled = false;
         barPetBKHP.mouseEnabled = false;
         barPetBKMP.mouseEnabled = false;
         fpsIcon.txtFps.mouseEnabled = false;
         pingIcon.txtPing.mouseEnabled = false;
         fpsIcon.txtFps.visible = false;
         pingIcon.txtPing.visible = false;
         teamLeaderIcon.visible = false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtPetAction.mouseEnabled = false;
         obf_9_V_1635.setSimpleButtonTooltip(cmdFateSkill,DiversityManager.getString("PlayerInfoUI","cmdFateSkill"));
      }
      
      public function init(param1:obf_U_6_3454) : void
      {
         txtName.text = param1.id;
         txtLevel.text = param1.fullInfo.level + "";
         this.headIconChange(param1.fullInfo.headIconIndex);
         var _loc2_:Number = param1.fullInfo.attributes.hp;
         var _loc3_:Number = param1.fullInfo.attributes.hpMax;
         var _loc4_:int = param1.fullInfo.attributes.mp;
         var _loc5_:int = param1.fullInfo.attributes.mpMax;
         var _loc6_:int = param1.fullInfo.attributes.sp;
         var _loc7_:int = param1.fullInfo.attributes.spMax;
         this.hpChange(_loc2_,_loc3_);
         this.mpChange(_loc4_,_loc5_);
         this.spChange(_loc6_,_loc7_);
         this.obf_l_1_3544(param1.fullInfo.bkHp,param1.fullInfo.bkHpMax);
         this.obf_t_s_1612(param1.fullInfo.bkMp,param1.fullInfo.bkMpMax);
         this.obf_h_6_1233(param1.fullInfo.petBkHp,param1.fullInfo.petBkHpMax);
         this.obf_J_R_3179(param1.fullInfo.petBkMp,param1.fullInfo.petBkMpMax);
         this.setCombat(false);
         this.addListener();
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
         return "PlayerInfoUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this.getChildByName(param1);
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this.getChildByName(param1);
      }
      
      private function addListener() : void
      {
         headIconPoint.addEventListener(MouseEvent.CLICK,this.obf_d_f_783);
         pointPetIcon.addEventListener(MouseEvent.CLICK,this.obf_0_7_2_90);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         txtPK.addEventListener(MouseEvent.CLICK,this.showPKModeMenu);
         fpsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.obf_B_Y_4590);
         fpsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.obf_b_j_4005);
         pingIcon.addEventListener(MouseEvent.MOUSE_OVER,this.obf_K_9_3413);
         pingIcon.addEventListener(MouseEvent.MOUSE_OUT,this.obf_A_k_2980);
         hpBKBG.addEventListener(MouseEvent.MOUSE_OVER,this.obf_r_s_3682);
         hpBKBG.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         mpBKBG.addEventListener(MouseEvent.MOUSE_OVER,this.obf_g_p_2012);
         mpBKBG.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         petHpBKBG.addEventListener(MouseEvent.MOUSE_OVER,this.obf_w_Y_2894);
         petHpBKBG.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         petMpBKBG.addEventListener(MouseEvent.MOUSE_OVER,this.obf_X_2_2311);
         petMpBKBG.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         cmdFateSkill.addEventListener(MouseEvent.CLICK,this.obf_9_d_4621);
         cmdPetAction.addEventListener(MouseEvent.CLICK,this.obf_I_l_3741);
      }
      
      private function removeListener() : void
      {
         headIconPoint.removeEventListener(MouseEvent.CLICK,this.obf_d_f_783);
         pointPetIcon.removeEventListener(MouseEvent.CLICK,this.obf_0_7_2_90);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         txtPK.removeEventListener(MouseEvent.CLICK,this.showPKModeMenu);
         fpsIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_B_Y_4590);
         fpsIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_b_j_4005);
         pingIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_K_9_3413);
         pingIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_A_k_2980);
         hpBKBG.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_r_s_3682);
         hpBKBG.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         mpBKBG.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_g_p_2012);
         mpBKBG.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         petHpBKBG.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_w_Y_2894);
         petHpBKBG.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         petMpBKBG.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_X_2_2311);
         petMpBKBG.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_1_9_575);
         cmdFateSkill.removeEventListener(MouseEvent.CLICK,this.obf_9_d_4621);
         cmdPetAction.removeEventListener(MouseEvent.CLICK,this.obf_I_l_3741);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(getTimer() - 1000 > this.ms)
         {
            this.ms = getTimer();
            fpsIcon.txtFps.text = "Fps:" + this.obf_a_e_1735;
            if(this.obf_a_e_1735 <= 15)
            {
               fpsIcon.gotoAndStop("slow");
            }
            else if(this.obf_a_e_1735 <= 25)
            {
               fpsIcon.gotoAndStop("medium");
            }
            else
            {
               fpsIcon.gotoAndStop("fast");
            }
            this.obf_a_e_1735 = 0;
         }
         else
         {
            ++this.obf_a_e_1735;
         }
         if(!this.frameTimeInv.checkTimeout())
         {
            return;
         }
         if(this.obf_f_k_1032)
         {
            _loc2_ = (this.obf_f_k_1032.timelimit - this.obf_f_k_1032.totalTimeInMS) / this.obf_f_k_1032.timelimit * 100;
            bkHpMask.gotoAndStop(_loc2_);
            if(this.obf_f_k_1032.checkTimeout())
            {
               this.obf_f_k_1032 = null;
            }
         }
         if(this.obf_x_q_3716)
         {
            _loc3_ = (this.obf_x_q_3716.timelimit - this.obf_x_q_3716.totalTimeInMS) / this.obf_x_q_3716.timelimit * 100;
            bkMpMask.gotoAndStop(_loc3_);
            if(this.obf_x_q_3716.checkTimeout())
            {
               this.obf_x_q_3716 = null;
            }
         }
         if(this.obf_0___C_332)
         {
            _loc4_ = (this.obf_0___C_332.timelimit - this.obf_0___C_332.totalTimeInMS) / this.obf_0___C_332.timelimit * 100;
            bkPetHpMask.gotoAndStop(_loc4_);
            if(this.obf_0___C_332.checkTimeout())
            {
               this.obf_0___C_332 = null;
            }
         }
         if(this.obf_G_g_1104)
         {
            _loc5_ = (this.obf_G_g_1104.timelimit - this.obf_G_g_1104.totalTimeInMS) / this.obf_G_g_1104.timelimit * 100;
            bkPetMpMask.gotoAndStop(_loc5_);
            if(this.obf_G_g_1104.checkTimeout())
            {
               this.obf_G_g_1104 = null;
            }
         }
      }
      
      private function obf_B_Y_4590(param1:Event) : void
      {
         fpsIcon.txtFps.visible = true;
      }
      
      private function obf_b_j_4005(param1:Event) : void
      {
         fpsIcon.txtFps.visible = false;
      }
      
      private function obf_K_9_3413(param1:Event) : void
      {
         pingIcon.txtPing.visible = true;
      }
      
      private function obf_A_k_2980(param1:Event) : void
      {
         pingIcon.txtPing.visible = false;
      }
      
      private function obf_r_s_3682(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("PlayerBK");
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerInfoUI","hpPercent",[obf_A_x_3023.getRateString(WorldConfig.getValue("bkHpMp","hpRateToUse"))]) + "</font></p>",150,0);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerInfoUI","txtBkHP") + GameContext.localPlayer.fullInfo.bkHp + "</font></p>",150,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerSkillPrompt","skillCDTime") + obf_l_y_733.getTimeStringSec(WorldConfig.getValue("bkHpMp","cdTimeInMS")) + "</font></p>",150,_loc2_.maxRow + 1);
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disableBkHpMp"]))
         {
            _loc2_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("PlayerInfoUI","bkDisabled") + "</P>",150,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_g_p_2012(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("PlayerBK");
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerInfoUI","mpPercent",[obf_A_x_3023.getRateString(WorldConfig.getValue("bkHpMp","mpRateToUse"))]) + "</font></p>",150,0);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerInfoUI","txtBkMP") + GameContext.localPlayer.fullInfo.bkMp + "</font></p>",150,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerSkillPrompt","skillCDTime") + obf_l_y_733.getTimeStringSec(WorldConfig.getValue("bkHpMp","cdTimeInMS")) + "</font></p>",150,_loc2_.maxRow + 1);
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disableBkHpMp"]))
         {
            _loc2_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("PlayerInfoUI","bkDisabled") + "</P>",150,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_w_Y_2894(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("PlayerBK");
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerInfoUI","hpPercent",[obf_A_x_3023.getRateString(WorldConfig.getValue("petBkHpMp","hpRateToUse"))]) + "</font></p>",150,0);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerInfoUI","txtBkHP") + GameContext.localPlayer.fullInfo.petBkHp + "</font></p>",150,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#FF6666\'>" + DiversityManager.getString("PlayerSkillPrompt","skillCDTime") + obf_l_y_733.getTimeStringSec(WorldConfig.getValue("petBkHpMp","cdTimeInMS")) + "</font></p>",150,_loc2_.maxRow + 1);
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disableBkHpMp"]))
         {
            _loc2_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("PlayerInfoUI","bkDisabled") + "</P>",150,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_X_2_2311(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("PlayerBK");
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerInfoUI","mpPercent",[obf_A_x_3023.getRateString(WorldConfig.getValue("petBkHpMp","mpRateToUse"))]) + "</font></p>",150,0);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerInfoUI","txtBkMP") + GameContext.localPlayer.fullInfo.petBkMp + "</font></p>",150,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<p align=\'center\'><font color=\'#0098FF\'>" + DiversityManager.getString("PlayerSkillPrompt","skillCDTime") + obf_l_y_733.getTimeStringSec(WorldConfig.getValue("petBkHpMp","cdTimeInMS")) + "</font></p>",150,_loc2_.maxRow + 1);
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disableBkHpMp"]))
         {
            _loc2_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("PlayerInfoUI","bkDisabled") + "</P>",150,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_1_9_575(param1:Event) : void
      {
         GameTipManager.closeTip("PlayerBK");
      }
      
      private function obf_d_f_783(param1:Event) : void
      {
         if(!obf_L_l_4100.isEmpty(TeamManager.teamName))
         {
            obf_X_Z_4427.showTeamSelfMenu();
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerBoxUI);
         }
      }
      
      private function obf_9_d_4621(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.fateSkillUI);
      }
      
      public function setCombat(param1:Boolean) : void
      {
         bgBox.gotoAndStop(param1 ? 2 : 1);
      }
      
      public function setPingDisplay(param1:int) : void
      {
         pingIcon.txtPing.text = param1 + "ms";
         if(param1 > 500)
         {
            pingIcon.gotoAndStop("slow");
         }
         else if(param1 > 200)
         {
            pingIcon.gotoAndStop("medium");
         }
         else
         {
            pingIcon.gotoAndStop("fast");
         }
      }
      
      public function showPKModeMenu(param1:Event) : void
      {
         if(obf_R_6_1363.isRuning)
         {
            return;
         }
         var _loc2_:PlayerMenuUI = new PlayerMenuUI("pkMode",150);
         _loc2_.addMenuItemByObject([{
            "id":"peace",
            "value":{
               "label":DiversityManager.getString("PKMode","peace"),
               "fun":GameContext.localPlayer.obf_M_m_4192,
               "par":[PKMode.PEACE_MODE]
            }
         },{
            "id":"slay",
            "value":{
               "label":DiversityManager.getString("PKMode","slay"),
               "fun":WindowManager.showConfirmBox,
               "par":[DiversityManager.getString("PKMode","confirmSlay"),this.confirmSlayPKMode]
            }
         },{
            "id":"justice",
            "value":{
               "label":DiversityManager.getString("PKMode","justice"),
               "fun":GameContext.localPlayer.obf_M_m_4192,
               "par":[PKMode.obf_F_J_1081]
            }
         },{
            "id":"team",
            "value":{
               "label":DiversityManager.getString("PKMode","team"),
               "fun":GameContext.localPlayer.obf_M_m_4192,
               "par":[PKMode.obf_9_P_3540]
            }
         },{
            "id":"family",
            "value":{
               "label":DiversityManager.getString("PKMode","family"),
               "fun":GameContext.localPlayer.obf_M_m_4192,
               "par":[PKMode.obf_f_U_3730]
            }
         }]);
         var _loc3_:Point = this.localToGlobal(new Point(this.mouseX,this.mouseY));
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         WindowManager.showWindow(_loc2_);
      }
      
      public function setPKMode(param1:int) : void
      {
         txtPK.text = obf_0_5_V_226.getModeName(param1);
      }
      
      public function confirmSlayPKMode(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.localPlayer.obf_M_m_4192(PKMode.obf_N_W_2421);
         }
      }
      
      public function obf_l_1_3544(param1:int, param2:int) : void
      {
         var _loc3_:int = Number(param1 / param2) * 100;
         barBKHP.gotoAndStop(_loc3_);
      }
      
      public function obf_t_s_1612(param1:int, param2:int) : void
      {
         var _loc3_:int = Number(param1 / param2) * 100;
         barBKMP.gotoAndStop(_loc3_);
      }
      
      public function obf_h_6_1233(param1:int, param2:int) : void
      {
         var _loc3_:int = Number(param1 / param2) * 100;
         barPetBKHP.gotoAndStop(_loc3_);
      }
      
      public function obf_J_R_3179(param1:int, param2:int) : void
      {
         var _loc3_:int = Number(param1 / param2) * 100;
         barPetBKMP.gotoAndStop(_loc3_);
      }
      
      public function hpChange(param1:Number, param2:Number) : void
      {
         txtHp.text = param1 + "/" + param2;
         var _loc3_:int = 100 * Number(param1 / param2);
         if(_loc3_ < 2)
         {
            _loc3_ = 2;
         }
         hpBar.gotoAndStop(_loc3_);
      }
      
      public function mpChange(param1:int, param2:int) : void
      {
         txtMp.text = param1 + "/" + param2;
         var _loc3_:int = 100 * Number(param1 / param2);
         if(_loc3_ < 2)
         {
            _loc3_ = 2;
         }
         mpBar.gotoAndStop(_loc3_);
      }
      
      public function spChange(param1:int, param2:int) : void
      {
      }
      
      public function headIconChange(param1:int) : void
      {
         while(headIconPoint.numChildren > 0)
         {
            headIconPoint.removeChildAt(0);
         }
         var _loc2_:DisplayObject = HeadIconCode.getHeadIconByInt(param1);
         headIconPoint.addChild(_loc2_);
      }
      
      private function obf_I_l_3741(param1:Event) : void
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.petFullInfo)
         {
            return;
         }
         obf_c_4686.sendPetActionModeChange(GameContext.localPlayer.petActionMode == obf_V_e_1630.PASSIVE_ATTACK ? obf_V_e_1630.DEFENSE : obf_V_e_1630.PASSIVE_ATTACK);
      }
      
      private function obf_0_7_2_90(param1:Event) : void
      {
         if(!GameContext.localPlayer.petFullInfo)
         {
            return;
         }
         obf_K_e_3075.petBoxUI.selectPet(GameContext.localPlayer.petFullInfo.petId,GameContext.localPlayer.petFullInfo.petCode);
         obf_K_e_3075.petBoxUI.showPetInfo(GameContext.localPlayer.petFullInfo);
         obf_K_e_3075.showUI(obf_K_e_3075.petBoxContainerUI);
         obf_K_e_3075.closeAllChildUI(obf_K_e_3075.petBoxContainerUI);
         obf_K_e_3075.showChildUI(obf_K_e_3075.petBoxContainerUI,obf_K_e_3075.petBoxUI);
      }
      
      public function updatePetInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         txtPetHP.text = "";
         txtPetMP.text = "";
         txtPetLevel.text = "";
         petHpBar.gotoAndStop(1);
         petMpBar.gotoAndStop(1);
         if(!GameContext.localPlayer || !GameContext.localPlayer.petFullInfo || this.showPetId != GameContext.localPlayer.petFullInfo.petId)
         {
            while(pointPetIcon.numChildren > 0)
            {
               pointPetIcon.removeChildAt(0);
            }
            this.showPetId = "";
         }
         if(Boolean(GameContext.localPlayer) && Boolean(GameContext.localPlayer.petFullInfo))
         {
            if(this.showPetId != GameContext.localPlayer.petFullInfo.petId)
            {
               pointPetIcon.addChild(GameItemManager.getItemIcon(GameContext.localPlayer.petFullInfo.petCode));
            }
            this.showPetId = GameContext.localPlayer.petFullInfo.petId;
            txtPetLevel.text = GameContext.localPlayer.petFullInfo.level + "";
            txtPetHP.text = GameContext.localPlayer.petFullInfo.hp + "/" + GameContext.localPlayer.petFullInfo.attributes.hpMax;
            txtPetMP.text = GameContext.localPlayer.petFullInfo.mp + "/" + GameContext.localPlayer.petFullInfo.attributes.mpMax;
            _loc1_ = GameContext.localPlayer.petFullInfo.hp / GameContext.localPlayer.petFullInfo.attributes.hpMax * 100;
            _loc2_ = GameContext.localPlayer.petFullInfo.mp / GameContext.localPlayer.petFullInfo.attributes.mpMax * 100;
            petHpBar.gotoAndStop(_loc1_);
            petMpBar.gotoAndStop(_loc2_);
         }
         txtPetAction.visible = GameContext.localPlayer.petFullInfo != null;
         DiversityManager.setTextField(txtPetAction,"PlayerInfoUI",GameContext.localPlayer.petActionMode == obf_V_e_1630.PASSIVE_ATTACK ? "txtPetPassive" : "txtPetDefense");
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
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

