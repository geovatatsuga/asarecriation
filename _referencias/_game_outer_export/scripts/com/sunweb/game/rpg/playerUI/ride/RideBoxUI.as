package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.RideBoxUIMC;
   
   public class RideBoxUI extends RideBoxUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var allBags:Array;
      
      private var _rideBags:Array;
      
      private var _player:obf_Y_E_3667;
      
      private var rideFoodBag:IconItemBag;
      
      private var rideMaterialBags:Array;
      
      private var obf_D_9_3842:String;
      
      private var obf_X_A_1222:String;
      
      private var obf_L_v_4211:GameItemFullInfo;
      
      private var _currentRideAssConfig:Object;
      
      private var bagsBox:Array;
      
      private var _noviceSprite:Sprite;
      
      private var pageNum:int = 1;
      
      private var pageTotle:int;
      
      private var bagSortTimeInv:TimeLimiter;
      
      private var infoTimeInv:TimeLimiter;
      
      public function RideBoxUI()
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:MovieClip = null;
         var _loc7_:IconItemBag = null;
         this.bagsBox = new Array();
         this.infoTimeInv = new TimeLimiter(300);
         super();
         this.initDiversity();
         this.y = GameContext.gameStage.stageHeight / 2;
         this.x = GameContext.gameStage.stageWidth - 300;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtRideAssChanse.visible = false;
         cmdRideFusion.enabled = WorldConfig.getValue("functionSwitch","rideFusion");
         rideDepot.visible = WorldConfig.getValue("functionSwitch","showRideDepot");
         barExp.gotoAndStop(1);
         this.allBags = new Array();
         this._rideBags = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= obf_0___z_209.getRideBagsNum / 8)
         {
            (this["rideBag" + _loc1_] as MovieClip).doubleClickEnabled = true;
            this.bagsBox.push(this["rideBag" + _loc1_]);
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               _loc4_ = this["rideBag" + _loc1_]["bag" + _loc3_];
               if(_loc4_ != null)
               {
                  _loc5_ = new IconItemBag(_loc4_,this,(_loc1_ - 1) * 8 + _loc3_);
                  _loc5_.isLocked = true;
                  _loc5_.addValidType(GameItemType.RIDE);
                  this._rideBags.push(_loc5_);
                  this.allBags.push(_loc5_);
               }
               _loc3_++;
            }
            _loc1_++;
         }
         this.rideMaterialBags = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc6_ = this["bagRideMaterial" + _loc2_];
            _loc7_ = new IconItemBag(_loc6_,this,_loc2_);
            _loc7_.lockDrag = true;
            _loc7_.addValidType(GameItemType.ALL);
            this.rideMaterialBags.push(_loc7_);
            this.allBags.push(_loc7_);
            _loc2_++;
         }
         this.rideFoodBag = new IconItemBag(barFood,this,0);
         this.rideFoodBag.addValidType(GameItemType.ALL);
         this.allBags.push(this.rideFoodBag);
         this.showPage(1);
         this.setChildIndex(selectedBox,this.numChildren - 1);
         selectedBox.mouseEnabled = false;
         selectedBox.visible = false;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RideBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyQuality,"RideBoxUI","txtRideQuality");
         DiversityManager.setTextField(txtDeyLevel,"RideBoxUI","txtRideLevel");
         DiversityManager.setTextField(txtDeyExp,"RideBoxUI","txtRideExp");
         DiversityManager.setTextField(txtDeyLifeApt,"RideBoxUI","txtRideLifeApt",null,true);
         DiversityManager.setTextField(txtDeyAttackApt,"RideBoxUI","txtRideAttackApt",null,true);
         DiversityManager.setTextField(txtDeyDefenseApt,"RideBoxUI","txtRideDefenseApt",null,true);
         DiversityManager.setTextField(txtDeyCureApt,"RideBoxUI","txtRideCureApt",null,true);
         DiversityManager.setTextField(txtDeySpeed,"RideBoxUI","txtRideSpeed");
         DiversityManager.setTextField(txtDeyLevelUp,"RideBoxUI","txtRideLevelUp");
         DiversityManager.setTextField(txtDeyAllAptUp,"RideBoxUI","txtRideAllAptUp");
         DiversityManager.setTextField(txtDeySpeedUp,"RideBoxUI","txtRideSpeedUp");
         DiversityManager.setTextField(txtDeyRideAss,"RideBoxUI","txtRideAss");
         DiversityManager.setTextField(txtDeyRideMaterial,"RideBoxUI","txtRideMaterial");
         DiversityManager.setTextField(txtDeyPrompt,"RideBoxUI","txtPrompt");
         cmdFood.label = DiversityManager.getString("RideBoxUI","cmdFood");
         cmdRideAss.label = DiversityManager.getString("RideBoxUI","cmdRideAss");
         cmdUp.label = DiversityManager.getString("RideBoxUI","cmdUp");
         cmdDown.label = DiversityManager.getString("RideBoxUI","cmdDown");
         cmdSort.label = DiversityManager.getString("RideBoxUI","cmdSort");
         cmdRideFusion.label = DiversityManager.getString("RideBoxUI","cmdRideFusion");
         rideDepot.label = DiversityManager.getString("RideBoxUI","rideDepot");
         rideEquip.label = DiversityManager.getString("RideBoxUI","rideEquip");
      }
      
      public function get obf_H_1999() : GameItemFullInfo
      {
         return this.obf_L_v_4211;
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
         return "RideBoxUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this[param1];
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height / 2);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      public function get selectedRideCode() : String
      {
         return this.obf_X_A_1222;
      }
      
      public function get selectedRideId() : String
      {
         return this.obf_D_9_3842;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdFood.addEventListener(MouseEvent.CLICK,this.obf_m_H_2003);
         cmdRideAss.addEventListener(MouseEvent.CLICK,this.obf_c_f_3000);
         cmdRideFusion.addEventListener(MouseEvent.CLICK,this.obf_z_O_3498);
         cmdAddLifeApt.addEventListener(MouseEvent.CLICK,this.get);
         cmdAddDefenseApt.addEventListener(MouseEvent.CLICK,this.get);
         cmdAddAttackApt.addEventListener(MouseEvent.CLICK,this.get);
         cmdAddCureApt.addEventListener(MouseEvent.CLICK,this.get);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdDown.addEventListener(MouseEvent.CLICK,this.obf_i_f_4732);
         cmdSort.addEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         rideDepot.addEventListener(MouseEvent.CLICK,this.obf_0___F_149);
         rideEquip.addEventListener(MouseEvent.CLICK,this.obf_O_Q_4066);
         obf_K_e_3075.addUIMouseToolTip(obf_Q_0_1896,"Luck_StarPrompt");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLifeApt,"Ride_LifeApt");
         obf_K_e_3075.addUIMouseToolTip(txtDeyDefenseApt,"Ride_DefenseApt");
         obf_K_e_3075.addUIMouseToolTip(txtDeyAttackApt,"Ride_AttackApt");
         obf_K_e_3075.addUIMouseToolTip(txtDeyCureApt,"Ride_CureApt");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdFood.removeEventListener(MouseEvent.CLICK,this.obf_m_H_2003);
         cmdRideAss.removeEventListener(MouseEvent.CLICK,this.obf_c_f_3000);
         cmdRideFusion.removeEventListener(MouseEvent.CLICK,this.obf_z_O_3498);
         cmdAddLifeApt.removeEventListener(MouseEvent.CLICK,this.get);
         cmdAddDefenseApt.removeEventListener(MouseEvent.CLICK,this.get);
         cmdAddAttackApt.removeEventListener(MouseEvent.CLICK,this.get);
         cmdAddCureApt.removeEventListener(MouseEvent.CLICK,this.get);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdDown.removeEventListener(MouseEvent.CLICK,this.obf_i_f_4732);
         cmdSort.removeEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         rideDepot.removeEventListener(MouseEvent.CLICK,this.obf_0___F_149);
         rideEquip.removeEventListener(MouseEvent.CLICK,this.obf_O_Q_4066);
         obf_K_e_3075.removeUIMouseToolTip(obf_Q_0_1896);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyLifeApt);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyDefenseApt);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyAttackApt);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyCureApt);
      }
      
      private function obf_e_s_3253(param1:Event) : void
      {
         --this.pageNum;
         if(this.pageNum <= 1)
         {
            this.pageNum = 1;
         }
         this.showPage(this.pageNum);
      }
      
      private function obf_i_f_4732(param1:Event) : void
      {
         ++this.pageNum;
         if(this.pageNum >= obf_0___z_209.getRideBagsNum / 8)
         {
            this.pageNum = obf_0___z_209.getRideBagsNum / 8;
         }
         this.showPage(this.pageNum);
      }
      
      private function showPage(param1:int) : void
      {
         var bagBox:MovieClip = null;
         var page:int = param1;
         this.obf_S_2_2619();
         this.pageTotle = obf_0___z_209.getRideBagsNum / 8;
         for each(bagBox in this.bagsBox)
         {
            try
            {
               this.removeChild(bagBox);
            }
            catch(e:Error)
            {
            }
         }
         this.addChild(this.bagsBox[page - 1]);
         DiversityManager.setTextField(txtPage,"RideBoxUI","prompt_CurrentPage",[page,this.pageTotle],true);
      }
      
      private function obf_a_z_1623(param1:Event) : void
      {
         GameContext.bagItemManager.sendSortBag(PlayerBagIndex.PLAYER_RIDE_BAG);
         cmdSort.enabled = false;
         this.bagSortTimeInv = new TimeLimiter(WorldConfig.obf_K_L_4278);
      }
      
      private function obf_0___F_149(param1:Event) : void
      {
         if(obf_K_e_3075.rideDepotUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.rideDepotUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.rideDepotUI);
            param1.stopPropagation();
         }
      }
      
      private function obf_O_Q_4066(param1:Event) : void
      {
         if(!this.obf_L_v_4211)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_X_A_1222);
         obf_K_e_3075.rideEquipUI.showModel(JSONUtil.getStr(_loc2_,["properties","modelCode"]));
         obf_K_e_3075.showUI(obf_K_e_3075.rideEquipUI);
      }
      
      private function obf_3_D_1854(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("LuckPrompt");
         _loc2_.addTipInfo(DiversityManager.getString("AssemblePrompt","luckStarPrompt"),150,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_v_B_1237(param1:Event) : void
      {
         GameTipManager.closeTip("LuckPrompt");
      }
      
      private function obf_m_H_2003(param1:Event) : void
      {
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_X_A_1222);
         if(!_loc2_ || obf_L_l_4100.isEmpty(this.obf_D_9_3842))
         {
            return;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(obf_0___z_209.rideFoodItemCode) < JSONUtil.getInt(_loc2_,["properties","qualityPoint"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(obf_0___z_209.rideFoodItemCode)]));
            return;
         }
         GameContext.localPlayer.sendAddRideExp(this.obf_D_9_3842,1);
      }
      
      private function obf_c_f_3000(param1:Event) : void
      {
         if(!this._currentRideAssConfig)
         {
            return;
         }
         if(!ConditionScript.checkCondition({"equalItemsInBag":this._currentRideAssConfig.baseItems},null,true))
         {
            return;
         }
         if(!ConditionScript.checkCondition(this._currentRideAssConfig.condition,null,true))
         {
            return;
         }
         obf_x_c_2855.sendAssemble("",null,this._currentRideAssConfig.ruleIndex,[],true);
      }
      
      private function obf_z_O_3498(param1:Event) : void
      {
         if(!this.obf_L_v_4211)
         {
            return;
         }
         if(GameItemManager.haveValidTime(this.obf_L_v_4211.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noFusion"));
            return;
         }
         obf_K_e_3075.rideFusionUI.obf_v_m_991(this.obf_L_v_4211.itemCode,this.obf_L_v_4211.itemId);
         obf_K_e_3075.showUI(obf_K_e_3075.rideFusionUI);
      }
      
      private function get(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_D_9_3842))
         {
            return;
         }
         if(param1.currentTarget == cmdAddLifeApt)
         {
            ButtonToItemManager.useBTIById("addRideLifeApt",{"rideId":this.obf_D_9_3842});
         }
         else if(param1.currentTarget == cmdAddAttackApt)
         {
            ButtonToItemManager.useBTIById("addRideAttackApt",{"rideId":this.obf_D_9_3842});
         }
         else if(param1.currentTarget == cmdAddDefenseApt)
         {
            ButtonToItemManager.useBTIById("addRideDefenseApt",{"rideId":this.obf_D_9_3842});
         }
         else if(param1.currentTarget == cmdAddCureApt)
         {
            ButtonToItemManager.useBTIById("addRideCureApt",{"rideId":this.obf_D_9_3842});
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.infoTimeInv.checkTimeout() && !this.obf_L_v_4211 && !obf_L_l_4100.isEmpty(this.obf_D_9_3842))
         {
            this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(this.obf_D_9_3842);
            if(this.obf_L_v_4211)
            {
               this.obf_a_Y_2069();
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(this.obf_D_9_3842);
            }
         }
         if(Boolean(this.bagSortTimeInv) && this.bagSortTimeInv.checkTimeout())
         {
            cmdSort.enabled = true;
            this.bagSortTimeInv = null;
         }
      }
      
      public function obf_a_Y_2069() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:IconItemBag = null;
         var _loc14_:IconItem = null;
         if(obf_L_l_4100.isEmpty(this.obf_D_9_3842) || obf_L_l_4100.isEmpty(this.obf_X_A_1222))
         {
            return;
         }
         this.obf_S_2_2619();
         this.setChildIndex(selectedBox,this.numChildren - 1);
         for each(_loc1_ in this._rideBags)
         {
            if(Boolean(_loc1_.haveIconItem) && _loc1_.haveIconItem.itemId == this.obf_D_9_3842)
            {
               selectedBox.x = _loc1_.x + (this.bagsBox[this.pageNum - 1] as MovieClip).x;
               selectedBox.y = _loc1_.y + (this.bagsBox[this.pageNum - 1] as MovieClip).y;
               selectedBox.visible = true;
               break;
            }
         }
         _loc2_ = GameItemManager.getItemConfig(this.obf_X_A_1222);
         if(!_loc2_ || !this.obf_L_v_4211)
         {
            return;
         }
         var _loc3_:Object = obf_0___z_209.getRideLevelConfig(this.obf_L_v_4211.rideInfo.level);
         if(!_loc3_)
         {
            return;
         }
         txtQuality.text = JSONUtil.getInt(_loc2_,["properties","qualityPoint"]) + "";
         txtLevel.text = this.obf_L_v_4211.rideInfo.level + "";
         txtExp.text = this.obf_L_v_4211.rideInfo.exp + "/" + JSONUtil.getInt(_loc3_,["levelUpExp"]);
         var _loc4_:int = this.obf_L_v_4211.rideInfo.exp / JSONUtil.getInt(_loc3_,["levelUpExp"]) * 100;
         barExp.gotoAndStop(_loc4_);
         txtLifeApt.text = obf_0___z_209.getAptValueAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_C_W_1491,this.obf_L_v_4211.rideInfo.lifeAptAdded) + "/" + obf_0___z_209.getMaxAptAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_C_W_1491);
         txtAttackApt.text = obf_0___z_209.getAptValueAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.ATTACK_APT,this.obf_L_v_4211.rideInfo.attackAptAdded) + "/" + obf_0___z_209.getMaxAptAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.ATTACK_APT);
         txtDefenseApt.text = obf_0___z_209.getAptValueAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_A_C_2113,this.obf_L_v_4211.rideInfo.defenseAptAdded) + "/" + obf_0___z_209.getMaxAptAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_A_C_2113);
         txtCureApt.text = obf_0___z_209.getAptValueAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_n_w_1135,this.obf_L_v_4211.rideInfo.cureAptAdded) + "/" + obf_0___z_209.getMaxAptAtLevel(this.obf_X_A_1222,this.obf_L_v_4211.rideInfo.level,obf_0___z_209.obf_n_w_1135);
         txtSpeed.text = this.obf_L_v_4211.rideInfo.rideSpeed + "";
         var _loc5_:Object = obf_0___z_209.getRideLevelConfig(this.obf_L_v_4211.rideInfo.level + 1);
         if(_loc5_)
         {
            txtAllAptUp.text = obf_A_x_3023.getRateString(JSONUtil.getNumber(_loc5_,["aptAddRate"]) - JSONUtil.getNumber(_loc3_,["aptAddRate"]));
            txtSpeedUp.text = JSONUtil.getInt(_loc5_,["speedAddValue"]) - JSONUtil.getInt(_loc3_,["speedAddValue"]) + "";
         }
         var _loc6_:IconItem = IconItemManager.getIconItemByCode(obf_0___z_209.rideFoodItemCode,"");
         if(_loc6_)
         {
            _loc6_.itemCount = JSONUtil.getInt(_loc2_,["properties","qualityPoint"]);
            this.rideFoodBag.pushIconItem(_loc6_);
         }
         this._currentRideAssConfig = obf_x_c_2855.getConfigInMaterialMap(this.obf_X_A_1222,0);
         var _loc7_:String = JSONUtil.getStr(this._currentRideAssConfig,["mainTargetItem"]);
         var _loc8_:Object = GameItemManager.getItemConfig(_loc7_);
         if((Boolean(_loc8_)) && Boolean(this._currentRideAssConfig))
         {
            this._player = new obf_Y_E_3667(GameContext.localPlayer.fullInfo.jobCode,GameContext.localPlayer.fullInfo.sex,GameContext.localPlayer.fullInfo.hairStyleIndex);
            this._player.setEquipmentModels(GameContext.localPlayer.getEquipmentModels());
            this._player.setRideModel(JSONUtil.getStr(_loc8_,["properties","modelCode"]));
            this._player.ride(true);
            this._player.moveToPixel(0,0);
            this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
            pointRideImage.addChild(this._player);
            obf_x_c_2855.setLuckBox(obf_x_c_2855.getAssembleLuck(this._currentRideAssConfig.ruleIndex),obf_Q_0_1896,false);
            obf_Q_0_1896.visible = true;
            _loc9_ = new Array();
            for(_loc10_ in this._currentRideAssConfig.baseItems)
            {
               if(_loc10_ != this.obf_X_A_1222)
               {
                  _loc9_.push(_loc10_);
               }
            }
            _loc9_.sort();
            _loc11_ = 0;
            while(_loc11_ < _loc9_.length && _loc11_ < this.rideMaterialBags.length)
            {
               _loc12_ = _loc9_[_loc11_];
               _loc13_ = this.rideMaterialBags[_loc11_];
               _loc14_ = IconItemManager.getIconItemByCode(_loc12_,"");
               if(Boolean(_loc13_) && Boolean(_loc14_))
               {
                  _loc14_.itemCount = this._currentRideAssConfig.baseItems[_loc12_];
                  _loc13_.dropIconItem();
                  _loc13_.pushIconItem(_loc14_);
               }
               _loc11_++;
            }
         }
      }
      
      public function obf_Y_a_3517() : void
      {
         if(!this.obf_L_v_4211)
         {
            return;
         }
         GameItemInfoManager.removeItemInfo(this.obf_L_v_4211.itemId);
         this.obf_L_v_4211 = null;
      }
      
      public function obf_S_2_2619() : void
      {
         var _loc1_:IconItemBag = null;
         txtQuality.text = "";
         txtLevel.text = "";
         txtExp.text = "";
         txtLifeApt.text = "";
         txtDefenseApt.text = "";
         txtAttackApt.text = "";
         txtCureApt.text = "";
         txtSpeed.text = "";
         txtAllAptUp.text = "";
         txtSpeedUp.text = "";
         txtRideAssChanse.text = "";
         obf_Q_0_1896.visible = false;
         selectedBox.visible = false;
         barExp.gotoAndStop(1);
         this.rideFoodBag.dropIconItem();
         for each(_loc1_ in this.rideMaterialBags)
         {
            _loc1_.dropIconItem();
         }
         if(this._player)
         {
            if(this._player.parent)
            {
               this._player.parent.removeChild(this._player);
            }
            this._player.destroy();
         }
      }
      
      public function obf_r_z_4549() : void
      {
         this._currentRideAssConfig = null;
         this.obf_X_A_1222 = "";
         this.obf_D_9_3842 = "";
         this.obf_L_v_4211 = null;
         selectedBox.visible = false;
         this.obf_S_2_2619();
      }
      
      public function obf_w_i_3412(param1:NpcAssembleItemAnswer) : void
      {
         if(Boolean(this._currentRideAssConfig) && this._currentRideAssConfig.ruleIndex == param1.assembleRuleIndex)
         {
            if(param1.isSucceeded)
            {
               WindowManager.showMessageBox(DiversityManager.getString("AssemblePrompt","assembleComplete"));
               obf_6_D_3816.print(DiversityManager.getString("AssemblePrompt","assembleComplete"));
               obf_x_c_2855.setAssembleLuck(param1.assembleRuleIndex,0);
               obf_x_c_2855.setLuckBox(0,obf_Q_0_1896);
               obf_q_6_3634.obf_e_J_1876("dzhao@fs9",1);
            }
            else
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("AssemblePrompt","assembleFail"),this,new Point(0,-100));
               obf_6_D_3816.print(DiversityManager.getString("AssemblePrompt","assembleFail"));
               obf_x_c_2855.setLuckBox(obf_x_c_2855.obf_0_2_6_666(param1.assembleRuleIndex),obf_Q_0_1896);
            }
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function get rideBags() : Array
      {
         return this._rideBags;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this._rideBags)
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
         while(_loc2_ < this._rideBags.length)
         {
            _loc3_ = this._rideBags[_loc2_];
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
         while(_loc3_ < this._rideBags.length)
         {
            _loc4_ = this._rideBags[_loc3_];
            if(Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem.itemCode == param1)
            {
               _loc2_ += _loc4_.haveIconItem.itemCount;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getEqualItemCount(param1:String) : int
      {
         var _loc5_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:String = GameItemManager.getItemConfig(param1).equalItem;
         var _loc4_:int = 0;
         while(_loc4_ < this._rideBags.length)
         {
            _loc5_ = this._rideBags[_loc4_];
            if(Boolean(_loc5_.haveIconItem) && (_loc5_.haveIconItem.itemCode == param1 || _loc5_.haveIconItem.itemCode == _loc3_))
            {
               _loc2_ += _loc5_.haveIconItem.itemCount;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getAllRide() : Array
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._rideBags.length)
         {
            _loc3_ = this._rideBags[_loc2_];
            if(_loc3_.haveIconItem)
            {
               _loc4_ = new Object();
               _loc4_.itemCode = _loc3_.haveIconItem.itemCode;
               _loc4_.itemId = _loc3_.haveIconItem.itemId;
               _loc1_.push(_loc4_);
            }
            _loc2_++;
         }
         return _loc1_;
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getIconItemBags() : Array
      {
         return this.allBags;
      }
      
      public function closeUI() : void
      {
         try
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         catch(e:Error)
         {
         }
         this.obf_r_z_4549();
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.allBags)
         {
            _loc1_.destroy();
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(this._rideBags.indexOf(param1) > -1)
         {
            if(param1.isLocked)
            {
               ButtonToItemManager.useBTIById("addRideBag");
            }
            if(param1.haveIconItem)
            {
               this.obf_X_A_1222 = param1.haveIconItem.itemCode;
               this.obf_D_9_3842 = param1.haveIconItem.itemId;
               this.obf_L_v_4211 = null;
               this.obf_a_Y_2069();
               if(obf_K_e_3075.rideEquipUI.visible)
               {
                  obf_K_e_3075.closeUI(obf_K_e_3075.rideEquipUI);
               }
            }
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(this._rideBags.indexOf(param1) > -1)
         {
            param1.useIconItem();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == param3)
         {
            return;
         }
         if(param1.isLocked || !param3.haveIconItem)
         {
            return;
         }
         if(param3.parentIconUI == this && this._rideBags.indexOf(param1) > -1)
         {
            if(GameContext.bagItemManager != null)
            {
               GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.PLAYER_RIDE_BAG);
            }
         }
         if(param1 == this.rideFoodBag && param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            this.rideFoodBag.dropIconItem();
            this.rideFoodBag.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         var _loc4_:Object = null;
         if(param3 == null && this._rideBags.indexOf(param1) > -1)
         {
            _loc4_ = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
            if(_loc4_.dropMode == 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","cantDrop"));
            }
            else if(_loc4_.dropMode == 1)
            {
               GameContext.bagItemManager.sendDropItem(PlayerBagIndex.PLAYER_RIDE_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY));
            }
            else if(_loc4_.dropMode == 2)
            {
               WindowManager.showConfirmBox(DiversityManager.getString("ItemPrompt","confirmDrop"),this.confirmDragItem,[PlayerBagIndex.PLAYER_RIDE_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
            }
         }
      }
      
      public function confirmDragItem(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendDropItem.apply(null,param1.par);
         }
      }
   }
}

