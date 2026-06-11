package com.sunweb.game.rpg.playerUI.pet
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquippedItemInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.netRole.obf_t_T_3981;
   import com.sunweb.game.rpg.pet.ItemPlayerPetInfo;
   import com.sunweb.game.rpg.pet.PetAttributesInfo;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   import com.sunweb.game.rpg.pet.PetKind;
   import com.sunweb.game.rpg.pet.PetSkillSlot;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_l_l_940;
   import com.sunweb.game.rpg.world.MonsterSpecies;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.Pet.LevelOpenBoxIcon;
   import playerUI.Pet.OpenBoxIcon;
   import playerUI.PetBoxUIMC;
   
   public class PetBoxUI extends PetBoxUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      public static const petBagCount:int = 8;
      
      public static const petSkillSlot:int = 8;
      
      private var obf_a_v_4592:Array;
      
      private var defSkillBag:IconItemBag;
      
      private var petBags:Array;
      
      private var obf_e_L_778:String;
      
      private var obf_7_I_1288:String;
      
      private var obf_0_2_8_564:String;
      
      private var petEquipBags:Array;
      
      private var petEquipMap:Object;
      
      private var petSkillBags:Array;
      
      private var petSkillBoxList:Array;
      
      private var obf_m_2_1291:PetFullInfo;
      
      private var strAdded:int;
      
      private var agiAdded:int;
      
      private var wisAdded:int;
      
      private var vitAdded:int;
      
      private var freeAttrPoint:int;
      
      private var petImage:obf_t_T_3981;
      
      private var obf_D_B_3820:Object;
      
      private var obf_0_4_l_705:Object;
      
      private var obf_l_M_1543:String;
      
      private var obf_M_M_1358:Array;
      
      private var bagsBox:Array;
      
      private var openObiect:Array;
      
      private var _noviceSprite:Sprite;
      
      private var pageNum:int = 1;
      
      private var pageTotle:int;
      
      private var bagSortTimeInv:TimeLimiter;
      
      private var petImageActiveTimeInv:TimeLimiter;
      
      private var openIconList:Array;
      
      private var petMaxGrowth:Number;
      
      private var petGrowth:Number;
      
      private var skillOpenIconList:Array;
      
      public function PetBoxUI()
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:IconItemBag = null;
         var _loc11_:MovieClip = null;
         var _loc12_:IconItemBag = null;
         var _loc13_:obf_s_Q_3016 = null;
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         var _loc16_:IconItemBag = null;
         this.bagsBox = new Array();
         this.petImageActiveTimeInv = new TimeLimiter(2000);
         this.openIconList = new Array();
         this.skillOpenIconList = new Array();
         super();
         this.initDiversity();
         cmdEnhanceLevel.enabled = !WorldConfig.getValue("functionSwitch","petEnhance");
         cmdGeneration.enabled = !WorldConfig.getValue("functionSwitch","petFusion");
         this.visible = false;
         selectedBoxIcon.mouseEnabled = false;
         selectedBoxIcon.visible = false;
         obf_j_L_3395.mouseEnabled = false;
         obf_j_L_3395.visible = false;
         pointPetImage.mouseChildren = false;
         pointPetImage.mouseEnabled = false;
         barExp.gotoAndStop(1);
         barStrengthApt.gotoAndStop(1);
         barAgilityApt.gotoAndStop(1);
         barWisdomApt.gotoAndStop(1);
         barVitalityApt.gotoAndStop(1);
         this.petBags = new Array();
         this.openObiect = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= obf_c_4686.getPetBagsNum / 8)
         {
            _loc7_ = this["petBag" + _loc1_] as MovieClip;
            _loc7_.doubleClickEnabled = true;
            this.bagsBox.push(_loc7_);
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               _loc9_ = this["petBag" + _loc1_]["bag" + _loc8_];
               if(_loc9_ != null)
               {
                  _loc10_ = new IconItemBag(_loc9_,this,(_loc1_ - 1) * 8 + _loc8_);
                  _loc10_.isLocked = true;
                  _loc11_ = this["petBag" + _loc1_]["open"]["open" + _loc8_];
                  _loc11_.mouseEnabled = false;
                  _loc10_.addValidType(GameItemType.PET);
                  this.petBags.push(_loc10_);
                  this.openObiect.push(_loc11_);
               }
               _loc8_++;
            }
            _loc7_.setChildIndex(this["petBag" + _loc1_]["open"],_loc7_.numChildren - 1);
            _loc1_++;
         }
         this.petEquipMap = new Object();
         this.petEquipBags = new Array();
         var _loc2_:Object = {
            (EquipmentKind.obf_e_n_4302 + ""):bagWeapon,
            (EquipmentKind.obf_Q_g_1533 + ""):bagBlood,
            (EquipmentKind.obf_5_V_4088 + ""):bagAccessory,
            (EquipmentKind.obf_0_4_J_654 + ""):bagArmor
         };
         for(_loc3_ in _loc2_)
         {
            _loc12_ = new IconItemBag(_loc2_[_loc3_],this,0,_loc3_);
            _loc12_.addValidType(GameItemType.EQUIPMENT);
            this.petEquipBags.push(_loc12_);
            this.petEquipMap[_loc3_] = _loc12_;
         }
         this.petSkillBags = new Array();
         this.petSkillBoxList = new Array();
         _loc4_ = 0;
         while(_loc4_ < petSkillSlot)
         {
            _loc13_ = new obf_s_Q_3016(this);
            _loc13_.x = _loc4_ % 8 * 50;
            _loc13_.y = int(_loc4_ / 8) * 50;
            pointSkill.addChild(_loc13_);
            this.petSkillBoxList.push(_loc13_);
            this.petSkillBags.push(_loc13_.iconBag);
            _loc4_++;
         }
         this.defSkillBag = new IconItemBag(barDefSkill,this,0);
         this.defSkillBag.addValidType(GameItemType.SKILL);
         this.defSkillBag.lockDrag = true;
         this.setChildIndex(selectedBoxIcon,this.numChildren - 1);
         this.setChildIndex(obf_j_L_3395,this.numChildren - 1);
         this.obf_0_4_l_705 = new Object();
         for each(_loc5_ in obf_l_l_940.petFateSkillCodes)
         {
            _loc14_ = this[_loc5_];
            if(_loc14_)
            {
               this.obf_0_4_l_705[_loc5_] = _loc14_;
            }
         }
         this.obf_M_M_1358 = new Array();
         _loc6_ = 0;
         while(_loc6_ <= 3)
         {
            _loc15_ = this["bagFateItem" + _loc6_];
            if(_loc15_)
            {
               _loc16_ = new IconItemBag(_loc15_,this,_loc6_);
               _loc16_.addValidType(GameItemType.ALL);
               this.obf_M_M_1358.push(_loc16_);
            }
            _loc6_++;
         }
         this.obf_a_v_4592 = this.petBags.concat(this.defSkillBag,this.petSkillBags,this.petEquipBags,this.obf_M_M_1358);
         if(!WorldConfig.getValue("functionSwitch","showPetFate"))
         {
            this.setChildIndex(obf_v_N_4096,this.numChildren - 1);
            this.setChildIndex(txtDeyNotOpen,this.numChildren - 1);
         }
         else
         {
            txtDeyNotOpen.text = "";
         }
         this.showPage(1);
         this.addListener();
      }
      
      public function get obf_O_O_3039() : PetFullInfo
      {
         return this.obf_m_2_1291;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyName,"PetUI","txtName");
         DiversityManager.setTextField(txtDeyLevel,"PetUI","txtLevel");
         DiversityManager.setTextField(txtDeyItemType,"PetUI","txtItemType");
         DiversityManager.setTextField(txtDeyType,"PetUI","txtType");
         DiversityManager.setTextField(txtDeySex,"PetUI","txtSex");
         DiversityManager.setTextField(txtDeyLoyalty,"PetUI","txtLoyalty");
         DiversityManager.setTextField(txtDeyLife,"PetUI","txtLife");
         DiversityManager.setTextField(txtDeyGrowthRate,"PetUI","txtGrowthRate");
         DiversityManager.setTextField(txtDeyExp,"PetUI","txtExp");
         DiversityManager.setTextField(txtDeyRace,"PetUI","txtRace");
         DiversityManager.setTextField(txtDeyRestraint,"PetUI","txtRestraint");
         DiversityManager.setTextField(txtDeyRestraintModulus,"PetUI","txtRestraintModulus");
         DiversityManager.setTextField(txtDeyStrength,"PetUI","txtStrength");
         DiversityManager.setTextField(txtDeyAgility,"PetUI","txtAgility");
         DiversityManager.setTextField(txtDeyWisdom,"PetUI","txtWisdom");
         DiversityManager.setTextField(txtDeyVitality,"PetUI","txtVitality");
         DiversityManager.setTextField(txtDeyAttrPoint,"PetUI","txtAttrPoint");
         DiversityManager.setTextField(txtDeyStrengthApt,"PetUI","txtStrengthApt");
         DiversityManager.setTextField(txtDeyAgilityApt,"PetUI","txtAgilityApt");
         DiversityManager.setTextField(txtDeyWisdomApt,"PetUI","txtWisdomApt");
         DiversityManager.setTextField(txtDeyVitalityApt,"PetUI","txtVitalityApt");
         DiversityManager.setTextField(txtDeyAbsorbRatio,"PetUI","txtAbsorbRatio");
         DiversityManager.setTextField(txtDeyHP,"PetUI","txtHP");
         DiversityManager.setTextField(txtDeyMP,"PetUI","txtMP");
         DiversityManager.setTextField(txtDeyPhysicalAttack,"PetUI","txtPhysicalAttack");
         DiversityManager.setTextField(txtDeyMagicAttack,"PetUI","txtMagicAttack");
         DiversityManager.setTextField(txtDeyHitValue,"PetUI","txtHitValue");
         DiversityManager.setTextField(txtDeyCritValue,"PetUI","txtCritValue");
         DiversityManager.setTextField(txtDeyPetSkill,"PetUI","txtPetSkill");
         DiversityManager.setTextField(txtDeyPetDefSkill,"PetUI","txtPetDefSkill");
         DiversityManager.setTextField(txtDeyPetEquip,"PetUI","txtPetEquip");
         DiversityManager.setTextField(txtDeyWeapon,"PetUI","txtPetWeapon");
         DiversityManager.setTextField(txtDeyBlood,"PetUI","txtPetBlood");
         DiversityManager.setTextField(txtDeyArmor,"PetUI","txtPetArmor");
         DiversityManager.setTextField(txtDeyAccessory,"PetUI","txtPetAccessory");
         DiversityManager.setTextField(txtDeyNotOpen,"CommonPrompt","notOpenYet");
         DiversityManager.setTextField(txtDeyFateName,"PetUI","txtFateName");
         DiversityManager.setTextField(txtDeyFatePetLevel,"PetUI","txtFatePetLevel");
         DiversityManager.setTextField(txtDeyFateGold,"PetUI","txtFateGold");
         DiversityManager.setTextField(txtDeyFateItems,"PetUI","txtFateItems");
         cmdFate.label = DiversityManager.getString("PetUI","cmdFate");
         cmdPointOK.label = DiversityManager.getString("PetUI","cmdPointOK");
         cmdName.label = DiversityManager.getString("PetUI","cmdName");
         cmdLevel.label = DiversityManager.getString("PetUI","cmdLevel");
         cmdChangeItemType.label = DiversityManager.getString("PetUI","cmdItemType");
         cmdSex.label = DiversityManager.getString("PetUI","cmdSex");
         cmdLoyalty.label = DiversityManager.getString("PetUI","cmdLoyalty");
         cmdLife.label = DiversityManager.getString("PetUI","cmdLife");
         cmdGrowthRate.label = DiversityManager.getString("PetUI","cmdGrowthRate");
         cmdGeneration.label = DiversityManager.getString("PetUI","cmdGeneration");
         cmdEnhanceLevel.label = DiversityManager.getString("PetUI","cmdEnhanceLevel");
         cmdSummon.label = DiversityManager.getString("PetUI","cmdSummon");
         cmdRelease.label = DiversityManager.getString("PetUI","cmdRelease");
         cmdResetApt.label = DiversityManager.getString("PetUI","cmdResetApt");
         cmdPetUp.label = DiversityManager.getString("PetUI","cmdUp");
         cmdPetDown.label = DiversityManager.getString("PetUI","cmdDown");
         cmdPetSort.label = DiversityManager.getString("PetUI","cmdSort");
      }
      
      public function get selectedPetId() : String
      {
         return this.obf_e_L_778;
      }
      
      public function get petEquipArray() : Array
      {
         return this.petEquipBags;
      }
      
      public function get sommunPetId() : String
      {
         return this.obf_0_2_8_564;
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
         return "PetBoxUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:IconItemBag = null;
         for each(_loc3_ in this.petBags)
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
         for each(_loc2_ in this.petBags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      private function addListener() : void
      {
         var _loc1_:obf_s_Q_3016 = null;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         cmdSummon.addEventListener(MouseEvent.CLICK,this.obf_K_E_2337);
         cmdRelease.addEventListener(MouseEvent.CLICK,this.onClickRelease);
         cmdName.addEventListener(MouseEvent.CLICK,this.onClickRename);
         cmdLevel.addEventListener(MouseEvent.CLICK,this.obf_0_0_B_625);
         cmdChangeItemType.addEventListener(MouseEvent.CLICK,this.obf_J_C_3711);
         cmdSex.addEventListener(MouseEvent.CLICK,this.onClickSex);
         cmdLoyalty.addEventListener(MouseEvent.CLICK,this.obf_C_A_3399);
         cmdLife.addEventListener(MouseEvent.CLICK,this.obf_n_9_4305);
         cmdGrowthRate.addEventListener(MouseEvent.CLICK,this.obf_p_Z_4248);
         cmdResetApt.addEventListener(MouseEvent.CLICK,this.obf_o_f_1517);
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
         cmdPetUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdPetDown.addEventListener(MouseEvent.CLICK,this.obf_i_f_4732);
         cmdPetSort.addEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         cmdEnhanceLevel.addEventListener(MouseEvent.CLICK,this.obf_0___h_306);
         cmdGeneration.addEventListener(MouseEvent.CLICK,this.obf_c_9_4225);
         for each(_loc1_ in this.petSkillBoxList)
         {
            _loc1_.addEventListener(obf_s_Q_3016.obf_V_6_2382,this.obf_5_W_3832);
         }
         cmdFate.addEventListener(MouseEvent.CLICK,this.obf_r_n_1499);
         for(_loc2_ in this.obf_0_4_l_705)
         {
            _loc3_ = this.obf_0_4_l_705[_loc2_];
            if(_loc3_)
            {
               _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.showFateSkillTooltip);
               _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.closeFateSkillTooltip);
               _loc3_.addEventListener(MouseEvent.CLICK,this.obf_H_S_2962);
            }
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:obf_s_Q_3016 = null;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         cmdSummon.removeEventListener(MouseEvent.CLICK,this.obf_K_E_2337);
         cmdRelease.removeEventListener(MouseEvent.CLICK,this.onClickRelease);
         cmdName.removeEventListener(MouseEvent.CLICK,this.onClickRename);
         cmdLevel.removeEventListener(MouseEvent.CLICK,this.obf_0_0_B_625);
         cmdChangeItemType.removeEventListener(MouseEvent.CLICK,this.obf_J_C_3711);
         cmdSex.removeEventListener(MouseEvent.CLICK,this.onClickSex);
         cmdLoyalty.removeEventListener(MouseEvent.CLICK,this.obf_C_A_3399);
         cmdLife.removeEventListener(MouseEvent.CLICK,this.obf_n_9_4305);
         cmdGrowthRate.removeEventListener(MouseEvent.CLICK,this.obf_p_Z_4248);
         cmdResetApt.removeEventListener(MouseEvent.CLICK,this.obf_o_f_1517);
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
         cmdPetUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdPetDown.removeEventListener(MouseEvent.CLICK,this.obf_i_f_4732);
         cmdPetSort.removeEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         cmdEnhanceLevel.removeEventListener(MouseEvent.CLICK,this.obf_0___h_306);
         cmdGeneration.removeEventListener(MouseEvent.CLICK,this.obf_c_9_4225);
         for each(_loc1_ in this.petSkillBoxList)
         {
            _loc1_.removeEventListener(obf_s_Q_3016.obf_V_6_2382,this.obf_5_W_3832);
         }
         cmdFate.removeEventListener(MouseEvent.CLICK,this.obf_r_n_1499);
         for(_loc2_ in this.obf_0_4_l_705)
         {
            _loc3_ = this.obf_0_4_l_705[_loc2_];
            if(_loc3_)
            {
               _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.showFateSkillTooltip);
               _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.closeFateSkillTooltip);
               _loc3_.removeEventListener(MouseEvent.CLICK,this.obf_H_S_2962);
            }
         }
      }
      
      public function getPetIconItemBagByIndex(param1:int) : IconItemBag
      {
         param1 = Math.max(Math.min(param1,this.petBags.length - 1),0);
         return this.petBags[param1];
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
         if(this.pageNum >= obf_c_4686.getPetBagsNum / 8)
         {
            this.pageNum = obf_c_4686.getPetBagsNum / 8;
         }
         this.showPage(this.pageNum);
      }
      
      public function showPage(param1:int) : void
      {
         var bagBox:MovieClip = null;
         var page:int = param1;
         this.obf_P_W_1972();
         selectedBoxIcon.visible = false;
         this.pageTotle = obf_c_4686.getPetBagsNum / 8;
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
         if(!this.getPetBagById(this.obf_0_2_8_564))
         {
            this.setSummonPet("");
         }
         else
         {
            this.setSummonPet(this.obf_0_2_8_564);
         }
         if(obf_c_4686.getPetBagsNum / 8 > 1)
         {
            DiversityManager.setTextField(txtPage,"PetUI","prompt_CurrentPage",[page,this.pageTotle],true);
         }
      }
      
      private function obf_a_z_1623(param1:Event) : void
      {
         GameContext.bagItemManager.sendSortBag(PlayerBagIndex.PLAYER_PET_BAG);
         cmdPetSort.enabled = false;
         this.bagSortTimeInv = new TimeLimiter(WorldConfig.obf_K_L_4278);
      }
      
      public function obf_0___U_74() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.petBags)
         {
            _loc3_ = this.openObiect[_loc1_];
            if(_loc3_)
            {
               _loc3_.visible = _loc2_.isLocked;
               _loc1_++;
            }
         }
      }
      
      private function obf_K_E_2337(param1:Event) : void
      {
         var _loc2_:IconItemBag = this.getPetBagById(this.obf_e_L_778);
         if(Boolean(_loc2_) && Boolean(_loc2_.haveIconItem))
         {
            _loc2_.haveIconItem.useIcon();
         }
      }
      
      private function onClickRelease(param1:Event) : void
      {
         var _loc2_:IconItemBag = this.getPetBagById(this.obf_e_L_778);
         if(Boolean(_loc2_) && Boolean(_loc2_.haveIconItem))
         {
            WindowManager.showConfirmBox(DiversityManager.getString("PetUI","petPrompt_ConfirmDropPet"),this.confirmReleasePet,[PlayerBagIndex.PLAYER_PET_BAG,_loc2_.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
         }
      }
      
      private function obf_0___h_306(param1:Event) : void
      {
         if(!this.obf_m_2_1291)
         {
            return;
         }
         obf_K_e_3075.petEnhanceUI.setPetToEnhance(this.obf_m_2_1291.petId,this.obf_m_2_1291.petCode);
         obf_K_e_3075.showUI(obf_K_e_3075.petEnhanceUI);
      }
      
      private function obf_c_9_4225(param1:Event) : void
      {
         if(!this.obf_m_2_1291)
         {
            return;
         }
         obf_K_e_3075.petFusionUI.obf_f_F_4408(this.obf_m_2_1291.petCode,this.obf_m_2_1291.petId);
         obf_K_e_3075.showUI(obf_K_e_3075.petFusionUI);
      }
      
      private function onClickRename(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("PetUI","petPrompt_InputNewPetName"),null,this.obf_e_L_778,WorldConfig.obf_6_r_3938),this.confirmRename);
      }
      
      private function confirmRename(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            if(obf_r_Y_1874.isUnlawful(param1.content))
            {
               WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","invalidName"));
               return;
            }
            obf_c_4686.sendPetRename(param1.par,param1.content);
         }
      }
      
      private function obf_0_0_B_625(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         ButtonToItemManager.useBTIById("resetPetLevel",{"petId":this.obf_e_L_778});
      }
      
      private function obf_J_C_3711(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         obf_K_e_3075.showUI(obf_K_e_3075.petAssembleBoxUI);
         obf_K_e_3075.petAssembleBoxUI.showPetAssemble(this.obf_7_I_1288,this.obf_e_L_778);
      }
      
      private function onClickSex(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         ButtonToItemManager.useBTIById("changePetSex",{"petId":this.obf_e_L_778});
      }
      
      private function obf_C_A_3399(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         ButtonToItemManager.useBTIById("feedPet",{"petId":this.obf_e_L_778});
      }
      
      private function obf_n_9_4305(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         ButtonToItemManager.useBTIById("addPetLife",{"petId":this.obf_e_L_778});
      }
      
      private function obf_p_Z_4248(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         if(int(this.petGrowth.toFixed(1)) >= int(this.petMaxGrowth.toFixed(1)))
         {
            return;
         }
         ButtonToItemManager.useBTIById("growthRatePet",{"petId":this.obf_e_L_778});
      }
      
      private function obf_o_f_1517(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_e_L_778))
         {
            return;
         }
         ButtonToItemManager.useBTIById("resetPetApt",{"petId":this.obf_e_L_778});
      }
      
      private function obf_5_W_3832(param1:Event) : void
      {
         var _loc2_:obf_s_Q_3016 = param1.currentTarget as obf_s_Q_3016;
         if(!_loc2_ || !_loc2_.iconBag.haveIconItem)
         {
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("PetUI","petPrompt_ConfirmForgetSkill",[obf_a_f_2935.getMoneyString(JSONUtil.getInt(obf_c_4686.config,["forgetSkillMoney"]))]),this.confirmForgetSkill,_loc2_.iconBag.haveIconItem.itemCode);
      }
      
      private function confirmForgetSkill(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_c_4686.sendForgetSkill(this.obf_e_L_778,param1.par);
         }
      }
      
      private function onAssignAttrPoint(param1:Event) : void
      {
         if(this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded <= 0 || !this.obf_m_2_1291)
         {
            return;
         }
         obf_c_4686.sendAssignAttr(this.obf_m_2_1291.petId,this.strAdded,this.agiAdded,this.vitAdded,this.wisAdded);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.petImage) && this.petImageActiveTimeInv.checkTimeout())
         {
            this.petImage.onUpdate();
            this.petImage.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
         if(Boolean(this.bagSortTimeInv) && this.bagSortTimeInv.checkTimeout())
         {
            cmdPetSort.enabled = true;
            this.bagSortTimeInv = null;
         }
      }
      
      public function getEnptyBag() : int
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.petBags)
         {
            if(!_loc2_.isLocked && !_loc2_.haveIconItem)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getPetBagById(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.petBags)
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
      
      public function checkSummonAndSelectPetBag() : void
      {
         if(!this.getPetBagById(this.obf_e_L_778))
         {
            this.selectPet("","");
            this.obf_P_W_1972();
         }
         else
         {
            this.selectPet(this.obf_e_L_778,this.obf_7_I_1288);
         }
         if(!this.getPetBagById(this.obf_0_2_8_564))
         {
            this.setSummonPet("");
         }
         else
         {
            this.setSummonPet(this.obf_0_2_8_564);
         }
      }
      
      public function obf_G_b_4285() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Array = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:DisplayObject = null;
         for each(_loc1_ in this.openIconList)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         this.openIconList = new Array();
         _loc2_ = new Array();
         for each(_loc3_ in this.petBags)
         {
            if(_loc3_.isLocked)
            {
               if(_loc2_.length > 0)
               {
                  _loc4_ = _loc2_.shift();
               }
               else
               {
                  _loc4_ = new OpenBoxIcon();
               }
               if(_loc4_)
               {
                  if(_loc4_ is InteractiveObject)
                  {
                     (_loc4_ as InteractiveObject).mouseEnabled = false;
                  }
                  _loc4_.x = _loc3_.x;
                  _loc4_.y = _loc3_.y;
                  this.addChild(_loc4_);
                  this.openIconList.push(_loc4_);
               }
            }
         }
      }
      
      public function obf_6_B_1781(param1:String) : void
      {
         var _loc2_:IconItemBag = this.getPetBagById(param1);
         if(!_loc2_ || _loc2_.isLocked || !_loc2_.haveIconItem)
         {
            return;
         }
         _loc2_.haveIconItem.useIcon();
      }
      
      public function selectPet(param1:String, param2:String) : void
      {
         var _loc4_:MovieClip = null;
         selectedBoxIcon.visible = false;
         this.obf_e_L_778 = param1;
         this.obf_7_I_1288 = param2;
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         var _loc3_:IconItemBag = this.getPetBagById(param1);
         if(!_loc3_)
         {
            return;
         }
         for each(_loc4_ in this.bagsBox[this.pageNum - 1])
         {
            if(_loc4_ == _loc3_.bagMC)
            {
               selectedBoxIcon.x = _loc3_.x + (this.bagsBox[this.pageNum - 1] as MovieClip).x;
               selectedBoxIcon.y = _loc3_.y + (this.bagsBox[this.pageNum - 1] as MovieClip).y;
               this.setChildIndex(selectedBoxIcon,this.numChildren - 1);
               selectedBoxIcon.visible = true;
               break;
            }
         }
      }
      
      public function setSummonPet(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         obf_j_L_3395.visible = false;
         this.obf_0_2_8_564 = param1;
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         var _loc2_:IconItemBag = this.getPetBagById(param1);
         if(!_loc2_)
         {
            return;
         }
         for each(_loc3_ in this.bagsBox[this.pageNum - 1])
         {
            if(_loc3_ == _loc2_.bagMC)
            {
               obf_j_L_3395.x = _loc2_.x + (this.bagsBox[this.pageNum - 1] as MovieClip).x;
               obf_j_L_3395.y = _loc2_.y + (this.bagsBox[this.pageNum - 1] as MovieClip).y;
               this.setChildIndex(obf_j_L_3395,this.numChildren - 1);
               obf_j_L_3395.visible = true;
               break;
            }
         }
      }
      
      private function onAddAttrPoint(param1:Event) : void
      {
         if(!this.obf_m_2_1291 || this.freeAttrPoint <= 0)
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
         if(!this.obf_m_2_1291)
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
      
      private function obf_U_y_3917() : void
      {
         if(!this.obf_m_2_1291)
         {
            return;
         }
         cmdPointOK.visible = cmdStrAddPoint.visible = cmdStrRemovePoint.visible = cmdAgiAddPoint.visible = cmdAgiRemovePoint.visible = cmdWigAddPoint.visible = cmdWisRemovePoint.visible = cmdVitAddPoint.visible = cmdVitRemovePoint.visible = this.obf_m_2_1291.freeAttrPt > 0;
         txtStrength.text = this.obf_m_2_1291.attributes.strength + this.strAdded + "";
         txtAgility.text = this.obf_m_2_1291.attributes.agility + this.agiAdded + "";
         txtWisdom.text = this.obf_m_2_1291.attributes.wisdom + this.wisAdded + "";
         txtVitality.text = this.obf_m_2_1291.attributes.vitality + this.vitAdded + "";
         txtAttrPoint.text = this.freeAttrPoint + "";
         cmdPointOK.enabled = this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded > 0;
      }
      
      public function showPetInfo(param1:PetFullInfo) : void
      {
         this.obf_m_2_1291 = param1;
         if(!param1)
         {
            this.obf_P_W_1972();
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.petCode);
         if(!_loc2_)
         {
            return;
         }
         this.freeAttrPoint = param1.freeAttrPt;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         cmdSummon.label = DiversityManager.getString("PetUI",param1.petId == this.obf_0_2_8_564 ? "cmdRecover" : "cmdSummon");
         txtName.text = param1.name;
         txtLevel.text = param1.level + "";
         txtItemType.text = JSONUtil.getStr(_loc2_,["name"]);
         txtType.text = PetKind.getKindName(JSONUtil.getInt(_loc2_,["properties","petKind"]));
         DiversityManager.setTextField(txtSex,"PetUI","petSex" + param1.sex,null,true);
         txtLoyalty.text = param1.loyalty + "";
         txtLife.text = param1.life + "";
         this.petMaxGrowth = obf_c_4686.getPetMaxGrowthRate(param1.petCode,param1);
         this.petGrowth = obf_c_4686.getPetGrowthRate(param1.attributes);
         if(this.petGrowth > this.petMaxGrowth)
         {
            this.petGrowth = this.petMaxGrowth;
         }
         txtGrowthRate.text = this.petGrowth.toFixed(1) + "/" + this.petMaxGrowth.toFixed(1);
         this.setPetExp(param1.exp);
         txtRace.text = MonsterSpecies.getSpeciesName(JSONUtil.getInt(_loc2_,["properties","species"]));
         txtRestraint.text = MonsterSpecies.getSpeciesName(MonsterSpecies.getRestraintSpecies(JSONUtil.getInt(_loc2_,["properties","species"])));
         txtRestraintModulus.text = obf_A_x_3023.getRateString(param1.attributes.subdueMul);
         DiversityManager.setTextField(txtGeneration,"PetUI","petGeneration",[param1.generation + "/" + JSONUtil.getInt(obf_c_4686.config,["fusion","maxFusion"])],true);
         txtEnhanceLevel.text = "+" + param1.enhanceLevel;
         txtAbsorbRatio.text = obf_A_x_3023.getRateString(param1.attributes.damageAbsorbRatio);
         txtHP.text = param1.hp + "/" + param1.attributes.hpMax;
         txtMP.text = param1.mp + "/" + param1.attributes.mpMax;
         txtPhysicalAttack.text = param1.attributes.physicalAttack + "";
         txtMagicAttack.text = param1.attributes.magicAttack + "";
         txtHitValue.text = param1.attributes.hitValue + "(+" + obf_A_x_3023.getRateString(param1.attributes.hitRate - 1) + ")";
         txtCritValue.text = param1.attributes.critValue + "(" + obf_A_x_3023.getRateString(param1.attributes.critRate) + ")";
         this.obf_U_y_3917();
         var _loc3_:PetAttributesInfo = obf_c_4686.getEnhanceAttributes(param1);
         var _loc4_:int = (param1.baseAttributes.strengthApt - JSONUtil.getInt(_loc2_,["properties","strengthAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","strengthAptMax"]) - JSONUtil.getInt(_loc2_,["properties","strengthAptMin"])) * 100;
         barStrengthApt.gotoAndStop(_loc4_);
         txtStrengthApt.htmlText = param1.baseAttributes.strengthApt + " <font color=\'#0098FF\'>+" + _loc3_.strengthApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.strengthApt + "</font>";
         var _loc5_:int = (param1.baseAttributes.agilityApt - JSONUtil.getInt(_loc2_,["properties","agilityAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","agilityAptMax"]) - JSONUtil.getInt(_loc2_,["properties","agilityAptMin"])) * 100;
         barAgilityApt.gotoAndStop(_loc5_);
         txtAgilityApt.htmlText = param1.baseAttributes.agilityApt + " <font color=\'#0098FF\'>+" + _loc3_.agilityApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.agilityApt + "</font>";
         var _loc6_:int = (param1.baseAttributes.wisdomApt - JSONUtil.getInt(_loc2_,["properties","wisdomAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","wisdomAptMax"]) - JSONUtil.getInt(_loc2_,["properties","wisdomAptMin"])) * 100;
         barWisdomApt.gotoAndStop(_loc6_);
         txtWisdomApt.htmlText = param1.baseAttributes.wisdomApt + " <font color=\'#0098FF\'>+" + _loc3_.wisdomApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.wisdomApt + "</font>";
         var _loc7_:int = (param1.baseAttributes.vitalityApt - JSONUtil.getInt(_loc2_,["properties","vitalityAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","vitalityAptMax"]) - JSONUtil.getInt(_loc2_,["properties","vitalityAptMin"])) * 100;
         barVitalityApt.gotoAndStop(_loc7_);
         txtVitalityApt.htmlText = param1.baseAttributes.vitalityApt + " <font color=\'#0098FF\'>+" + _loc3_.vitalityApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.vitalityApt + "</font>";
         this.showPetEquipment(param1);
         this.showPetSkill(param1);
         this.showPetFateSkill(param1);
         this.showPetImage(param1.petCode);
      }
      
      private function showPetImage(param1:String) : void
      {
         this.obf_W_N_2689();
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         this.petImage = new obf_t_T_3981(param1);
         this.petImage.x = 0;
         pointPetImage.addChild(this.petImage);
      }
      
      private function obf_W_N_2689() : void
      {
         while(pointPetImage.numChildren > 0)
         {
            pointPetImage.removeChildAt(0);
         }
         if(this.petImage)
         {
            this.petImage.destroy();
         }
         this.petImage = null;
      }
      
      public function showPetEquipment(param1:PetFullInfo) : void
      {
         var _loc2_:EquippedItemInfo = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:IconItem = null;
         this.obf_D_t_4380();
         for each(_loc2_ in param1.equipment)
         {
            _loc3_ = this.petEquipMap[_loc2_.equipmentKind];
            if(_loc3_)
            {
               _loc4_ = IconItemManager.getIconItemByCode(_loc2_.equipment.itemCode,_loc2_.equipment.itemId);
               if(_loc4_)
               {
                  _loc3_.pushIconItem(_loc4_);
               }
            }
         }
      }
      
      public function showPetSkill(param1:PetFullInfo) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:LevelOpenBoxIcon = null;
         var _loc9_:obf_s_Q_3016 = null;
         var _loc10_:PetSkillSlot = null;
         var _loc11_:DisplayObject = null;
         for each(_loc2_ in this.skillOpenIconList)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         this.skillOpenIconList = new Array();
         this.defSkillBag.dropIconItem();
         _loc3_ = GameItemManager.getItemConfig(param1.petCode);
         this.defSkillBag.pushIconItem(IconItemSkill.getNewIconItem(JSONUtil.getStr(_loc3_,["properties","defSkill"]),1));
         _loc4_ = new Array();
         _loc5_ = JSONUtil.getObject(obf_c_4686.config,["levelUpSkillSlot"]) as Array;
         for each(_loc6_ in _loc5_)
         {
            if(param1.level < _loc6_)
            {
               _loc8_ = new LevelOpenBoxIcon();
               DiversityManager.setTextField(_loc8_.txt,"PetUI","petBagLevelOpen",[_loc6_],true);
               _loc4_.push(_loc8_);
            }
         }
         _loc7_ = 0;
         while(_loc7_ < this.petSkillBoxList.length)
         {
            _loc9_ = this.petSkillBoxList[_loc7_];
            if(_loc9_)
            {
               _loc9_.obf_L_t_4155();
               _loc10_ = JSONUtil.getObject(param1.learnedSkillList,[_loc7_]) as PetSkillSlot;
               if(_loc10_)
               {
                  _loc9_.setSkill(_loc10_.skillCode,_loc10_.skillLevel);
               }
               _loc9_.iconBag.isLocked = _loc7_ > param1.openedSkillNum - 1;
               if(_loc9_.iconBag.isLocked)
               {
                  if(_loc4_.length > 0)
                  {
                     _loc11_ = _loc4_.shift();
                  }
                  else
                  {
                     _loc11_ = new OpenBoxIcon();
                  }
                  if(_loc11_)
                  {
                     if(_loc11_ is InteractiveObject)
                     {
                        (_loc11_ as InteractiveObject).mouseEnabled = false;
                     }
                     _loc11_.x = _loc9_.x;
                     _loc11_.y = _loc9_.y;
                     pointSkill.addChild(_loc11_);
                     this.skillOpenIconList.push(_loc11_);
                  }
               }
            }
            _loc7_++;
         }
      }
      
      private function showFateSkillTooltip(param1:Event) : void
      {
         if(!this.obf_m_2_1291 || !this.obf_D_B_3820)
         {
            return;
         }
         var _loc2_:int = int(this.obf_D_B_3820[param1.currentTarget.name]);
         var _loc3_:Object = SkillConfig.getSkillConfig(param1.currentTarget.name);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:GameTipUI = new GameTipUI("PetFateSkill");
         ConditionScript.petInfoForCondition = this.obf_m_2_1291;
         obf_l_l_940.obf_O_c_2215(_loc4_,220,param1.currentTarget.name,_loc2_ - 1);
         _loc4_.addTipInfo("<p align=\'center\'><font color=\'#00FF00\'>" + DiversityManager.getString("PlayerSkillPrompt","nextSkillLevel") + "</font></p>",220,_loc4_.maxRow + 1);
         _loc4_.addTipInfo("",180,_loc4_.maxRow + 1);
         ConditionScript.petInfoForCondition = this.obf_m_2_1291;
         obf_l_l_940.obf_O_c_2215(_loc4_,220,param1.currentTarget.name,_loc2_);
         GameTipManager.showTip(_loc4_);
      }
      
      private function closeFateSkillTooltip(param1:Event) : void
      {
         GameTipManager.closeTip("PetFateSkill");
      }
      
      private function obf_H_S_2962(param1:Event) : void
      {
         var _loc7_:String = null;
         var _loc8_:IconItemBag = null;
         var _loc9_:IconItem = null;
         if(!this.obf_m_2_1291)
         {
            return;
         }
         this.obf_u_s_1655();
         var _loc2_:Object = SkillConfig.getSkillConfig(param1.currentTarget.name);
         if(!_loc2_ || !this.obf_D_B_3820)
         {
            return;
         }
         var _loc3_:int = int(this.obf_D_B_3820[param1.currentTarget.name]);
         if(_loc3_ >= _loc2_.levelInfo.length)
         {
            return;
         }
         this.obf_l_M_1543 = param1.currentTarget.name;
         var _loc4_:Object = PlayerSkillManager.getUpSkillCondition(this.obf_l_M_1543,_loc3_ + 1);
         var _loc5_:Object = PlayerSkillManager.getPetUpSkillCondition(this.obf_l_M_1543,_loc3_ + 1);
         txtFateName.text = _loc2_.name + " Lv" + _loc3_;
         txtFatePetLevel.text = JSONUtil.getStr(_loc5_,["petLevel>="]);
         pointFateGold.addChild(obf_a_f_2935.getGoldDisplay(_loc4_["gold>="]));
         var _loc6_:int = 0;
         for(_loc7_ in _loc4_["equalItemsInBag"])
         {
            if(_loc6_ >= this.obf_M_M_1358.length)
            {
               break;
            }
            _loc8_ = this.obf_M_M_1358[_loc6_];
            _loc9_ = IconItemManager.getIconItemByCode(_loc7_,"");
            _loc9_.itemCount = _loc4_["equalItemsInBag"][_loc7_];
            _loc8_.pushIconItem(_loc9_);
            _loc6_++;
         }
      }
      
      private function obf_u_s_1655() : void
      {
         var _loc1_:IconItemBag = null;
         txtFateName.text = "";
         txtFatePetLevel.text = "";
         while(pointFateGold.numChildren > 0)
         {
            pointFateGold.removeChildAt(0);
         }
         for each(_loc1_ in this.obf_M_M_1358)
         {
            _loc1_.dropIconItem();
         }
      }
      
      private function obf_r_n_1499(param1:Event) : void
      {
         if(!this.obf_m_2_1291 || obf_L_l_4100.isEmpty(this.obf_l_M_1543))
         {
            return;
         }
         var _loc2_:Object = SkillConfig.getSkillConfig(this.obf_l_M_1543);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = int(this.obf_D_B_3820[this.obf_l_M_1543]);
         if(_loc3_ >= _loc2_.levelInfo.length)
         {
            return;
         }
         ConditionScript.petInfoForCondition = this.obf_m_2_1291;
         if(!ConditionScript.checkCondition(PlayerSkillManager.getUpSkillCondition(this.obf_l_M_1543,_loc3_ + 1),null,true))
         {
            return;
         }
         ConditionScript.petInfoForCondition = this.obf_m_2_1291;
         if(!ConditionScript.checkCondition(PlayerSkillManager.getPetUpSkillCondition(this.obf_l_M_1543,_loc3_ + 1),null,true))
         {
            return;
         }
         obf_c_4686.sendPetLearnSkill(this.obf_m_2_1291.petId,this.obf_l_M_1543,PlayerSkillManager.obf_0_9_S_645);
      }
      
      public function showPetFateSkill(param1:PetFullInfo) : void
      {
         var _loc2_:PetSkillSlot = null;
         var _loc3_:MovieClip = null;
         this.clearPetFateSkill();
         this.obf_D_B_3820 = new Object();
         for each(_loc2_ in param1.fateSkillList)
         {
            this.obf_D_B_3820[_loc2_.skillCode] = _loc2_.skillLevel;
            _loc3_ = this.obf_0_4_l_705[_loc2_.skillCode];
            if(Boolean(_loc3_) && Boolean(_loc3_.txtLevel))
            {
               _loc3_.txtLevel.text = _loc2_.skillLevel + "";
            }
         }
      }
      
      public function clearPetFateSkill() : void
      {
         var _loc1_:String = null;
         var _loc2_:IconItemBag = null;
         var _loc3_:MovieClip = null;
         this.obf_D_B_3820 = null;
         this.obf_l_M_1543 = "";
         for(_loc1_ in this.obf_0_4_l_705)
         {
            _loc3_ = this.obf_0_4_l_705[_loc1_];
            if(_loc3_)
            {
               if(_loc3_.txtLevel)
               {
                  _loc3_.txtLevel.text = "";
               }
            }
         }
         txtFateName.text = "";
         txtFatePetLevel.text = "";
         while(pointFateGold.numChildren > 0)
         {
            pointFateGold.removeChildAt(0);
         }
         for each(_loc2_ in this.obf_M_M_1358)
         {
            _loc2_.dropIconItem();
         }
      }
      
      public function obf_P_W_1972() : void
      {
         cmdSummon.label = DiversityManager.getString("PetUI","cmdSummon");
         this.freeAttrPoint = 0;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         txtName.text = "";
         txtLevel.text = "";
         txtType.text = "";
         txtItemType.text = "";
         txtSex.text = "";
         txtLoyalty.text = "";
         txtLife.text = "";
         txtGrowthRate.text = "";
         this.setPetExp(0);
         txtRace.text = "";
         txtRestraint.text = "";
         txtRestraintModulus.text = "";
         txtGeneration.text = "";
         txtEnhanceLevel.text = "";
         txtAbsorbRatio.text = "";
         txtExp.text = "";
         txtHP.text = "";
         txtMP.text = "";
         txtPhysicalAttack.text = "";
         txtMagicAttack.text = "";
         txtHitValue.text = "";
         txtCritValue.text = "";
         txtStrength.text = "";
         txtAgility.text = "";
         txtWisdom.text = "";
         txtVitality.text = "";
         txtAttrPoint.text = "";
         txtStrengthApt.text = "";
         txtAgilityApt.text = "";
         txtWisdomApt.text = "";
         txtVitalityApt.text = "";
         barStrengthApt.gotoAndStop(1);
         barAgilityApt.gotoAndStop(1);
         barWisdomApt.gotoAndStop(1);
         barVitalityApt.gotoAndStop(1);
         this.obf_D_t_4380();
         this.obf_K_W_4439();
         this.clearPetFateSkill();
         this.obf_W_N_2689();
      }
      
      public function obf_K_W_4439() : void
      {
         var _loc1_:obf_s_Q_3016 = null;
         this.defSkillBag.dropIconItem();
         for each(_loc1_ in this.petSkillBoxList)
         {
            if(_loc1_)
            {
               _loc1_.obf_L_t_4155();
            }
         }
      }
      
      public function obf_D_t_4380() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.petEquipBags)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function setPetExp(param1:int) : void
      {
         var _loc2_:int = JSONUtil.getInt(this.obf_m_2_1291,["level"],1);
         var _loc3_:int = obf_c_4686.getPetLevelUpExp(_loc2_);
         txtExp.text = param1 + "/" + _loc3_;
         var _loc4_:int = Number(param1 / _loc3_) * 100;
         barExp.gotoAndStop(_loc4_);
      }
      
      public function getItemCount(param1:String) : int
      {
         var _loc4_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.petBags.length)
         {
            _loc4_ = this.petBags[_loc3_];
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
         while(_loc4_ < this.petBags.length)
         {
            _loc5_ = this.petBags[_loc4_];
            if(Boolean(_loc5_.haveIconItem) && (_loc5_.haveIconItem.itemCode == param1 || _loc5_.haveIconItem.itemCode == _loc3_))
            {
               _loc2_ += _loc5_.haveIconItem.itemCount;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function hasAnyItem(param1:Array) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.petBags.length)
         {
            _loc3_ = this.petBags[_loc2_];
            if(Boolean(_loc3_.haveIconItem) && param1.indexOf(_loc3_.haveIconItem.itemCode) > -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.petBags)
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
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function getPetIconItemBags() : Array
      {
         return this.petBags;
      }
      
      public function getIconItemBags() : Array
      {
         return this.obf_a_v_4592;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:obf_s_Q_3016 = null;
         this.removeListener();
         for each(_loc1_ in this.petBags)
         {
            _loc1_.destroy();
         }
         while(pointSkill.numChildren > 0)
         {
            _loc2_ = pointSkill.getChildAt(0) as obf_s_Q_3016;
            if(_loc2_)
            {
               _loc2_.destroy();
            }
            pointSkill.removeChildAt(0);
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:ItemPlayerPetInfo = null;
         if(param1.isLocked)
         {
            if(this.petBags.indexOf(param1) > -1)
            {
               ButtonToItemManager.useBTIById("addPetBag");
            }
            if(!obf_L_l_4100.isEmpty(this.obf_e_L_778) && this.petSkillBags.indexOf(param1) > -1)
            {
               ButtonToItemManager.useBTIById("addPetSkillBag",{"petId":this.obf_e_L_778});
            }
         }
         if(Boolean(param1.haveIconItem) && param3)
         {
            _loc4_ = JSONUtil.getObject(GameItemInfoManager.getItemInfo(param1.haveIconItem.itemId),["petInfo"]) as ItemPlayerPetInfo;
            if(!_loc4_)
            {
               return;
            }
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,_loc4_.name,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
         if(!param1.isLocked && Boolean(param1.haveIconItem))
         {
            obf_c_4686.sendViewPet(param1.haveIconItem.itemId);
            obf_K_e_3075.closeUI(obf_K_e_3075.petAssembleBoxUI);
            obf_K_e_3075.closeUI(obf_K_e_3075.petEnhanceUI);
            obf_K_e_3075.closeUI(obf_K_e_3075.petFusionUI);
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(Boolean(this.obf_O_O_3039) && Boolean(param1.haveIconItem) && this.petEquipBags.indexOf(param1) > -1)
         {
            obf_c_4686.sendRemovePetEquipment(this.obf_O_O_3039.petId,int(param1.id),PlayerBagIndex.PLAYER_MAIN_BAG);
         }
         if(Boolean(!param1.isLocked) && Boolean(param1.haveIconItem) && this.petBags.indexOf(param1) > -1)
         {
            param1.haveIconItem.useIcon();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this.obf_O_O_3039 && param2 is IconItemEquip) && Boolean(param3.parentIconUI == obf_K_e_3075.playerBagUI) && this.petEquipBags.indexOf(param1) > -1)
         {
            param3.haveIconItem.useIcon(this.obf_O_O_3039);
         }
         if(this.petBags.indexOf(param1) > -1 && this.petBags.indexOf(param3) > -1)
         {
            if(GameContext.bagItemManager)
            {
               GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.PLAYER_PET_BAG);
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         var _loc4_:Object = null;
         if(Boolean(this.obf_O_O_3039 && param3 == obf_K_e_3075.playerBagUI) && Boolean(param1.haveIconItem) && this.petEquipBags.indexOf(param1) > -1)
         {
            obf_c_4686.sendRemovePetEquipment(this.obf_O_O_3039.petId,int(param1.id),PlayerBagIndex.PLAYER_MAIN_BAG);
         }
         if(Boolean(this.obf_O_O_3039 && param3 != obf_K_e_3075.playerBagUI) && Boolean(param1.haveIconItem) && this.petEquipBags.indexOf(param1) > -1)
         {
            return;
         }
         if(param3 == null && Boolean(param1.haveIconItem))
         {
            _loc4_ = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
            if(_loc4_.dropMode == 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","cantDrop"));
            }
            else if(_loc4_.dropMode == 1)
            {
               GameContext.bagItemManager.sendDropItem(PlayerBagIndex.PLAYER_PET_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY));
            }
            else if(_loc4_.dropMode == 2)
            {
               WindowManager.showConfirmBox(DiversityManager.getString("PetUI","petPrompt_ConfirmDropPet"),this.confirmReleasePet,[PlayerBagIndex.PLAYER_PET_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
            }
         }
      }
      
      public function confirmReleasePet(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendDropItem.apply(null,param1.par);
         }
      }
   }
}

