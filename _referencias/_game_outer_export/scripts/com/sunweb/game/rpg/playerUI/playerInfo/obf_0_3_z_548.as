package com.sunweb.game.rpg.playerUI.playerInfo
{
   import obf_E_p_2386.obf_S_Q_3707;
   import obf_x_O_4078.obf_1_t_884;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equ.EquippedItemInfo;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.RideBriefInfo;
   import com.sunweb.game.rpg.role.LocalPlayerInfo;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.PlayerFullInfoUIMC;
   
   public class obf_0_3_z_548 extends PlayerFullInfoUIMC implements IPlayerUI, IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var bagKind:Object;
      
      private var bagSkill:Array;
      
      private var showFationMode:Boolean = true;
      
      private var rideBag:IconItemBag;
      
      private var rideInfo:GameItemFullInfo;
      
      private var equipItemsInfo:Object;
      
      private var strAdded:int;
      
      private var agiAdded:int;
      
      private var wisAdded:int;
      
      private var vitAdded:int;
      
      private var freeAttrPoint:int;
      
      private var totlePoint:int;
      
      private var _noviceSprite:Sprite;
      
      private var getEquipItemInfoTimeInv:TimeLimiter;
      
      private var isWaitEquInfoToView:Boolean;
      
      private var obf_0_2_X_583:TimeLimiter;
      
      public function obf_0_3_z_548()
      {
         var _loc2_:IconItemBag = null;
         this.bagSkill = new Array();
         this.getEquipItemInfoTimeInv = new TimeLimiter(500);
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         cmdArenaPlace.visible = false;
         cmdFateSkill.visible = !WorldConfig.getValue("functionSwitch","fateSkill");
         txtDeyFateSkill.visible = cmdFateSkill.visible;
         cmdSuccess.visible = !WorldConfig.getValue("functionSwitch","achievement");
         cmdPointAuto.visible = !WorldConfig.getValue("functionSwitch","fastRoleAttrPoint");
         txtDeyCharmInt.visible = txtCharmInt.visible = txtDeyCharmValue.visible = txtCharmValue.visible = !WorldConfig.getValue("functionSwitch","blessGod");
         this.visible = false;
         this.bags = new Array();
         this.bagKind = new Object();
         this.equipItemsInfo = new Object();
         var _loc1_:Array = [[bagWeapon,EquipmentKind.WEAPON],[bagShield,EquipmentKind.SHIELD],[bagClothes,EquipmentKind.CLOTHES],[bagHat,EquipmentKind.HAT],[bagWing,EquipmentKind.WING],[bagShoes,EquipmentKind.SHOES],[bagGlove,EquipmentKind.GLOVE],[bagRing,EquipmentKind.RING],[bagAmulet,EquipmentKind.AMULET],[bagMedal,EquipmentKind.obf_s_Y_1219],[bagSoul,EquipmentKind.obf_m_S_4609],[bagFashionClothes,EquipmentKind.FASHION_CLOTHES],[bagFashionHat,EquipmentKind.FASHION_HAT],[bagBanner,EquipmentKind.obf_8_L_1856],[bagCloak,EquipmentKind.obf_i_3_4546]];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new IconItemBag(_loc1_[_loc3_][0],this,_loc3_,_loc1_[_loc3_][1] + "");
            _loc2_.addValidType(GameItemType.EQUIPMENT);
            this.bags.push(_loc2_);
            this.bagKind[_loc1_[_loc3_][1] + ""] = _loc2_;
            _loc3_++;
         }
         this.rideBag = new IconItemBag(this.bagRide,this,0);
         this.rideBag.addValidType(GameItemType.RIDE);
         this.rideBag.lockDrag = true;
         this.bags.push(this.rideBag);
         expBar.gotoAndStop(100);
         obf_N_L_4045.gotoAndStop(100);
         cmdEquKindGrow.visible = WorldConfig.getValue("functionSwitch","showEquKindGrow");
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyEquipSoul,"RoleUI","txtSoul");
         DiversityManager.setTextField(txtDeyEquipAmulet,"RoleUI","txtAmulet");
         DiversityManager.setTextField(txtDeyEquipRing,"RoleUI","txtRing");
         DiversityManager.setTextField(txtDeyEquipWing,"RoleUI","txtWing");
         DiversityManager.setTextField(txtDeyEquipMedal,"RoleUI","txtMedal");
         DiversityManager.setTextField(txtDeyEquipRide,"RoleUI","txtRide");
         DiversityManager.setTextField(txtDeyEquipHat,"RoleUI","txtHat");
         DiversityManager.setTextField(txtDeyEquipWeapon,"RoleUI","txtWeapon");
         DiversityManager.setTextField(txtDeyEquipShield,"RoleUI","txtShield");
         DiversityManager.setTextField(txtDeyEquipClothes,"RoleUI","txtClothes");
         DiversityManager.setTextField(txtDeyEquipGlove,"RoleUI","txtGlove");
         DiversityManager.setTextField(txtDeyEquipShoes,"RoleUI","txtShoes");
         DiversityManager.setTextField(txtDeyEquipFashionClothes,"RoleUI","txtFashionClothes");
         DiversityManager.setTextField(txtDeyEquipFashionHat,"RoleUI","txtFashionHat");
         DiversityManager.setTextField(txtDeyEquipBanner,"RoleUI","txtBanner");
         DiversityManager.setTextField(txtDeyEquipCloak,"RoleUI","txtCloak");
         DiversityManager.setTextField(txtDeyPlayerTitle,"RoleUI","txtPlayerTitle");
         DiversityManager.setTextField(txtDeyLevel,"RoleUI","txtLevel");
         DiversityManager.setTextField(txtDeyExp,"RoleUI","txtExp");
         DiversityManager.setTextField(txtDeyJob,"RoleUI","txtJob");
         DiversityManager.setTextField(txtDeyState,"RoleUI","txtState");
         DiversityManager.setTextField(txtDeyRank,"RoleUI","txtRank");
         DiversityManager.setTextField(txtDeyPrestige,"RoleUI","txtPrestige");
         DiversityManager.setTextField(txtDeyGild,"RoleUI","txtGild");
         DiversityManager.setTextField(txtDeyPK,"RoleUI","txtPK");
         DiversityManager.setTextField(txtDeyHp,"RoleUI","txtHP");
         DiversityManager.setTextField(txtDeyMp,"RoleUI","txtMP");
         DiversityManager.setTextField(txtDeySp,"RoleUI","txtSP");
         DiversityManager.setTextField(txtDeyCharmInt,"RoleUI","txtCharmInt");
         DiversityManager.setTextField(txtDeyCharmValue,"RoleUI","txtCharmValue");
         DiversityManager.setTextField(txtDeyStrength,"RoleUI","txtStrength",null,true);
         DiversityManager.setTextField(txtDeyAgility,"RoleUI","txtAgility",null,true);
         DiversityManager.setTextField(txtDeyIntellect,"RoleUI","txtIntellect",null,true);
         DiversityManager.setTextField(txtDeyStamina,"RoleUI","txtStamina",null,true);
         DiversityManager.setTextField(txtDeyPhysicalAttack,"RoleUI","txtPhysicalAttack",null,true);
         DiversityManager.setTextField(txtDeyMagicAttack,"RoleUI","txtMagicAttack",null,true);
         DiversityManager.setTextField(txtDeyCure,"RoleUI","txtCure",null,true);
         DiversityManager.setTextField(txtDeyPhysicalDefense,"RoleUI","txtPhysicalDefense",null,true);
         DiversityManager.setTextField(txtDeyMagicDefense,"RoleUI","txtMagicDefense",null,true);
         DiversityManager.setTextField(txtDeyAccuracy,"RoleUI","txtAccuracy",null,true);
         DiversityManager.setTextField(txtDeyDodge,"RoleUI","txtDodge",null,true);
         DiversityManager.setTextField(txtDeyCrit,"RoleUI","txtCrit",null,true);
         DiversityManager.setTextField(txtDeyAttrPoint,"RoleUI","txtAttrPoint",null,true);
         DiversityManager.setTextField(txtDeyLuck,"RoleUI","txtLuck",null,true);
         DiversityManager.setTextField(txtDeyLuckDefense,"RoleUI","txtLuckDefense",null,true);
         DiversityManager.setTextField(txtDeyCritDamage,"RoleUI","txtCritDamage",null,true);
         DiversityManager.setTextField(txtDeyCritDefense,"RoleUI","txtCritDefense",null,true);
         DiversityManager.setTextField(txtDeyPierceAttack,"RoleUI","txtPierceAttack",null,true);
         DiversityManager.setTextField(txtDeyPierceDefense,"RoleUI","txtPierceDefense",null,true);
         DiversityManager.setTextField(txtDeyHpHeal,"RoleUI","txtHpHeal",null,true);
         DiversityManager.setTextField(txtDeyMpHeal,"RoleUI","txtMpHeal",null,true);
         DiversityManager.setTextField(txtDeyAttackSpeed,"RoleUI","txtAttackSpeed",null,true);
         DiversityManager.setTextField(txtDeySingSpeed,"RoleUI","txtSingSpeed",null,true);
         DiversityManager.setTextField(txtDeyWalkSpeed,"RoleUI","txtWalkSpeed",null,true);
         DiversityManager.setTextField(txtDeyLOT,"RoleUI","1",null,true);
         DiversityManager.setTextField(txtDeyLOA,"RoleUI","2",null,true);
         DiversityManager.setTextField(txtDeyLOH,"RoleUI","3",null,true);
         DiversityManager.setTextField(txtDeyFateSkill,"RoleUI","cmdFateSkill");
         chkShowFashion.label = DiversityManager.getString("RoleUI","chkShowFashion");
         cmdPointOK.label = DiversityManager.getString("RoleUI","cmdPointOK");
         cmdPlayerTitle.label = DiversityManager.getString("RoleUI","cmdSelectTitle");
         cmdHonorPrompt.label = DiversityManager.getString("RoleUI","cmdHonorPrompt");
         cmdPointAuto.label = DiversityManager.getString("RoleUI","cmdPointAuto");
         cmdSuccess.label = DiversityManager.getString("RoleUI","cmdAchievements");
         cmdEquKindGrow.label = DiversityManager.getString("ControlBarUI","cmdEquKindGrow");
         DiversityManager.setTextField(txtDeyMaxLevel,"RoleUI","txtMaxLevel");
         DiversityManager.setTextField(txtDeyArena,"RoleUI","");
         DiversityManager.setTextField(txtDeyArenaPlace,"RoleUI","");
      }
      
      public function get equipBags() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKind)
         {
            if(this.bagKind[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKind[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public function get equipInfo() : Object
      {
         return this.equipItemsInfo;
      }
      
      public function getEquipBagByKind(param1:int) : IconItemBag
      {
         return JSONUtil.getObject(this.bagKind,[param1]) as IconItemBag;
      }
      
      public function getEquipItemInfo(param1:int) : GameItemFullInfo
      {
         return this.equipItemsInfo[param1];
      }
      
      public function getEquipItemInfoByCode(param1:String) : GameItemFullInfo
      {
         var _loc2_:String = null;
         var _loc3_:GameItemFullInfo = null;
         for(_loc2_ in this.equipItemsInfo)
         {
            _loc3_ = this.equipItemsInfo[_loc2_];
            if(Boolean(_loc3_) && _loc3_.itemCode == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getEquipRideInfo() : GameItemFullInfo
      {
         return this.rideInfo;
      }
      
      public function getRideBag() : IconItemBag
      {
         return this.rideBag;
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
         return "RoleUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:IconItemBag = null;
         for each(_loc3_ in this.bags)
         {
            if(Boolean(_loc3_.haveIconItem) && _loc3_.haveIconItem.itemCode == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x + 16,_loc2_.y + 16);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.bags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return this[param1];
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdPointOK.addEventListener(MouseEvent.CLICK,this.onAssignAttrPoint);
         cmdStrAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdStrAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdStrRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdAgiAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdAgiAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdAgiRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdWigAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdWisAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdWisRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdVitAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdVitAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdVitRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdPointAuto.addEventListener(MouseEvent.CLICK,this.obf_u_2_3167);
         cmdFateSkill.addEventListener(MouseEvent.CLICK,this.obf_r_e_737);
         cmdPlayerTitle.addEventListener(MouseEvent.CLICK,this.onOpenPlayerTitle);
         cmdSuccess.addEventListener(MouseEvent.CLICK,this.obf_W_y_1025);
         chkShowFashion.addEventListener(MouseEvent.CLICK,this.obf_i_B_1949);
         cmdEquKindGrow.addEventListener(MouseEvent.CLICK,this.obf_L_C_1850);
         obf_K_e_3075.addUIMouseToolTip(txtDeyStrength,"Role_Strength");
         obf_K_e_3075.addUIMouseToolTip(txtDeyAgility,"Role_Agility");
         obf_K_e_3075.addUIMouseToolTip(txtDeyIntellect,"Role_Intellect");
         obf_K_e_3075.addUIMouseToolTip(txtDeyStamina,"Role_Stamina");
         obf_K_e_3075.addUIMouseToolTip(txtDeyPhysicalAttack,"Role_PhysicalAttack");
         obf_K_e_3075.addUIMouseToolTip(txtDeyMagicAttack,"Role_MagicAttack");
         obf_K_e_3075.addUIMouseToolTip(txtDeyCure,"Role_Cure");
         obf_K_e_3075.addUIMouseToolTip(txtDeyPhysicalDefense,"Role_PhysicalDefense");
         obf_K_e_3075.addUIMouseToolTip(txtDeyMagicDefense,"Role_MagicDefense");
         obf_K_e_3075.addUIMouseToolTip(txtDeyAccuracy,"Role_Accuracy");
         obf_K_e_3075.addUIMouseToolTip(txtDeyDodge,"Role_Dodge");
         obf_K_e_3075.addUIMouseToolTip(txtDeyCrit,"Role_Crit");
         obf_K_e_3075.addUIMouseToolTip(cmdHonorPrompt,"Role_Honor");
         obf_K_e_3075.addUIMouseToolTip(txtDeySingSpeed,"Role_SingSpeed");
         obf_K_e_3075.addUIMouseToolTip(txtDeyAttackSpeed,"Role_AttackSpeed");
         obf_K_e_3075.addUIMouseToolTip(txtDeyWalkSpeed,"Role_WalkSpeed");
         obf_K_e_3075.addUIMouseToolTip(txtDeyHpHeal,"Role_HpHeal");
         obf_K_e_3075.addUIMouseToolTip(txtDeyMpHeal,"Role_MpHeal");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLuck,"Role_Luck");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLuckDefense,"Role_LuckDefense");
         obf_K_e_3075.addUIMouseToolTip(txtDeyCritDamage,"Role_CritDamage");
         obf_K_e_3075.addUIMouseToolTip(txtDeyCritDefense,"Role_CritDefense");
         obf_K_e_3075.addUIMouseToolTip(txtDeyPierceAttack,"Role_PierceAttack");
         obf_K_e_3075.addUIMouseToolTip(txtDeyPierceDefense,"Role_PierceDefense");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLOT,"Role_txtDeyLOT");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLOA,"Role_txtDeyLOA");
         obf_K_e_3075.addUIMouseToolTip(txtDeyLOH,"Role_txtDeyLOH");
         obf_K_e_3075.addUIMouseToolTip(txtLOT,"Role_txtLOT");
         obf_K_e_3075.addUIMouseToolTip(txtLOA,"Role_txtLOA");
         obf_K_e_3075.addUIMouseToolTip(txtLOH,"Role_txtLOH");
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdPointOK.removeEventListener(MouseEvent.CLICK,this.onAssignAttrPoint);
         cmdStrAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdStrAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdStrRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdAgiAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdAgiAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdAgiRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdWigAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdWisAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdWisRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdVitAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdVitAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdVitRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdPointAuto.removeEventListener(MouseEvent.CLICK,this.obf_u_2_3167);
         cmdFateSkill.removeEventListener(MouseEvent.CLICK,this.obf_r_e_737);
         cmdPlayerTitle.removeEventListener(MouseEvent.CLICK,this.onOpenPlayerTitle);
         cmdSuccess.removeEventListener(MouseEvent.CLICK,this.obf_W_y_1025);
         chkShowFashion.removeEventListener(MouseEvent.CLICK,this.obf_i_B_1949);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyStrength);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyAgility);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyIntellect);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyStamina);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyPhysicalAttack);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyMagicAttack);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyCure);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyPhysicalDefense);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyMagicDefense);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyAccuracy);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyDodge);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyCrit);
         obf_K_e_3075.removeUIMouseToolTip(cmdHonorPrompt);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyLOT);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyLOA);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyLOH);
         obf_K_e_3075.removeUIMouseToolTip(txtLOT);
         obf_K_e_3075.removeUIMouseToolTip(txtLOA);
         obf_K_e_3075.removeUIMouseToolTip(txtLOH);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         var _loc5_:GameItemFullInfo = null;
         if(Boolean(this.isWaitEquInfoToView) && Boolean(this.obf_0_2_X_583) && this.obf_0_2_X_583.checkTimeout())
         {
            this.obf_K_1_4353();
         }
         if(this.getEquipItemInfoTimeInv.checkTimeout())
         {
            _loc2_ = [EquipmentKind.WEAPON,EquipmentKind.SHIELD,EquipmentKind.CLOTHES,EquipmentKind.HAT,EquipmentKind.WING,EquipmentKind.SHOES,EquipmentKind.GLOVE,EquipmentKind.RING,EquipmentKind.AMULET,EquipmentKind.obf_s_Y_1219,EquipmentKind.obf_m_S_4609,EquipmentKind.FASHION_CLOTHES,EquipmentKind.FASHION_HAT,EquipmentKind.obf_8_L_1856,EquipmentKind.obf_i_3_4546];
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = this.getEquipBagByKind(_loc3_);
               if(!_loc4_ || !_loc4_.haveIconItem)
               {
                  if(this.equipItemsInfo[_loc3_])
                  {
                     trace("EquipmentInfo deleted (kind=" + _loc3_ + ")");
                     delete this.equipItemsInfo[_loc3_];
                  }
               }
               else
               {
                  _loc5_ = this.equipItemsInfo[_loc3_];
                  if(!_loc5_ || _loc4_.haveIconItem.itemCode != _loc5_.itemCode)
                  {
                     _loc5_ = GameItemInfoManager.getItemInfo(_loc4_.haveIconItem.itemId);
                     this.equipItemsInfo[_loc3_] = _loc5_;
                     if(_loc5_)
                     {
                        if(!_loc5_.isEmpty && Boolean(_loc5_.equipmentInfo))
                        {
                           PlayerSkillManager.setEquipmentSkill(_loc3_,EquipmentManager.getEquipmentLevelUpSkills(_loc5_.itemCode,_loc5_.equipmentInfo.equLevel));
                        }
                     }
                     else
                     {
                        GameContext.bagItemManager.sendViewItem(_loc4_.haveIconItem.itemId);
                        trace("Get EquipmentInfo (kind=" + _loc3_ + ")");
                     }
                  }
               }
            }
            if(!this.rideBag.haveIconItem)
            {
               if(this.rideInfo)
               {
                  this.rideInfo = null;
                  trace("Equip Ride Info deleted");
               }
            }
            else if(!this.rideInfo || this.rideBag.haveIconItem.itemId != this.rideInfo.itemId)
            {
               this.rideInfo = GameItemInfoManager.getItemInfo(this.rideBag.haveIconItem.itemId);
               if(!this.rideInfo)
               {
                  GameContext.bagItemManager.sendViewItem(this.rideBag.haveIconItem.itemId);
                  trace("Get Equip Ride Info");
               }
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
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_L_C_1850(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(EquipKindGrowManager.openCon,null,true))
         {
            return;
         }
         if(obf_K_e_3075.equipKindGrowUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.equipKindGrowUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.equipKindGrowUI);
         }
      }
      
      private function obf_r_e_737(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.fateSkillUI);
      }
      
      private function onOpenPlayerTitle(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.playerTitleUI);
      }
      
      private function obf_W_y_1025(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.successUI);
      }
      
      private function onAssignAttrPoint(param1:Event) : void
      {
         if(this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded <= 0 || !GameContext.localPlayer)
         {
            return;
         }
         GameContext.localPlayer.sendAssignAttr(this.strAdded,this.agiAdded,this.wisAdded,this.vitAdded);
      }
      
      private function onAddAttrPoint(param1:Event) : void
      {
         if(!GameContext.localPlayer || this.freeAttrPoint <= 0)
         {
            return;
         }
         if(param1.currentTarget == cmdStrAddPoint)
         {
            ++this.strAdded;
         }
         else if(param1.currentTarget == cmdAgiAddPoint)
         {
            ++this.agiAdded;
         }
         else if(param1.currentTarget == cmdWigAddPoint)
         {
            ++this.wisAdded;
         }
         else
         {
            if(param1.currentTarget != cmdVitAddPoint)
            {
               return;
            }
            ++this.vitAdded;
         }
         --this.freeAttrPoint;
         this.obf_U_y_3917();
      }
      
      private function onAddAttrAllPoint(param1:MouseEvent) : void
      {
         if(!GameContext.localPlayer || this.freeAttrPoint <= 0)
         {
            return;
         }
         if(param1.currentTarget == cmdStrAddAllPoint)
         {
            this.strAdded += this.freeAttrPoint;
         }
         else if(param1.currentTarget == cmdAgiAddAllPoint)
         {
            this.agiAdded += this.freeAttrPoint;
         }
         else if(param1.currentTarget == cmdWisAddAllPoint)
         {
            this.wisAdded += this.freeAttrPoint;
         }
         else
         {
            if(param1.currentTarget != cmdVitAddAllPoint)
            {
               return;
            }
            this.vitAdded += this.freeAttrPoint;
         }
         this.freeAttrPoint = 0;
         this.obf_U_y_3917();
      }
      
      private function onRemoveAttrPoint(param1:Event) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(param1.currentTarget == cmdStrRemovePoint && this.strAdded > 0)
         {
            --this.strAdded;
         }
         else if(param1.currentTarget == cmdAgiRemovePoint && this.agiAdded > 0)
         {
            --this.agiAdded;
         }
         else if(param1.currentTarget == cmdWisRemovePoint && this.wisAdded > 0)
         {
            --this.wisAdded;
         }
         else
         {
            if(!(param1.currentTarget == cmdVitRemovePoint && this.vitAdded > 0))
            {
               return;
            }
            --this.vitAdded;
         }
         ++this.freeAttrPoint;
         this.obf_U_y_3917();
      }
      
      private function obf_i_s_1897(param1:MouseEvent) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         this.freeAttrPoint += this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         this.obf_U_y_3917();
      }
      
      private function obf_u_2_3167(param1:MouseEvent) : void
      {
         var basePointAuto:int;
         var strAddNumber:Number;
         var agiAddNumber:Number;
         var wisAddNumber:Number;
         var vitAddNumber:Number;
         var pointAutoArray:Array = null;
         var i:int = 0;
         var remainArray:Array = null;
         var strRemain:String = null;
         var agiRemain:String = null;
         var wisRemain:String = null;
         var vitRemain:String = null;
         var k:int = 0;
         var e:MouseEvent = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            pointAutoArray = com.adobe.serialization.json.JSON.decode(DiversityManager.getString("PlayerPointAuto",GameContext.localPlayer.fullInfo.jobCode + "")) as Array;
         }
         catch(ex:Error)
         {
         }
         if(!pointAutoArray || pointAutoArray.length != 4)
         {
            return;
         }
         this.freeAttrPoint += this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         basePointAuto = 0;
         while(i < pointAutoArray.length)
         {
            basePointAuto += int(pointAutoArray[i]);
            i++;
         }
         if(basePointAuto == 0)
         {
            return;
         }
         strAddNumber = int(pointAutoArray[0]) * this.freeAttrPoint / basePointAuto;
         agiAddNumber = int(pointAutoArray[1]) * this.freeAttrPoint / basePointAuto;
         wisAddNumber = int(pointAutoArray[2]) * this.freeAttrPoint / basePointAuto;
         vitAddNumber = int(pointAutoArray[3]) * this.freeAttrPoint / basePointAuto;
         this.strAdded = Math.floor(strAddNumber);
         this.agiAdded = Math.floor(agiAddNumber);
         this.wisAdded = Math.floor(wisAddNumber);
         this.vitAdded = Math.floor(vitAddNumber);
         this.freeAttrPoint -= this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         if(this.freeAttrPoint > 0)
         {
            remainArray = new Array();
            strRemain = (strAddNumber - this.strAdded).toFixed(1);
            remainArray.push({
               "name":"str",
               "remain":strRemain,
               "attrAdd":this.strAdded
            });
            agiRemain = (agiAddNumber - this.agiAdded).toFixed(1);
            remainArray.push({
               "name":"agi",
               "remain":agiRemain,
               "attrAdd":this.agiAdded
            });
            wisRemain = (wisAddNumber - this.wisAdded).toFixed(1);
            remainArray.push({
               "name":"wis",
               "remain":wisRemain,
               "attrAdd":this.wisAdded
            });
            vitRemain = (vitAddNumber - this.vitAdded).toFixed(1);
            remainArray.push({
               "name":"vit",
               "remain":vitRemain,
               "attrAdd":this.vitAdded
            });
            remainArray.sortOn(["remain","attrAdd"],[Array.NUMERIC,Array.NUMERIC]);
            k = remainArray.length - 1;
            while(k >= 0)
            {
               if(this.freeAttrPoint == 0)
               {
                  break;
               }
               trace(remainArray[k].name + "*" + remainArray[k].remain + "*" + this.freeAttrPoint);
               if(remainArray[k].name == "str")
               {
                  ++this.strAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "agi")
               {
                  ++this.agiAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "wis")
               {
                  ++this.wisAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "vit")
               {
                  ++this.vitAdded;
                  --this.freeAttrPoint;
               }
               k--;
            }
         }
         this.obf_U_y_3917();
      }
      
      private function obf_U_y_3917() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         cmdPointOK.visible = cmdPointAuto.visible = cmdStrAddPoint.visible = cmdStrRemovePoint.visible = cmdStrAddAllPoint.visible = cmdAgiAddPoint.visible = cmdAgiRemovePoint.visible = cmdAgiAddAllPoint.visible = cmdWigAddPoint.visible = cmdWisRemovePoint.visible = cmdWisAddAllPoint.visible = cmdVitAddPoint.visible = cmdVitRemovePoint.visible = cmdVitAddAllPoint.visible = GameContext.localPlayer.fullInfo.freeAttrPt > 0;
         txtStrength.text = GameContext.localPlayer.fullInfo.attributes.strength + this.strAdded + "";
         txtAgility.text = GameContext.localPlayer.fullInfo.attributes.agility + this.agiAdded + "";
         txtIntellect.text = GameContext.localPlayer.fullInfo.attributes.wisdom + this.wisAdded + "";
         txtStamina.text = GameContext.localPlayer.fullInfo.attributes.vitality + this.vitAdded + "";
         txtAttrPoint.text = this.freeAttrPoint + "";
         cmdPointOK.enabled = this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded > 0;
         cmdPointAuto.enabled = this.freeAttrPoint > 0;
         cmdPointAuto.visible = !WorldConfig.getValue("functionSwitch","fastRoleAttrPoint");
      }
      
      public function obf_l_t_2376() : void
      {
         txtPK.text = GameContext.localPlayer.pkValue + "";
      }
      
      public function obf_f_p_3769() : void
      {
         txtGild.text = JSONUtil.getStr(GameContext.localPlayer.familyMyInfo,["familyName"]);
      }
      
      public function obf_d_O_1430() : void
      {
         txtRank.text = JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[GameContext.localPlayer.fullInfo.honorLevel]);
         txtPrestige.text = GameContext.localPlayer.fullInfo.honorValue + "";
         var _loc1_:int = NumberConfig.getHonorLevelUpValue(GameContext.localPlayer.fullInfo.honorLevel);
         var _loc2_:int = GameContext.localPlayer.fullInfo.honorValue - NumberConfig.getValue("honorLevelValues",GameContext.localPlayer.fullInfo.honorLevel);
         var _loc3_:int = _loc2_ / _loc1_ * 100;
         obf_N_L_4045.gotoAndStop(_loc3_);
      }
      
      private function obf_i_B_1949(param1:Event) : void
      {
         EquipmentManager.sendSwitchFashion(chkShowFashion.selected);
      }
      
      public function setRoleAttr(param1:LocalPlayerInfo) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.totlePoint != param1.freeAttrPt)
         {
            this.freeAttrPoint = param1.freeAttrPt;
            this.totlePoint = param1.freeAttrPt;
            this.strAdded = 0;
            this.agiAdded = 0;
            this.wisAdded = 0;
            this.vitAdded = 0;
         }
         obf_K_e_3075.playerBoxUI.txtTitle = param1.name;
         txtLevel.text = param1.level + "";
         txtMaxLevel.text = param1.maxLevel + "";
         this.expChange(param1.exp,NumberConfig.getPlayerLevelNumber(param1.level));
         txtJob.text = obf_I_5_1944.getJobShowName(param1.jobCode);
         txtState.text = obf_S_Q_3707.getRebornName(GameContext.localPlayer.fullInfo.rebornTimes);
         this.obf_d_O_1430();
         this.obf_l_t_2376();
         this.obf_f_p_3769();
         this.hpChange(param1.attributes.hp,param1.attributes.hpMax);
         this.mpChange(param1.attributes.mp,param1.attributes.mpMax);
         this.spChange(param1.attributes.sp,param1.attributes.spMax);
         txtCharmValue.text = param1.charmValue + "";
         txtCharmInt.text = param1.charmInt + "";
         this.obf_U_y_3917();
         txtPhysicalAttack.text = param1.attributes.physicalAttack + "";
         txtMagicAttack.text = param1.attributes.magicAttack + "";
         txtCure.text = param1.attributes.cureValue + "";
         txtPhysicalDefense.text = param1.attributes.physicalDefense + "(" + obf_A_x_3023.getRateString(param1.attributes.physicalReduceRate) + ")";
         txtMagicDefense.text = param1.attributes.magicDefense + "(" + obf_A_x_3023.getRateString(param1.attributes.magicReduceRate) + ")";
         txtAccuracy.text = param1.attributes.hitValue + "(+" + obf_A_x_3023.getRateString(param1.attributes.hitRate - 1) + ")";
         txtDodge.text = param1.attributes.dodgeValue + "(" + obf_A_x_3023.getRateString(param1.attributes.dodgeRate) + ")";
         txtCrit.text = param1.attributes.critValue + "(" + obf_A_x_3023.getRateString(param1.attributes.critRate) + ")";
         txtLuck.text = param1.attributes.luckyAttack + "";
         txtLuckDefense.text = param1.attributes.luckyDefense + "";
         txtCritDamage.text = obf_A_x_3023.getRateString(param1.attributes.critDamageMul);
         txtCritDefense.text = param1.attributes.toughValue + "";
         txtPierceAttack.text = param1.attributes.pierceAttack + "";
         txtPierceDefense.text = param1.attributes.pierceDefense + "";
         txtHpHeal.text = param1.attributes.hpHealValue + "/3s";
         txtMpHeal.text = param1.attributes.mpHealValue + "/3s";
         txtAttackSpeed.text = obf_A_x_3023.getRateString(1 / param1.attributes.castTimeModifier);
         txtSingSpeed.text = obf_A_x_3023.getRateString(1 / param1.attributes.singTimeModifier);
         txtWalkSpeed.text = param1.attributes.walkSpeed + "";
         txtLOT.text = param1.attributes.lot + "(" + (param1.attributes.lot / 30 * 0.8).toFixed(2) + "%)";
         txtLOA.text = param1.attributes.loa + "(" + (param1.attributes.loa / 30 * 0.8).toFixed(2) + "%)";
         txtLOH.text = param1.attributes.loh + "(" + (param1.attributes.loh / 30 * 0.8).toFixed(2) + "%)";
         if(obf_3_817.numChildren <= 0)
         {
            _loc2_ = obf_I_5_1944.getJobImage(param1.jobCode,param1.sex);
            if(_loc2_)
            {
               _loc2_.scaleX = 0.4;
               _loc2_.scaleY = 0.4;
               obf_3_817.addChild(_loc2_);
            }
         }
      }
      
      public function hpChange(param1:Number, param2:Number) : void
      {
         txtHp.text = param1 + "/" + param2;
      }
      
      public function mpChange(param1:int, param2:int) : void
      {
         txtMp.text = param1 + "/" + param2;
      }
      
      public function spChange(param1:int, param2:int) : void
      {
         txtSp.text = param1 + "/" + param2;
      }
      
      public function expChange(param1:uint, param2:uint) : void
      {
         txtExp.text = param1 + "/" + param2;
         var _loc3_:int = 100 * Number(param1 / param2);
         if(_loc3_ < 2)
         {
            _loc3_ = 2;
         }
         expBar.gotoAndStop(_loc3_);
      }
      
      public function obf_q_K_3144(param1:String) : void
      {
      }
      
      public function setEquip(param1:EquippedItemInfo) : void
      {
         var _loc3_:Object = null;
         var _loc4_:IconItemEquip = null;
         if(!param1 || !GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:IconItemBag = this.bagKind[param1.equipmentKind + ""];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.dropIconItem();
         _loc2_.bagMC.alpha = 0.5;
         if(param1.equipment)
         {
            _loc3_ = GameItemManager.getItemConfig(param1.equipment.itemCode);
            _loc4_ = IconItemEquip.getNewIconItem(param1.equipment.itemCode,param1.equipment.itemId);
            _loc2_.pushIconItem(_loc4_);
            _loc2_.bagMC.alpha = 1;
         }
      }
      
      public function setRideEquip(param1:RideBriefInfo) : void
      {
         this.rideBag.dropIconItem();
         this.rideBag.bagMC.alpha = 0.5;
         if(!param1)
         {
            return;
         }
         var _loc2_:IconItemRide = IconItemRide.getNewIconItem(param1.rideCode,param1.rideId);
         if(_loc2_)
         {
            this.rideBag.pushIconItem(_loc2_);
            this.rideBag.bagMC.alpha = 1;
         }
      }
      
      public function obf_C_K_1175(param1:String) : Boolean
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.bags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set showFashion(param1:Boolean) : void
      {
         this.showFationMode = param1;
         chkShowFashion.selected = param1;
         this.obf_K_1_4353();
      }
      
      public function get showFashion() : Boolean
      {
         return this.showFationMode;
      }
      
      public function obf_K_1_4353() : void
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         var _loc5_:String = null;
         var _loc6_:GameItemFullInfo = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         _loc1_ = [EquipmentKind.WEAPON,EquipmentKind.SHIELD,EquipmentKind.WING];
         if(this.showFationMode)
         {
            if(Boolean(this.bagKind[EquipmentKind.FASHION_CLOTHES + ""]) && Boolean(this.bagKind[EquipmentKind.FASHION_CLOTHES + ""].haveIconItem))
            {
               _loc1_.push(EquipmentKind.FASHION_CLOTHES);
            }
            else
            {
               _loc1_.push(EquipmentKind.CLOTHES);
            }
            if(Boolean(this.bagKind[EquipmentKind.FASHION_HAT + ""]) && Boolean(this.bagKind[EquipmentKind.FASHION_HAT + ""].haveIconItem))
            {
               _loc1_.push(EquipmentKind.FASHION_HAT);
            }
            else
            {
               _loc1_.push(EquipmentKind.HAT);
            }
         }
         else
         {
            _loc1_.push(EquipmentKind.CLOTHES,EquipmentKind.HAT);
         }
         var _loc2_:Object = new Object();
         this.isWaitEquInfoToView = false;
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = this.bagKind[_loc3_ + ""];
            _loc5_ = "";
            if(Boolean(_loc4_) && Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem is IconItemEquip)
            {
               _loc6_ = GameItemInfoManager.getItemInfo(_loc4_.haveIconItem.itemId);
               _loc7_ = GameItemManager.getItemConfig(_loc4_.haveIconItem.itemCode);
               _loc5_ = IconItemEquip(_loc4_.haveIconItem).modelCode;
               if(!obf_L_l_4100.isEmpty(_loc5_))
               {
                  if(Boolean(_loc3_ == EquipmentKind.WEAPON && _loc6_) && Boolean(!_loc6_.isEmpty) && !JSONUtil.getBoolean(_loc7_,["properties","notShowRefine"]))
                  {
                     _loc8_ = obf_1_t_884.getRefineEquipModeCode(_loc6_.equipmentInfo.refineLevel,GameContext.localPlayer.fullInfo.jobCode);
                     if(!obf_L_l_4100.isEmpty(_loc8_))
                     {
                        _loc5_ += "," + _loc8_;
                     }
                  }
                  if(!_loc6_ || _loc6_.expiredTimeLeftInHour > 0)
                  {
                     _loc2_[_loc3_ + ""] = _loc5_;
                  }
               }
               if(!_loc6_)
               {
                  GameContext.bagItemManager.sendViewItem(_loc4_.haveIconItem.itemId);
                  this.obf_0_2_X_583 = new TimeLimiter(1000);
                  this.isWaitEquInfoToView = true;
               }
            }
         }
         if(GameContext.localPlayer)
         {
            GameContext.localPlayer.setEquipmentModels(_loc2_);
         }
      }
      
      public function getEquipBindSkills() : Array
      {
         var _loc2_:String = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKind)
         {
            _loc3_ = this.bagKind[_loc2_];
            if(_loc3_.haveIconItem)
            {
               _loc4_ = GameItemManager.getItemConfig(_loc3_.haveIconItem.itemCode);
               if((Boolean(_loc4_)) && Boolean(_loc4_.properties.bindingSkills))
               {
                  for each(_loc5_ in _loc4_.properties.bindingSkills)
                  {
                     _loc1_.push(_loc5_);
                  }
               }
            }
         }
         if(this.rideBag.haveIconItem)
         {
            _loc6_ = GameItemManager.getItemConfig(this.rideBag.haveIconItem.itemCode);
            _loc7_ = JSONUtil.getObject(_loc6_,["properties","bindingSkills"]) as Array;
            if((Boolean(_loc7_)) && _loc7_.length > 0)
            {
               for each(_loc8_ in _loc7_)
               {
                  if(_loc1_.indexOf(_loc8_) == -1)
                  {
                     _loc1_.push(_loc8_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function dropEqu(param1:IconItemBag, param2:int) : void
      {
         var _loc3_:int = 0;
         if(param1.haveIconItem)
         {
            _loc3_ = 0;
            while(_loc3_ < param2)
            {
               EquipmentManager.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,-1);
               _loc3_++;
            }
         }
      }
      
      private function showMetempsychosisUI() : void
      {
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
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.bags = null;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(Boolean(param3) && Boolean(param1.haveIconItem) && param1.haveIconItem.itemType != GameItemType.SKILL)
         {
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,param1.haveIconItem.itemName,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
         if(Boolean(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_2_N_1475) && Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT)
         {
            obf_K_e_3075.equipRepairUI.showEquipRepair(param1.haveIconItem.itemCode,param1.haveIconItem.itemId);
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(param1 == this.rideBag && Boolean(this.rideBag.haveIconItem))
         {
            GameContext.localPlayer.sendSetUsingRide("");
         }
         if(Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT)
         {
            EquipmentManager.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,-1);
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(!(param3.parentIconUI is PlayerBagUI) || !GameItemType.contrastType(GameItemType.EQUIPMENT,param2.itemType))
         {
            param2.destroy();
            return;
         }
         param3.useIconItem();
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(!(param3 is PlayerBagUI))
         {
            return;
         }
         EquipmentManager.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,param2 ? param2.itemIndex : -1);
      }
   }
}

