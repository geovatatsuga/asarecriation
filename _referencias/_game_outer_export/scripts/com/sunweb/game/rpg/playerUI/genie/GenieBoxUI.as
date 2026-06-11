package com.sunweb.game.rpg.playerUI.genie
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.genie.GenieFullInfo;
   import com.sunweb.game.rpg.genie.ItemPlayerGenieInfo;
   import com.sunweb.game.rpg.genie.obf_P_e_2948;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_Z_L_1552;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.GenieBoxUIMC;
   
   public class GenieBoxUI extends GenieBoxUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var genieBags:Array;
      
      private var obf_o_D_3154:Array;
      
      private var genieView:obf_Z_L_1552;
      
      private var upgradeGenieView:obf_Z_L_1552;
      
      private var obf_a_V_3165:GenieFullInfo;
      
      private var obf_V_s_2623:String;
      
      private var obf_X_D_1983:String;
      
      private var genieActionTimeInv:TimeLimiter;
      
      private var timeInv:TimeLimiter;
      
      public function GenieBoxUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         this.genieActionTimeInv = new TimeLimiter(3000);
         this.timeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         selectGenieBox.mouseEnabled = false;
         selectGenieBox.visible = false;
         barGenieExp.gotoAndStop(1);
         barGenieUnseal.gotoAndStop(1);
         this.bags = new Array();
         this.genieBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc3_ = this["bag" + _loc1_];
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.addValidType(GameItemType.obf_N_v_4048);
               this.bags.push(_loc4_);
               this.genieBags.push(_loc4_);
            }
            _loc1_++;
         }
         this.obf_o_D_3154 = new Array();
         var _loc2_:int = 0;
         while(_loc2_ <= 1)
         {
            _loc5_ = this["bagUnseal" + _loc2_];
            if(_loc5_)
            {
               _loc6_ = new IconItemBag(_loc5_,this,_loc2_);
               _loc6_.addValidType(GameItemType.ALL);
               _loc6_.lockDrag = true;
               this.bags.push(_loc6_);
               this.obf_o_D_3154.push(_loc6_);
            }
            _loc2_++;
         }
         this.addListener();
         this.setChildIndex(selectGenieBox,this.numChildren - 1);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyGenieName,"GenieBoxUI","txtGenieName");
         DiversityManager.setTextField(txtDeyGenieLevel,"GenieBoxUI","txtGenieLevel");
         DiversityManager.setTextField(txtDeyGenieExp,"GenieBoxUI","txtGenieExp");
         DiversityManager.setTextField(txtDeyLevelUpSp,"GenieBoxUI","txtLevelUpSp");
         DiversityManager.setTextField(txtDeyResult,"GenieBoxUI","txtResult");
         DiversityManager.setTextField(txtDeyResultPhysicsAttack,"GenieBoxUI","txtResultPhysicsAttack");
         DiversityManager.setTextField(txtDeyResultMagicAttack,"GenieBoxUI","txtResultMagicAttack");
         DiversityManager.setTextField(txtDeyResultPhysicsDef,"GenieBoxUI","txtResultPhysicsDef");
         DiversityManager.setTextField(txtDeyResultMagicDef,"GenieBoxUI","txtResultMagicDef");
         DiversityManager.setTextField(txtDeyResultLife,"GenieBoxUI","txtResultLife");
         DiversityManager.setTextField(txtDeyResultCure,"GenieBoxUI","txtResultCure");
         DiversityManager.setTextField(txtDeySelfApt,"GenieBoxUI","txtSelfApt");
         DiversityManager.setTextField(txtDeyLevelApt,"GenieBoxUI","txtLevelApt");
         DiversityManager.setTextField(txtDeyPhysicsAttackApt,"GenieBoxUI","txtPhysicsAttackApt");
         DiversityManager.setTextField(txtDeyMagicAttackApt,"GenieBoxUI","txtMagicAttackApt");
         DiversityManager.setTextField(txtDeyPhysicsDefApt,"GenieBoxUI","txtPhysicsDefApt");
         DiversityManager.setTextField(txtDeyMagicDefApt,"GenieBoxUI","txtMagicDefApt");
         DiversityManager.setTextField(txtDeyLifeApt,"GenieBoxUI","txtLifeApt");
         DiversityManager.setTextField(txtDeyCureApt,"GenieBoxUI","txtCureApt");
         DiversityManager.setTextField(txtDeyGenieUpgrade,"GenieBoxUI","txtGenieUpgrade");
         DiversityManager.setTextField(txtDeyUpgradeSelfApt,"GenieBoxUI","txtUpgradeSelfApt");
         DiversityManager.setTextField(txtDeyUpgradePhysicsAttackApt,"GenieBoxUI","txtUpgradePhysicsAttackApt");
         DiversityManager.setTextField(txtDeyUpgradeMagicAttackApt,"GenieBoxUI","txtUpgradeMagicAttackApt");
         DiversityManager.setTextField(txtDeyUpgradePhysicsDefApt,"GenieBoxUI","txtUpgradePhysicsDefApt");
         DiversityManager.setTextField(txtDeyUpgradeMagicDefApt,"GenieBoxUI","txtUpgradeMagicDefApt");
         DiversityManager.setTextField(txtDeyUpgradeLifeApt,"GenieBoxUI","txtUpgradeLifeApt");
         DiversityManager.setTextField(txtDeyUpgradeCureApt,"GenieBoxUI","txtUpgradeCureApt");
         DiversityManager.setTextField(txtDeyGenieUnseal,"GenieBoxUI","txtGenieUnseal");
         DiversityManager.setTextField(txtDeyUnsealGold,"GenieBoxUI","txtUnsealGold");
         DiversityManager.setTextField(txtDeyUnsealSp,"GenieBoxUI","txtUnsealSp");
         DiversityManager.setTextField(txtDeyUnsealRemark,"GenieBoxUI","txtUnsealRemark");
         cmdUse.label = DiversityManager.getString("GenieBoxUI","cmdUse");
         cmdBack.label = DiversityManager.getString("GenieBoxUI","cmdBack");
         cmdGenieLevelUp.label = DiversityManager.getString("GenieBoxUI","cmdGenieLevelUp");
         cmdGenieUnseal.label = DiversityManager.getString("GenieBoxUI","cmdGenieUnseal");
      }
      
      public function get obf_7_e_2722() : GenieFullInfo
      {
         return this.obf_a_V_3165;
      }
      
      public function getGenieBags() : Array
      {
         return this.genieBags;
      }
      
      private function addListener() : void
      {
         cmdUse.addEventListener(MouseEvent.CLICK,this.obf_l_2_2521);
         cmdBack.addEventListener(MouseEvent.CLICK,this.obf_T_g_3455);
         cmdGenieLevelUp.addEventListener(MouseEvent.CLICK,this.onClickLevelUp);
         cmdGenieUnseal.addEventListener(MouseEvent.CLICK,this.obf_b_J_1235);
         cmdPhysicsAttackApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdPhysicsDefApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdMagicAttackApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdMagicDefApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdLifeApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdCureApt.addEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
      }
      
      private function removeListener() : void
      {
         cmdUse.removeEventListener(MouseEvent.CLICK,this.obf_l_2_2521);
         cmdBack.removeEventListener(MouseEvent.CLICK,this.obf_T_g_3455);
         cmdGenieLevelUp.removeEventListener(MouseEvent.CLICK,this.onClickLevelUp);
         cmdGenieUnseal.removeEventListener(MouseEvent.CLICK,this.obf_b_J_1235);
         cmdPhysicsAttackApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdPhysicsDefApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdMagicAttackApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdMagicDefApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdLifeApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
         cmdCureApt.removeEventListener(MouseEvent.CLICK,this.obf_x_1_1653);
      }
      
      private function obf_x_1_1653(param1:Event) : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         if(param1.currentTarget == cmdPhysicsAttackApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddPhysicsAttackApt",{"genieId":this.obf_a_V_3165.genieId});
         }
         else if(param1.currentTarget == cmdPhysicsDefApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddPhysicsDefApt",{"genieId":this.obf_a_V_3165.genieId});
         }
         else if(param1.currentTarget == cmdMagicAttackApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddMagicAttackApt",{"genieId":this.obf_a_V_3165.genieId});
         }
         else if(param1.currentTarget == cmdMagicDefApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddMagicDefApt",{"genieId":this.obf_a_V_3165.genieId});
         }
         else if(param1.currentTarget == cmdLifeApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddLifeApt",{"genieId":this.obf_a_V_3165.genieId});
         }
         else if(param1.currentTarget == cmdCureApt)
         {
            ButtonToItemManager.useBTIById("Genie_AddCureApt",{"genieId":this.obf_a_V_3165.genieId});
         }
      }
      
      private function obf_l_2_2521(param1:Event) : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         obf_P_e_2948.sendSetUsingGenie(this.obf_a_V_3165.genieId);
      }
      
      private function obf_T_g_3455(param1:Event) : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         obf_P_e_2948.sendSetUsingGenie("");
      }
      
      private function onClickLevelUp(param1:Event) : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         if(this.obf_a_V_3165.exp < obf_P_e_2948.getGenieLevelUpExp(this.obf_a_V_3165.level))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieBoxUI","prompt_MustFullExpLevelUp"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.attributes.sp < obf_P_e_2948.getGenieLevelUpSp(this.obf_a_V_3165.level))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieBoxUI","prompt_NeedSp",[obf_P_e_2948.getGenieLevelUpSp(this.obf_a_V_3165.level)]));
            return;
         }
         obf_P_e_2948.sendGenieLevelUp(this.obf_a_V_3165.genieId);
      }
      
      private function obf_b_J_1235(param1:Event) : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_a_V_3165.genieCode);
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["properties","upgradeCondition"]);
         if(!_loc3_)
         {
            return;
         }
         ConditionScript.genieInfoForCondition = this.obf_a_V_3165;
         if(!ConditionScript.checkCondition(_loc3_,null,true))
         {
            return;
         }
         obf_P_e_2948.sendGenieUnseal(this.obf_a_V_3165.genieId);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:GameItemFullInfo = null;
         var _loc3_:int = 0;
         if(this.timeInv.checkTimeout() && !obf_L_l_4100.isEmpty(this.obf_X_D_1983))
         {
            if(!this.obf_a_V_3165 || this.obf_a_V_3165.genieId != this.obf_X_D_1983)
            {
               _loc2_ = GameItemInfoManager.getItemInfo(this.obf_X_D_1983);
               if(!_loc2_)
               {
                  GameContext.bagItemManager.sendViewItem(this.obf_X_D_1983);
               }
               else if(!_loc2_.isEmpty && Boolean(_loc2_.genieInfo))
               {
                  this.showGenieInfo(obf_P_e_2948.itemFullInfoToGenieFullInfo(_loc2_));
               }
            }
         }
         if(this.genieActionTimeInv.checkTimeout())
         {
            _loc3_ = Math.random() * 9 - 1;
            if(this.genieView)
            {
               this.genieView.onUpdate();
               this.genieView.doAction(obf_S_c_3330.obf_h_4_3537,_loc3_,true);
            }
            if(this.upgradeGenieView)
            {
               this.upgradeGenieView.onUpdate();
               this.upgradeGenieView.doAction(obf_S_c_3330.obf_h_4_3537,_loc3_,true);
            }
         }
      }
      
      public function obf_R_F_1307() : void
      {
         if(this.getGenieBagById(this.obf_X_D_1983) == null)
         {
            this.obf_V_s_2623 = "";
            this.obf_X_D_1983 = "";
            this.obf_0_4_L_436();
         }
      }
      
      public function obf_0_8_d_92() : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         txtGenieExp.text = this.obf_a_V_3165.exp + "/" + obf_P_e_2948.getGenieLevelUpExp(this.obf_a_V_3165.level);
         var _loc1_:int = this.obf_a_V_3165.exp / obf_P_e_2948.getGenieLevelUpExp(this.obf_a_V_3165.level) * 100;
         barGenieExp.gotoAndStop(_loc1_);
      }
      
      public function obf_B_F_3224() : void
      {
         if(!this.obf_a_V_3165)
         {
            return;
         }
         txtGenieUnseal.text = this.obf_a_V_3165.upgradeRate + "%";
         barGenieUnseal.gotoAndStop(this.obf_a_V_3165.upgradeRate);
      }
      
      public function showGenieInfo(param1:GenieFullInfo) : void
      {
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:IconItemBag = null;
         var _loc14_:IconItem = null;
         this.obf_0_4_L_436();
         this.obf_a_V_3165 = param1;
         var _loc2_:Object = GameItemManager.getItemConfig(param1.genieCode);
         if(!_loc2_)
         {
            return;
         }
         this.genieView = new obf_Z_L_1552(param1.genieCode);
         this.genieView.moveToPixel(0,0);
         pointGenieView.addChild(this.genieView);
         txtGenieName.text = GameItemManager.getItemName(param1.genieCode);
         DiversityManager.setTextField(txtGenieLevel,"GenieBoxUI","txtGenieLevelNumber",[param1.level,JSONUtil.getInt(_loc2_,["properties","maxLevel"])]);
         txtLevelUpSp.text = obf_P_e_2948.getGenieLevelUpSp(param1.level) + "";
         this.obf_0_8_d_92();
         var _loc3_:Object = obf_P_e_2948.getGenieBaseApt(param1.genieCode);
         txtPhysicsAttackApt.text = _loc3_.physicsAttack + param1.physicsAttackAptAdded + "";
         txtPhysicsDefApt.text = _loc3_.physicsDef + param1.physicsDefenseAptAdded + "";
         txtMagicAttackApt.text = _loc3_.magicAttack + param1.magicAttackAptAdded + "";
         txtMagicDefApt.text = _loc3_.magicDef + param1.magicDefenseAptAdded + "";
         txtLifeApt.text = _loc3_.life + param1.lifeAptAdded + "";
         txtCureApt.text = _loc3_.cure + param1.cureAptAdded + "";
         var _loc4_:int = obf_P_e_2948.getGenieLevelAptAdded(param1.level);
         txtLevelPhysicsAttackApt.text = "+" + _loc4_;
         txtLevelPhysicsDefApt.text = "+" + _loc4_;
         txtLevelMagicAttackApt.text = "+" + _loc4_;
         txtLevelMagicDefApt.text = "+" + _loc4_;
         txtLevelLifeApt.text = "+" + _loc4_;
         txtLevelCureApt.text = "+" + _loc4_;
         var _loc5_:Object = obf_P_e_2948.getGenieFinalApt(param1 as ItemPlayerGenieInfo,param1.genieCode);
         var _loc6_:Number = WorldConfig.getCoefficient("genie");
         if(_loc6_ <= 0)
         {
            _loc6_ = 1;
         }
         txtResultPhysicsAttack.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.physicsAttack) * 100 * _loc6_).toFixed(1) + "%";
         txtResultPhysicsDef.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.physicsDef) * 100 * _loc6_).toFixed(1) + "%";
         txtResultMagicAttack.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.magicAttack) * 100 * _loc6_).toFixed(1) + "%";
         txtResultMagicDef.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.magicDef) * 100 * _loc6_).toFixed(1) + "%";
         txtResultLife.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.life) * 100 * _loc6_).toFixed(1) + "%";
         txtResultCure.text = "+" + (obf_P_e_2948.getGenieAptBuffRate(_loc5_.cure) * 100 * _loc6_).toFixed(1) + "%";
         var _loc7_:String = JSONUtil.getStr(_loc2_,["properties","upgradeGenieCode"]);
         if(obf_L_l_4100.isEmpty(_loc7_))
         {
            return;
         }
         this.upgradeGenieView = new obf_Z_L_1552(_loc7_);
         this.upgradeGenieView.moveToPixel(0,0);
         pointUpgradeView.addChild(this.upgradeGenieView);
         var _loc8_:Object = obf_P_e_2948.getGenieBaseApt(_loc7_);
         txtUpgradePhysicsAttackApt.text = _loc8_.physicsAttack + "";
         txtUpgradePhysicsDefApt.text = _loc8_.physicsDef + "";
         txtUpgradeMagicAttackApt.text = _loc8_.magicAttack + "";
         txtUpgradeMagicDefApt.text = _loc8_.magicDef + "";
         txtUpgradeLifeApt.text = _loc8_.life + "";
         txtUpgradeCureApt.text = _loc8_.cure + "";
         var _loc9_:Object = JSONUtil.getObject(_loc2_,["properties","upgradeCondition"]);
         if(JSONUtil.getInt(_loc9_,["gold>="]) > 0)
         {
            pointUnsealGold.addChild(obf_a_f_2935.getGoldDisplay(JSONUtil.getInt(_loc9_,["gold>="])));
         }
         if(JSONUtil.getInt(_loc9_,["sp>="]) > 0)
         {
            txtUnsealSp.text = JSONUtil.getInt(_loc9_,["sp>="]) + "";
         }
         var _loc10_:Object = JSONUtil.getObject(_loc9_,["equalItemsInBag"]);
         if(_loc10_)
         {
            _loc11_ = 0;
            for(_loc12_ in _loc10_)
            {
               if(_loc11_ >= this.obf_o_D_3154.length)
               {
                  break;
               }
               _loc13_ = this.obf_o_D_3154[_loc11_];
               _loc13_.dropIconItem();
               _loc11_++;
               _loc14_ = IconItemManager.getIconItemByCode(_loc12_,"");
               if(_loc14_)
               {
                  _loc14_.itemCount = _loc10_[_loc12_];
                  _loc13_.pushIconItem(_loc14_);
               }
            }
         }
         this.obf_B_F_3224();
      }
      
      public function obf_0_4_L_436() : void
      {
         var _loc1_:IconItemBag = null;
         this.obf_a_V_3165 = null;
         if(this.genieView)
         {
            pointGenieView.removeChild(this.genieView);
            this.genieView.destroy();
            this.genieView = null;
         }
         if(this.upgradeGenieView)
         {
            pointUpgradeView.removeChild(this.upgradeGenieView);
            this.upgradeGenieView.destroy();
            this.upgradeGenieView = null;
         }
         txtGenieName.text = "";
         txtGenieLevel.text = "";
         txtGenieExp.text = "";
         txtLevelUpSp.text = "";
         barGenieExp.gotoAndStop(1);
         txtResultPhysicsAttack.text = "";
         txtResultPhysicsDef.text = "";
         txtResultMagicAttack.text = "";
         txtResultMagicDef.text = "";
         txtResultLife.text = "";
         txtResultCure.text = "";
         txtPhysicsAttackApt.text = "";
         txtLevelPhysicsAttackApt.text = "";
         txtPhysicsDefApt.text = "";
         txtLevelPhysicsDefApt.text = "";
         txtMagicAttackApt.text = "";
         txtLevelMagicAttackApt.text = "";
         txtMagicDefApt.text = "";
         txtLevelMagicDefApt.text = "";
         txtLifeApt.text = "";
         txtLevelLifeApt.text = "";
         txtCureApt.text = "";
         txtLevelCureApt.text = "";
         txtUpgradePhysicsAttackApt.text = "";
         txtUpgradePhysicsDefApt.text = "";
         txtUpgradeMagicAttackApt.text = "";
         txtUpgradeMagicDefApt.text = "";
         txtUpgradeLifeApt.text = "";
         txtUpgradeCureApt.text = "";
         txtUnsealSp.text = "";
         txtGenieUnseal.text = "";
         barGenieUnseal.gotoAndStop(1);
         while(pointUnsealGold.numChildren > 0)
         {
            pointUnsealGold.removeChildAt(0);
         }
         for each(_loc1_ in this.obf_o_D_3154)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function getGenieBagById(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.genieBags)
         {
            if(!(_loc2_.isLocked || !_loc2_.haveIconItem))
            {
               if(_loc2_.haveIconItem.itemId == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.genieBags)
         {
            if(!_loc3_.isLocked)
            {
               if(_loc3_.haveIconItem == null)
               {
                  if(++_loc2_ >= param1)
                  {
                     return true;
                  }
               }
            }
         }
         return _loc2_ >= param1;
      }
      
      public function hasAnyItem(param1:Array) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.genieBags.length)
         {
            _loc3_ = this.genieBags[_loc2_];
            if(Boolean(_loc3_.haveIconItem) && param1.indexOf(_loc3_.haveIconItem.itemCode) > -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getItemCount(param1:String) : int
      {
         var _loc4_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.genieBags.length)
         {
            _loc4_ = this.genieBags[_loc3_];
            if(Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem.itemCode == param1)
            {
               _loc2_ += _loc4_.haveIconItem.itemCount;
            }
            _loc3_++;
         }
         return _loc2_;
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
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(!param1.haveIconItem)
         {
            return;
         }
         if(this.obf_X_D_1983 != param1.haveIconItem.itemId)
         {
            this.obf_V_s_2623 = param1.haveIconItem.itemCode;
            this.obf_X_D_1983 = param1.haveIconItem.itemId;
            selectGenieBox.visible = true;
            selectGenieBox.x = param1.x;
            selectGenieBox.y = param1.y;
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(!param1.haveIconItem)
         {
            return;
         }
         obf_P_e_2948.sendSetUsingGenie(param1.haveIconItem.itemId);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3.parentIconUI == this)
         {
            if(GameContext.bagItemManager)
            {
               GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.obf_5_R_2566);
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         var _loc4_:Object = null;
         if(param3 == null && Boolean(param1.haveIconItem))
         {
            _loc4_ = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
            if(_loc4_.dropMode == 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","cantDrop"));
            }
            else if(_loc4_.dropMode == 1)
            {
               GameContext.bagItemManager.sendDropItem(PlayerBagIndex.obf_5_R_2566,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY));
            }
            else if(_loc4_.dropMode == 2)
            {
               WindowManager.showConfirmBox(DiversityManager.getString("GenieBoxUI","prompt_ConfirmDropGenie"),this.confirmReleaseGenie,[PlayerBagIndex.obf_5_R_2566,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
            }
         }
      }
      
      public function confirmReleaseGenie(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendDropItem.apply(null,param1.par);
         }
      }
   }
}

