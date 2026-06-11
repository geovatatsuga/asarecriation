package com.sunweb.game.rpg.playerUI.family
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyInfo;
   import com.sunweb.game.rpg.family.FamilyMemberInfo;
   import com.sunweb.game.rpg.family.FamilyMyInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.family.obf_Q_D_1342;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.mail.obf_G_6_4257;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.module.obf_w_h_3726;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.skill.obf_b_5_962;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FamilyBoxUIMC;
   import playerUI.SkillShowBoxUIMC;
   
   public class FamilyBoxUI extends FamilyBoxUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_Z_A_2081:FamilyInfo;
      
      private var obf_b_L_3757:String;
      
      private var obf_B_I_1828:Object;
      
      private var obf_L_V_3038:int;
      
      private var skillShowBoxList:Array;
      
      private var familySkillList:Array;
      
      public function FamilyBoxUI()
      {
         var _loc10_:Object = null;
         var _loc11_:SkillShowBoxUIMC = null;
         var _loc12_:obf_b_5_962 = null;
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         expBar.gotoAndStop(1);
         cmdDismissFamily.visible = false;
         cmdSetBulletin.visible = false;
         cmdSetRank.visible = false;
         this.bags = new Array();
         this.familySkillList = JSONUtil.getObject(SkillConfig.skillConfig,["familySkill"],[]) as Array;
         this.skillShowBoxList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc10_ = JSONUtil.getObject(this.familySkillList,[_loc1_]);
            _loc11_ = this["skillBag" + _loc1_];
            if(!(!_loc11_ || !_loc10_))
            {
               _loc12_ = new obf_b_5_962(_loc11_,this,_loc10_.code);
               this.skillShowBoxList.push(_loc12_);
               this.bags.push(_loc12_.iconBag);
            }
            _loc1_++;
         }
         this.initDiversity();
         var _loc2_:Array = new Array();
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Online"));
         _loc3_.dataField = "isOnline";
         _loc3_.editable = false;
         _loc3_.width = 60;
         _loc3_.minWidth = 55;
         _loc2_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Sex"));
         _loc4_.dataField = "sex";
         _loc4_.editable = false;
         _loc4_.sortable = false;
         _loc4_.width = 25;
         _loc4_.minWidth = 35;
         _loc2_.push(_loc4_);
         var _loc5_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Level"));
         _loc5_.dataField = "level";
         _loc5_.editable = false;
         _loc5_.sortOptions = Array.NUMERIC;
         _loc5_.width = 30;
         _loc5_.minWidth = 35;
         _loc2_.push(_loc5_);
         var _loc6_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Name"));
         _loc6_.dataField = "name";
         _loc6_.editable = false;
         _loc6_.sortable = false;
         _loc6_.width = 55;
         _loc6_.minWidth = 50;
         _loc2_.push(_loc6_);
         var _loc7_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_NickName"));
         _loc7_.dataField = "familyTitle";
         _loc7_.editable = false;
         _loc7_.sortable = false;
         _loc2_.push(_loc7_);
         var _loc8_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Rank"));
         _loc8_.dataField = "postName";
         _loc8_.editable = false;
         _loc2_.push(_loc8_);
         var _loc9_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyBoxUI","listTitle_Gx"));
         _loc9_.dataField = "thisFamilyGx";
         _loc9_.editable = false;
         _loc9_.sortOptions = Array.NUMERIC;
         _loc9_.width = 95;
         _loc9_.minWidth = 90;
         _loc2_.push(_loc9_);
         memberList.columns = _loc2_;
         memberList.labelFunction = this.obf_Y_r_3124;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc1_:obf_b_5_962 = null;
         DiversityManager.setTextField(txtDeyTitle,"FamilyBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyFamilyInfo,"FamilyBoxUI","txtFamilyInfo");
         DiversityManager.setTextField(txtDeyFamilyBulletin,"FamilyBoxUI","txtFamilyBulletin");
         DiversityManager.setTextField(txtDeyFamilyIntroduction,"FamilyBoxUI","txtFamilyIntroduction");
         DiversityManager.setTextField(txtDeyFamilyMember,"FamilyBoxUI","txtFamilyMember");
         DiversityManager.setTextField(txtDeyFamilyName,"FamilyBoxUI","txtFamilyName");
         DiversityManager.setTextField(txtDeyFamilyLevel,"FamilyBoxUI","txtFamilyLevel");
         DiversityManager.setTextField(txtDeyFamilyMemberCount,"FamilyBoxUI","txtFamilyMemberCount");
         DiversityManager.setTextField(txtDeyFamilyGold,"FamilyBoxUI","txtFamilyGold");
         DiversityManager.setTextField(txtDeyFamilyLeader,"FamilyBoxUI","txtFamilyLeader");
         DiversityManager.setTextField(txtDeyFamilyExp,"FamilyBoxUI","txtFamilyExp");
         DiversityManager.setTextField(txtDeyFamilyGx,"FamilyBoxUI","txtFamilyGx");
         DiversityManager.setTextField(txtDeyFamilyTotlaGx,"FamilyBoxUI","txtTotalFamilyGx");
         DiversityManager.setTextField(txtDeyFamilyPost,"FamilyBoxUI","txtFamilyPost");
         DiversityManager.setTextField(txtDeyFamilyRes,"FamilyBoxUI","txtFamilyRes");
         DiversityManager.setTextField(txtDeyFamilyRes2,"FamilyBoxUI","txtFamilyRes2");
         cmdLeaveFamily.label = DiversityManager.getString("FamilyBoxUI","cmdLeaveFamily");
         cmdSetBulletin.label = DiversityManager.getString("FamilyBoxUI","cmdSetBulletin");
         cmdSetRank.label = DiversityManager.getString("FamilyBoxUI","cmdSetRank");
         cmdUpgrade.label = DiversityManager.getString("FamilyBoxUI","cmdUpgrade");
         cmdDismissFamily.label = DiversityManager.getString("FamilyBoxUI","cmdDismissFamily");
         cmdSetIntroduction.label = DiversityManager.getString("FamilyBoxUI","cmdSetIntroduction");
         cmdJoin.label = DiversityManager.getString("FamilyBoxUI","cmdJoin");
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.operationButton.label = DiversityManager.getString("FamilyBoxUI","cmdSkillUpgrade");
         }
      }
      
      public function set familyLeader(param1:String) : void
      {
         this.obf_b_L_3757 = param1;
         txtFamilyLeader.text = this.obf_b_L_3757;
      }
      
      public function get familyLeader() : String
      {
         return this.obf_b_L_3757;
      }
      
      public function set familyGold(param1:int) : void
      {
         while(pointFamilyGold.numChildren > 0)
         {
            pointFamilyGold.removeChildAt(0);
         }
         this.obf_L_V_3038 = param1;
         pointFamilyGold.addChild(obf_a_f_2935.getGoldDisplay(this.obf_L_V_3038));
      }
      
      public function get familyGold() : int
      {
         return this.obf_L_V_3038;
      }
      
      private function addListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         memberList.addEventListener(ListEvent.ITEM_CLICK,this.obf_i_n_4836);
         memberList.addEventListener(MouseEvent.MOUSE_DOWN,this.obf_0_2_n_687);
         cmdLeaveFamily.addEventListener(MouseEvent.CLICK,this.obf_9_W_3495);
         cmdDismissFamily.addEventListener(MouseEvent.CLICK,this.onClickDismiss);
         cmdUpgrade.addEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
         cmdSetBulletin.addEventListener(MouseEvent.CLICK,this.obf_M_D_910);
         cmdSetIntroduction.addEventListener(MouseEvent.CLICK,this.obf_h_K_766);
         cmdSetRank.addEventListener(MouseEvent.CLICK,this.onClickEditPost);
         cmdJoin.addEventListener(MouseEvent.CLICK,this.onClickJoinList);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.addEventListener(obf_b_5_962.obf_F_c_4296,this.obf_X_s_1010);
            _loc1_.addEventListener(obf_b_5_962.obf_J_Q_3700,this.obf_t_S_3849);
            _loc1_.addEventListener(obf_b_5_962.obf_K_w_1992,this.obf_S_h_4370);
            _loc1_.addEventListener(obf_b_5_962.obf_c_7_1394,this.obf_i_R_2473);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         memberList.removeEventListener(ListEvent.ITEM_CLICK,this.obf_i_n_4836);
         memberList.removeEventListener(MouseEvent.MOUSE_DOWN,this.obf_0_2_n_687);
         cmdLeaveFamily.removeEventListener(MouseEvent.CLICK,this.obf_9_W_3495);
         cmdDismissFamily.removeEventListener(MouseEvent.CLICK,this.onClickDismiss);
         cmdUpgrade.removeEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
         cmdSetBulletin.removeEventListener(MouseEvent.CLICK,this.obf_M_D_910);
         cmdSetIntroduction.removeEventListener(MouseEvent.CLICK,this.obf_h_K_766);
         cmdSetRank.removeEventListener(MouseEvent.CLICK,this.onClickEditPost);
         cmdJoin.removeEventListener(MouseEvent.CLICK,this.onClickJoinList);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.removeEventListener(obf_b_5_962.obf_F_c_4296,this.obf_X_s_1010);
            _loc1_.removeEventListener(obf_b_5_962.obf_J_Q_3700,this.obf_t_S_3849);
            _loc1_.removeEventListener(obf_b_5_962.obf_K_w_1992,this.obf_S_h_4370);
            _loc1_.removeEventListener(obf_b_5_962.obf_c_7_1394,this.obf_i_R_2473);
         }
      }
      
      private function obf_Y_r_3124(param1:Object, param2:DataGridColumn) : String
      {
         if(param2.dataField == "sex")
         {
            return param1[param2.dataField] == 1 ? DiversityManager.getString("EquipmentAttribute","man") : DiversityManager.getString("EquipmentAttribute","woman");
         }
         if(param2.dataField == "isOnline")
         {
            return param1[param2.dataField] ? DiversityManager.getString("CommonPrompt","online") : DiversityManager.getString("CommonPrompt","offline");
         }
         return param1[param2.dataField];
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_i_n_4836(param1:ListEvent) : void
      {
         if(param1.columnIndex == 3)
         {
            obf_X_Z_4427.showFamilyMemberMenu(param1.item as FamilyMemberInfo);
         }
      }
      
      private function obf_X_s_1010(param1:Event) : void
      {
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         if(PlayerSkillManager.getSkillLevel(_loc2_.itemCode) >= obf_F_9_1495.getFamilySkillLevel(_loc2_.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","skill_familySkillNotReached"));
            return;
         }
         var _loc3_:Object = PlayerSkillManager.getUpSkillCondition(_loc2_.itemCode,PlayerSkillManager.getSkillLevel(_loc2_.itemCode) + 1);
         if(ConditionScript.checkCondition(_loc3_,null,true))
         {
            WindowManager.showConfirmBox(DiversityManager.getString("FamilyBoxUI","confirm_LearnSkill"),this.confirmUpSkill,_loc2_.itemCode);
         }
      }
      
      private function confirmUpSkill(param1:Object) : void
      {
         if(param1.confirm)
         {
            PlayerSkillManager.sendLearnSkill(param1.par,PlayerSkillManager.obf_6_5_3904);
         }
      }
      
      private function obf_t_S_3849(param1:Event) : void
      {
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_S_g_2750))
         {
            return;
         }
         var _loc3_:int = obf_F_9_1495.getFamilySkillLevel(_loc2_.itemCode);
         var _loc4_:Object = obf_F_9_1495.getFamilySkillUpgradeCondition(_loc2_.itemCode,_loc3_ + 1);
         if(ConditionScript.checkCondition(_loc4_,null,true))
         {
            WindowManager.showConfirmBox(DiversityManager.getString("FamilyBoxUI","confirm_UpgradeSkill"),this.confirmUpgradeSkill,_loc2_.itemCode);
         }
      }
      
      private function confirmUpgradeSkill(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_F_9_1495.sendUpgradeFamilySkill(param1.par);
         }
      }
      
      private function obf_S_h_4370(param1:Event) : void
      {
         GameTipManager.closeTip("FamilySkillUpgradeCondition");
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = obf_F_9_1495.getFamilySkillLevel(_loc2_.itemCode);
         var _loc4_:Object = obf_F_9_1495.getFamilySkillUpgradeCondition(_loc2_.itemCode,_loc3_ + 1);
         var _loc5_:GameTipUI = new GameTipUI("FamilySkillUpgradeCondition");
         _loc5_.addTipInfo("<P align=\'center\'><font color=\'#FFFF00\'>" + DiversityManager.getString("FamilyBoxUI","skill_upgradeTipTitle") + "</font></p>",200,0);
         _loc5_.addTipInfo(ConditionScript.getConditionsHTML(_loc4_),200,_loc5_.maxRow + 2);
         GameTipManager.showTip(_loc5_);
      }
      
      private function obf_i_R_2473(param1:Event) : void
      {
         GameTipManager.closeTip("FamilySkillUpgradeCondition");
      }
      
      private function obf_0_2_n_687(param1:Event) : void
      {
         PlayerMenuUI.closeMenuById("familyMemberMenu");
      }
      
      private function obf_9_W_3495(param1:Event) : void
      {
         if(obf_F_9_1495.isLeaderPost(GameContext.localPlayer.familyMyInfo.postLevel))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_LeaderCantQuit"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("FamilyBoxUI","prompt_ConfirmQuitFamily"),obf_F_9_1495.confirmQuitFamily);
      }
      
      private function onClickDismiss(param1:Event) : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_u_1_2979))
         {
            return;
         }
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyBoxUI","prompt_ConfirmDismissFamily")),obf_F_9_1495.confirmDismissFamily);
      }
      
      private function obf_Z_v_1153(param1:Event) : void
      {
         if(this.obf_Z_A_2081.level >= obf_F_9_1495.maxFamilyLevel)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_nowMaxLevel"));
            return;
         }
         var _loc2_:Object = obf_F_9_1495.getLevelConfig(this.obf_Z_A_2081.level);
         if(!_loc2_)
         {
            return;
         }
         if(this.obf_Z_A_2081.exp < JSONUtil.getInt(_loc2_,["expToUpgrade"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_expNotEnough"));
            return;
         }
         if(this.obf_Z_A_2081.gold < JSONUtil.getInt(_loc2_,["goldToUpgrade"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_goldNotEnough",[obf_a_f_2935.getGoldString(JSONUtil.getInt(_loc2_,["goldToUpgrade"]))]));
            return;
         }
         if(this.obf_Z_A_2081.res1 < JSONUtil.getInt(_loc2_,["res1ToUpgrade"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_res1NotEnough",[JSONUtil.getInt(_loc2_,["res1ToUpgrade"])]));
            return;
         }
         if(this.obf_Z_A_2081.res2 < JSONUtil.getInt(_loc2_,["res2ToUpgrade"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_res2NotEnough",[JSONUtil.getInt(_loc2_,["res2ToUpgrade"])]));
            return;
         }
         if(this.obf_Z_A_2081.res3 < JSONUtil.getInt(_loc2_,["res3ToUpgrade"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FamilyBoxUI","prompt_upgrade_res3NotEnough",[JSONUtil.getInt(_loc2_,["res3ToUpgrade"])]));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("FamilyBoxUI","prompt_ConfirmUpgrade",[obf_a_f_2935.getGoldString(JSONUtil.getInt(_loc2_,["goldToUpgrade"]),true)]),this.confirmUpgrade);
      }
      
      private function confirmUpgrade(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_F_9_1495.obf_Y_I_3589();
         }
      }
      
      private function obf_M_D_910(param1:Event) : void
      {
         WindowManager.showModalWindow(new obf_w_h_3726(DiversityManager.getString("FamilyBoxUI","prompt_InputNotice"),WorldConfig.getValue("wordLength","maxFamilyNoticeLength")),this.inputBulletin);
      }
      
      private function inputBulletin(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            if(obf_r_Y_1874.isUnlawful(param1.content))
            {
               WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","invalidName"));
               return;
            }
            obf_F_9_1495.sendEditNotice(param1.content);
         }
      }
      
      private function obf_h_K_766(param1:Event) : void
      {
         WindowManager.showModalWindow(new obf_w_h_3726(DiversityManager.getString("FamilyBoxUI","prompt_InputIntroduction"),WorldConfig.getValue("wordLength","maxFamilyDeclarationLength")),this.inputIntroduction);
      }
      
      private function inputIntroduction(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            if(obf_r_Y_1874.isUnlawful(param1.content))
            {
               WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","invalidName"));
               return;
            }
            obf_F_9_1495.sendEditDeclaration(param1.content);
         }
      }
      
      private function onClickEditPost(param1:Event) : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_e_o_1807))
         {
            return;
         }
         obf_F_9_1495.sendViewPost();
      }
      
      private function onClickJoinList(param1:Event) : void
      {
         obf_F_9_1495.sendViewJoinList();
      }
      
      private function obf_X_q_4051(param1:Event) : void
      {
         if(!this.obf_Z_A_2081)
         {
            return;
         }
         obf_G_6_4257.showSendMailUI(obf_G_6_4257.obf_p_U_3894,this.obf_Z_A_2081.familyName);
         obf_K_e_3075.closeUI(this);
      }
      
      public function obf_u_H_2162() : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_b_5_962 = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.familySkillList.length)
         {
            _loc2_ = this.familySkillList[_loc1_];
            _loc3_ = this.skillShowBoxList[_loc1_];
            if(!(!_loc2_ || !_loc3_))
            {
               _loc3_.operationButton.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_S_g_2750);
               _loc3_.obf_y_4_1171({});
               _loc3_.iconBag.setKeyTipInfo(PlayerSkillManager.getSkillLevel(_loc2_.code) + "/" + obf_F_9_1495.getFamilySkillLevel(_loc2_.code));
            }
            _loc1_++;
         }
      }
      
      public function obf_0_7_k_265() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         cmdSetRank.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_e_o_1807);
         cmdUpgrade.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_F_Z_2323);
         cmdDismissFamily.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_u_1_2979);
         cmdSetBulletin.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_N_P_4069);
         cmdSetIntroduction.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_w_Q_2038);
         cmdJoin.visible = GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_q_Y_3200);
         cmdSetBulletin.visible = VersionConfig.enableFamilyPost;
         cmdSetIntroduction.visible = VersionConfig.enableFamilyPost;
      }
      
      public function obf_v_A_850() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:FamilyMemberInfo = null;
         if(this.obf_Z_A_2081)
         {
            _loc1_ = 0;
            if(this.obf_B_I_1828)
            {
               for(_loc2_ in this.obf_B_I_1828)
               {
                  _loc3_ = this.obf_B_I_1828[_loc2_];
                  if(Boolean(_loc3_) && _loc3_.isOnline)
                  {
                     _loc1_++;
                  }
               }
            }
            DiversityManager.setTextField(txtFamilyMemberCount,"FamilyBoxUI","txtOnlineCount",[_loc1_,memberList.dataProvider.length],true);
         }
         else
         {
            txtFamilyMemberCount.text = "";
         }
      }
      
      public function setFamilyInfo(param1:FamilyInfo) : void
      {
         txtFamilyName.text = "";
         txtFamilyLevel.text = "";
         txtFamilyExp.text = "";
         txtRes2.text = "";
         this.familyGold = 0;
         expBar.gotoAndStop(1);
         this.obf_Z_A_2081 = param1;
         if(!this.obf_Z_A_2081)
         {
            return;
         }
         txtFamilyName.text = param1.familyName;
         DiversityManager.setTextField(txtFamilyLevel,"FamilyBoxUI","txtLevel",[param1.level,JSONUtil.getInt(obf_F_9_1495.getLevelConfig(this.obf_Z_A_2081.level),["memberNumber"])],true);
         txtFamilyExp.text = param1.exp + " / " + JSONUtil.getInt(obf_F_9_1495.getLevelConfig(param1.level),["expToUpgrade"]);
         var _loc2_:int = param1.exp / JSONUtil.getInt(obf_F_9_1495.getLevelConfig(param1.level),["expToUpgrade"]) * 100;
         expBar.gotoAndStop(_loc2_);
         txtRes2.text = param1.res2 + "";
         this.familyGold = param1.gold;
      }
      
      public function setFamilyMyInfo(param1:FamilyMyInfo) : void
      {
         if(!param1)
         {
            param1 = new FamilyMyInfo();
         }
         txtFamilyGx.text = param1.thisFamilyGx + "";
         txtFamilyTotlaGx.text = param1.totalFamilyGx + "";
         txtFamilyPost.text = param1.postName;
      }
      
      public function set familyNotice(param1:String) : void
      {
         txtMessage.multiline = true;
         txtMessage.wordWrap = true;
         txtMessage.text = param1;
      }
      
      public function set familyDeclaration(param1:String) : void
      {
         txtIntroduction.multiline = true;
         txtIntroduction.wordWrap = true;
         txtIntroduction.text = param1;
      }
      
      public function obf_8_p_2289() : void
      {
         if(!memberList.dataProvider)
         {
            return;
         }
         memberList.dataProvider.sortOn(["isOnline","level"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
      }
      
      public function setMemberList(param1:Array) : void
      {
         var _loc2_:FamilyMemberInfo = null;
         if(!param1)
         {
            return;
         }
         this.familyLeader = "";
         memberList.removeAll();
         this.obf_B_I_1828 = new Object();
         GameContext.localPlayer.familyMemberSet = this.obf_B_I_1828;
         for each(_loc2_ in param1)
         {
            memberList.addItem(_loc2_);
            this.obf_B_I_1828[_loc2_.name] = _loc2_;
            if(obf_F_9_1495.isLeaderPost(_loc2_.postLevel))
            {
               this.familyLeader = _loc2_.name;
            }
         }
         this.obf_8_p_2289();
         this.obf_v_A_850();
      }
      
      public function setMemberInfo(param1:FamilyMemberInfo) : void
      {
         if(!memberList.dataProvider)
         {
            return;
         }
         memberList.dataProvider.replaceItem(param1,this.getMemberInfoByName(param1.name));
         this.obf_B_I_1828[param1.name] = param1;
         if(obf_F_9_1495.isLeaderPost(param1.postLevel))
         {
            this.familyLeader = param1.name;
         }
         this.obf_8_p_2289();
         this.obf_v_A_850();
      }
      
      public function obf_7_z_1853(param1:FamilyMemberInfo) : void
      {
         if(!memberList.dataProvider)
         {
            return;
         }
         if(this.obf_B_I_1828[param1.name])
         {
            memberList.dataProvider.replaceItem(param1,this.obf_B_I_1828[param1.name]);
         }
         else
         {
            memberList.addItem(param1);
         }
         this.obf_B_I_1828[param1.name] = param1;
         this.obf_8_p_2289();
         this.obf_v_A_850();
      }
      
      public function removeMember(param1:String) : void
      {
         memberList.removeItem(this.getMemberInfoByName(param1));
         delete this.obf_B_I_1828[param1];
         this.obf_8_p_2289();
         this.obf_v_A_850();
      }
      
      public function getMemberInfoByName(param1:String) : FamilyMemberInfo
      {
         if(!this.obf_B_I_1828)
         {
            return null;
         }
         return this.obf_B_I_1828[param1];
      }
      
      public function getMemberIndexByName(param1:String) : int
      {
         if(!memberList.dataProvider)
         {
            return -1;
         }
         return memberList.dataProvider.getItemIndex(this.getMemberInfoByName(param1));
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         obf_F_9_1495.obf_f_4652();
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

