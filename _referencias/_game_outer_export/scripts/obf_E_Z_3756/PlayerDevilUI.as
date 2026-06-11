package obf_E_Z_3756
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_q_Z_3851;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerDevil.DevilFullInfo;
   import com.sunweb.game.rpg.playerDevil.ItemPlayerDevilInfo;
   import com.sunweb.game.rpg.playerDevil.obf_0_4_6_372;
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
   import playerUI.PlayerDevilBoxUIMC;
   
   public class PlayerDevilUI extends PlayerDevilBoxUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var devilBags:Array;
      
      private var obf_o_D_3154:Array;
      
      private var devilView:obf_q_Z_3851;
      
      private var upgradeDevilView:obf_q_Z_3851;
      
      private var obf_x_k_3927:DevilFullInfo;
      
      private var obf_Z_f_3945:String;
      
      private var obf_w_l_855:String;
      
      private var devilActionTimeInv:TimeLimiter;
      
      private var timeInv:TimeLimiter;
      
      public function PlayerDevilUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         this.devilActionTimeInv = new TimeLimiter(3000);
         this.timeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.onResize(null);
         this.visible = false;
         titleBox.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         selectGenieBox.mouseEnabled = false;
         selectGenieBox.visible = false;
         barGenieExp.gotoAndStop(1);
         barGenieUnseal.gotoAndStop(1);
         this.bags = new Array();
         this.devilBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc3_ = this["bag" + _loc1_];
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.addValidType(GameItemType.obf_y_n_2092);
               this.bags.push(_loc4_);
               this.devilBags.push(_loc4_);
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
      
      public function get obf_X_h_2915() : DevilFullInfo
      {
         return this.obf_x_k_3927;
      }
      
      public function getDevilBags() : Array
      {
         return this.devilBags;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
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
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
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
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function obf_x_1_1653(param1:Event) : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         if(param1.currentTarget == cmdPhysicsAttackApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddPhysicsAttackApt",{"devilId":this.obf_x_k_3927.devilId});
         }
         else if(param1.currentTarget == cmdPhysicsDefApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddPhysicsDefApt",{"devilId":this.obf_x_k_3927.devilId});
         }
         else if(param1.currentTarget == cmdMagicAttackApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddMagicAttackApt",{"devilId":this.obf_x_k_3927.devilId});
         }
         else if(param1.currentTarget == cmdMagicDefApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddMagicDefApt",{"devilId":this.obf_x_k_3927.devilId});
         }
         else if(param1.currentTarget == cmdLifeApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddLifeApt",{"devilId":this.obf_x_k_3927.devilId});
         }
         else if(param1.currentTarget == cmdCureApt)
         {
            ButtonToItemManager.useBTIById("Devil_AddCureApt",{"devilId":this.obf_x_k_3927.devilId});
         }
      }
      
      private function obf_l_2_2521(param1:Event) : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         obf_0_4_6_372.sendPlayerSetUsingDevilReq(this.obf_x_k_3927.devilId);
      }
      
      private function obf_T_g_3455(param1:Event) : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         obf_0_4_6_372.sendPlayerSetUsingDevilReq("");
      }
      
      private function onClickLevelUp(param1:Event) : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         if(this.obf_x_k_3927.exp < obf_0_4_6_372.getDevilLevelUpExp(this.obf_x_k_3927.level))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayerDevilUI","prompt_MustFullExpLevelUp"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.attributes.sp < obf_0_4_6_372.getDevilLevelUpSp(this.obf_x_k_3927.level))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayerDevilUI","prompt_NeedSp",[obf_0_4_6_372.getDevilLevelUpSp(this.obf_x_k_3927.level)]));
            return;
         }
         obf_0_4_6_372.sendPlayerDevilUpLevelReq(this.obf_x_k_3927.devilId);
      }
      
      private function obf_b_J_1235(param1:Event) : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_x_k_3927.devilCode);
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["properties","upgradeCondition"]);
         if(!_loc3_)
         {
            return;
         }
         ConditionScript.devilInfoForCondition = this.obf_x_k_3927;
         if(!ConditionScript.checkCondition(_loc3_,null,true))
         {
            return;
         }
         obf_0_4_6_372.sendPlayerDevilUpgradeReq(this.obf_x_k_3927.devilId);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:GameItemFullInfo = null;
         var _loc3_:int = 0;
         if(this.timeInv.checkTimeout() && !obf_L_l_4100.isEmpty(this.obf_w_l_855))
         {
            if(!this.obf_x_k_3927 || this.obf_x_k_3927.devilId != this.obf_w_l_855)
            {
               _loc2_ = GameItemInfoManager.getItemInfo(this.obf_w_l_855);
               if(!_loc2_)
               {
                  GameContext.bagItemManager.sendViewItem(this.obf_w_l_855);
               }
               else if(!_loc2_.isEmpty && Boolean(_loc2_.devilInfo))
               {
                  this.showDevilInfo(obf_0_4_6_372.itemFullInfoToDevilFullInfo(_loc2_));
               }
            }
         }
         if(this.devilActionTimeInv.checkTimeout())
         {
            _loc3_ = Math.random() * 9 - 1;
            if(this.devilView)
            {
               this.devilView.onUpdate();
               this.devilView.doAction(obf_S_c_3330.obf_h_4_3537,_loc3_,true);
            }
            if(this.upgradeDevilView)
            {
               this.upgradeDevilView.onUpdate();
               this.upgradeDevilView.doAction(obf_S_c_3330.obf_h_4_3537,_loc3_,true);
            }
         }
      }
      
      public function obf_E_O_2743() : void
      {
         if(this.getDevilBagById(this.obf_w_l_855) == null)
         {
            this.obf_Z_f_3945 = "";
            this.obf_w_l_855 = "";
            this.obf_u_A_2411();
         }
      }
      
      public function obf_4_i_3109() : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         txtGenieExp.text = this.obf_x_k_3927.exp + "/" + obf_0_4_6_372.getDevilLevelUpExp(this.obf_x_k_3927.level);
         var _loc1_:int = this.obf_x_k_3927.exp / obf_0_4_6_372.getDevilLevelUpExp(this.obf_x_k_3927.level) * 100;
         barGenieExp.gotoAndStop(_loc1_);
      }
      
      public function obf_d_4_1516() : void
      {
         if(!this.obf_x_k_3927)
         {
            return;
         }
         txtGenieUnseal.text = this.obf_x_k_3927.upgradeRate + "%";
         barGenieUnseal.gotoAndStop(this.obf_x_k_3927.upgradeRate);
      }
      
      public function showDevilInfo(param1:DevilFullInfo) : void
      {
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:IconItemBag = null;
         var _loc14_:IconItem = null;
         this.obf_u_A_2411();
         this.obf_x_k_3927 = param1;
         var _loc2_:Object = GameItemManager.getItemConfig(param1.devilCode);
         if(!_loc2_)
         {
            return;
         }
         this.devilView = new obf_q_Z_3851(param1.devilCode);
         this.devilView.moveToPixel(0,0);
         pointGenieView.addChild(this.devilView);
         txtGenieName.text = GameItemManager.getItemName(param1.devilCode);
         DiversityManager.setTextField(txtGenieLevel,"PlayerDevilUI","txtGenieLevelNumber",[param1.level,JSONUtil.getInt(_loc2_,["properties","maxLevel"])]);
         txtLevelUpSp.text = obf_0_4_6_372.getDevilLevelUpSp(param1.level) + "";
         this.obf_4_i_3109();
         var _loc3_:Object = obf_0_4_6_372.getDevilBaseApt(param1.devilCode);
         txtPhysicsAttackApt.text = _loc3_.physicsAttack + param1.physicsAttackAptAdded + "";
         txtPhysicsDefApt.text = _loc3_.physicsDef + param1.physicsDefenseAptAdded + "";
         txtMagicAttackApt.text = _loc3_.magicAttack + param1.magicAttackAptAdded + "";
         txtMagicDefApt.text = _loc3_.magicDef + param1.magicDefenseAptAdded + "";
         txtLifeApt.text = _loc3_.life + param1.lifeAptAdded + "";
         txtCureApt.text = _loc3_.cure + param1.cureAptAdded + "";
         var _loc4_:int = obf_0_4_6_372.getDevilLevelAptAdded(param1.level);
         txtLevelPhysicsAttackApt.text = "+" + _loc4_;
         txtLevelPhysicsDefApt.text = "+" + _loc4_;
         txtLevelMagicAttackApt.text = "+" + _loc4_;
         txtLevelMagicDefApt.text = "+" + _loc4_;
         txtLevelLifeApt.text = "+" + _loc4_;
         txtLevelCureApt.text = "+" + _loc4_;
         var _loc5_:Object = obf_0_4_6_372.getDevilFinalApt(param1 as ItemPlayerDevilInfo,param1.devilCode);
         var _loc6_:Number = WorldConfig.getCoefficient("devil");
         if(_loc6_ <= 0)
         {
            _loc6_ = 1;
         }
         txtResultPhysicsAttack.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.physicsAttack) * 100 * _loc6_).toFixed(1) + "%";
         txtResultPhysicsDef.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.physicsDef) * 100 * _loc6_).toFixed(1) + "%";
         txtResultMagicAttack.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.magicAttack) * 100 * _loc6_).toFixed(1) + "%";
         txtResultMagicDef.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.magicDef) * 100 * _loc6_).toFixed(1) + "%";
         txtResultLife.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.life) * 100 * _loc6_).toFixed(1) + "%";
         txtResultCure.text = "+" + (obf_0_4_6_372.getDevilAptBuffRate(_loc5_.cure) * 100 * _loc6_).toFixed(1) + "%";
         var _loc7_:String = JSONUtil.getStr(_loc2_,["properties","upgradeGenieCode"]);
         if(obf_L_l_4100.isEmpty(_loc7_))
         {
            return;
         }
         this.upgradeDevilView = new obf_q_Z_3851(_loc7_);
         this.upgradeDevilView.moveToPixel(0,0);
         pointUpgradeView.addChild(this.upgradeDevilView);
         var _loc8_:Object = obf_0_4_6_372.getDevilBaseApt(_loc7_);
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
         this.obf_d_4_1516();
      }
      
      public function obf_u_A_2411() : void
      {
         var _loc1_:IconItemBag = null;
         this.obf_x_k_3927 = null;
         if(this.devilView)
         {
            pointGenieView.removeChild(this.devilView);
            this.devilView.destroy();
            this.devilView = null;
         }
         if(this.upgradeDevilView)
         {
            pointUpgradeView.removeChild(this.upgradeDevilView);
            this.upgradeDevilView.destroy();
            this.upgradeDevilView = null;
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
      
      public function getDevilBagById(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.devilBags)
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
         for each(_loc3_ in this.devilBags)
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
         while(_loc2_ < this.devilBags.length)
         {
            _loc3_ = this.devilBags[_loc2_];
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
         while(_loc3_ < this.devilBags.length)
         {
            _loc4_ = this.devilBags[_loc3_];
            if(Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem.itemCode == param1)
            {
               _loc2_ += _loc4_.haveIconItem.itemCount;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(!param1.haveIconItem)
         {
            return;
         }
         if(this.obf_w_l_855 != param1.haveIconItem.itemId)
         {
            this.obf_Z_f_3945 = param1.haveIconItem.itemCode;
            this.obf_w_l_855 = param1.haveIconItem.itemId;
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
         obf_0_4_6_372.sendPlayerSetUsingDevilReq(param1.haveIconItem.itemId);
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
               GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.obf_w_y_3760);
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
               GameContext.bagItemManager.sendDropItem(PlayerBagIndex.obf_w_y_3760,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY));
            }
            else if(_loc4_.dropMode == 2)
            {
               WindowManager.showConfirmBox(DiversityManager.getString("PlayerDevilUI","prompt_ConfirmDropGenie"),this.confirmReleaseDevil,[PlayerBagIndex.obf_w_y_3760,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
            }
         }
      }
      
      public function confirmReleaseDevil(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendDropItem.apply(null,param1.par);
         }
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
         return 0;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this.txtDeyTitle,"PlayerDevilUI","txtTitle");
         DiversityManager.setTextField(txtDeyGenieName,"PlayerDevilUI","txtGenieName");
         DiversityManager.setTextField(txtDeyGenieLevel,"PlayerDevilUI","txtGenieLevel");
         DiversityManager.setTextField(txtDeyGenieExp,"PlayerDevilUI","txtGenieExp");
         DiversityManager.setTextField(txtDeyLevelUpSp,"PlayerDevilUI","txtLevelUpSp");
         DiversityManager.setTextField(txtDeyResult,"PlayerDevilUI","txtResult");
         DiversityManager.setTextField(txtDeyResultPhysicsAttack,"PlayerDevilUI","txtResultPhysicsAttack");
         DiversityManager.setTextField(txtDeyResultMagicAttack,"PlayerDevilUI","txtResultMagicAttack");
         DiversityManager.setTextField(txtDeyResultPhysicsDef,"PlayerDevilUI","txtResultPhysicsDef");
         DiversityManager.setTextField(txtDeyResultMagicDef,"PlayerDevilUI","txtResultMagicDef");
         DiversityManager.setTextField(txtDeyResultLife,"PlayerDevilUI","txtResultLife");
         DiversityManager.setTextField(txtDeyResultCure,"PlayerDevilUI","txtResultCure");
         DiversityManager.setTextField(txtDeySelfApt,"PlayerDevilUI","txtSelfApt");
         DiversityManager.setTextField(txtDeyLevelApt,"PlayerDevilUI","txtLevelApt");
         DiversityManager.setTextField(txtDeyPhysicsAttackApt,"PlayerDevilUI","txtPhysicsAttackApt");
         DiversityManager.setTextField(txtDeyMagicAttackApt,"PlayerDevilUI","txtMagicAttackApt");
         DiversityManager.setTextField(txtDeyPhysicsDefApt,"PlayerDevilUI","txtPhysicsDefApt");
         DiversityManager.setTextField(txtDeyMagicDefApt,"PlayerDevilUI","txtMagicDefApt");
         DiversityManager.setTextField(txtDeyLifeApt,"PlayerDevilUI","txtLifeApt");
         DiversityManager.setTextField(txtDeyCureApt,"PlayerDevilUI","txtCureApt");
         DiversityManager.setTextField(txtDeyGenieUpgrade,"PlayerDevilUI","txtGenieUpgrade");
         DiversityManager.setTextField(txtDeyUpgradeSelfApt,"PlayerDevilUI","txtUpgradeSelfApt");
         DiversityManager.setTextField(txtDeyUpgradePhysicsAttackApt,"PlayerDevilUI","txtUpgradePhysicsAttackApt");
         DiversityManager.setTextField(txtDeyUpgradeMagicAttackApt,"PlayerDevilUI","txtUpgradeMagicAttackApt");
         DiversityManager.setTextField(txtDeyUpgradePhysicsDefApt,"PlayerDevilUI","txtUpgradePhysicsDefApt");
         DiversityManager.setTextField(txtDeyUpgradeMagicDefApt,"PlayerDevilUI","txtUpgradeMagicDefApt");
         DiversityManager.setTextField(txtDeyUpgradeLifeApt,"PlayerDevilUI","txtUpgradeLifeApt");
         DiversityManager.setTextField(txtDeyUpgradeCureApt,"PlayerDevilUI","txtUpgradeCureApt");
         DiversityManager.setTextField(txtDeyGenieUnseal,"PlayerDevilUI","txtGenieUnseal");
         DiversityManager.setTextField(txtDeyUnsealGold,"PlayerDevilUI","txtUnsealGold");
         DiversityManager.setTextField(txtDeyUnsealSp,"PlayerDevilUI","txtUnsealSp");
         DiversityManager.setTextField(txtDeyUnsealRemark,"PlayerDevilUI","txtUnsealRemark");
         cmdUse.label = DiversityManager.getString("PlayerDevilUI","cmdUse");
         cmdBack.label = DiversityManager.getString("PlayerDevilUI","cmdBack");
         cmdGenieLevelUp.label = DiversityManager.getString("PlayerDevilUI","cmdGenieLevelUp");
         cmdGenieUnseal.label = DiversityManager.getString("PlayerDevilUI","cmdGenieUnseal");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
   }
}

