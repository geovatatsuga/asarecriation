package com.sunweb.game.rpg.playerUI.pet
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
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.netRole.obf_t_T_3981;
   import com.sunweb.game.rpg.pet.ItemPlayerPetInfo;
   import com.sunweb.game.rpg.pet.PetAttributesInfo;
   import com.sunweb.game.rpg.pet.PetKind;
   import com.sunweb.game.rpg.pet.PetSkillSlot;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.world.MonsterSpecies;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PetViewBoxUIMC;
   
   public class obf_L_F_3928 extends PetViewBoxUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      private var _petId:String;
      
      private var _petCode:String;
      
      private var _petInfo:ItemPlayerPetInfo;
      
      private var petImage:obf_t_T_3981;
      
      private var timeInv:TimeLimiter;
      
      public function obf_L_F_3928(param1:String, param2:String)
      {
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         this.timeInv = new TimeLimiter(1000);
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this._petCode = param1;
         this._petId = param2;
         barExp.gotoAndStop(1);
         barStrengthApt.gotoAndStop(1);
         barAgilityApt.gotoAndStop(1);
         barWisdomApt.gotoAndStop(1);
         barVitalityApt.gotoAndStop(1);
         this._bags = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = this["bag" + _loc3_];
            if(_loc4_)
            {
               _loc5_ = new IconItemBag(_loc4_,this,_loc3_);
               _loc5_.addValidType(GameItemType.SKILL);
               _loc5_.lockDrag = true;
               this._bags.push(_loc5_);
            }
            _loc3_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PetUI","txtTitle");
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
         DiversityManager.setTextField(txtDeyStrengthApt,"PetUI","txtStrengthApt");
         DiversityManager.setTextField(txtDeyAgilityApt,"PetUI","txtAgilityApt");
         DiversityManager.setTextField(txtDeyWisdomApt,"PetUI","txtWisdomApt");
         DiversityManager.setTextField(txtDeyVitalityApt,"PetUI","txtVitalityApt");
         DiversityManager.setTextField(txtDeyAttrPoint,"PetUI","txtAttrPoint");
         DiversityManager.setTextField(txtDeyAbsorbRatio,"PetUI","txtAbsorbRatio");
         DiversityManager.setTextField(txtDeyHP,"PetUI","txtHP");
         DiversityManager.setTextField(txtDeyMP,"PetUI","txtMP");
         DiversityManager.setTextField(txtDeyPhysicalAttack,"PetUI","txtPhysicalAttack");
         DiversityManager.setTextField(txtDeyMagicAttack,"PetUI","txtMagicAttack");
         DiversityManager.setTextField(txtDeyHitValue,"PetUI","txtHitValue");
         DiversityManager.setTextField(txtDeyCritValue,"PetUI","txtCritValue");
         DiversityManager.setTextField(txtDeyPetSkill,"PetUI","txtPetSkill");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:GameItemFullInfo = null;
         if(!this.timeInv.checkTimeout())
         {
            return;
         }
         if(this.petImage)
         {
            this.petImage.onUpdate();
            this.petImage.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
         if(!this._petInfo)
         {
            _loc2_ = GameItemInfoManager.getItemInfo(this._petId);
            if(_loc2_)
            {
               this._petInfo = _loc2_.petInfo;
               this.showPetInfo(this._petInfo);
            }
         }
      }
      
      private function showPetInfo(param1:ItemPlayerPetInfo) : void
      {
         var _loc2_:Object = GameItemManager.getItemConfig(this._petCode);
         if(!_loc2_)
         {
            return;
         }
         txtName.text = param1.name;
         txtLevel.text = param1.level + "";
         txtItemType.text = JSONUtil.getStr(_loc2_,["name"]);
         txtType.text = PetKind.getKindName(JSONUtil.getInt(_loc2_,["properties","petKind"]));
         DiversityManager.setTextField(txtSex,"PetUI","petSex" + param1.sex,null,true);
         txtLoyalty.text = param1.loyalty + "";
         txtLife.text = param1.life + "";
         var _loc3_:Number = obf_c_4686.getPetMaxGrowthRate(this._petCode,param1);
         txtGrowthRate.text = obf_c_4686.getPetGrowthRate(param1.attributes).toFixed(1) + "/" + _loc3_.toFixed(1);
         this.setPetExp(param1.exp);
         txtRace.text = MonsterSpecies.getSpeciesName(JSONUtil.getInt(_loc2_,["properties","species"]));
         txtRestraint.text = MonsterSpecies.getSpeciesName(MonsterSpecies.getRestraintSpecies(JSONUtil.getInt(_loc2_,["properties","species"])));
         txtRestraintModulus.text = obf_A_x_3023.getRateString(param1.attributes.subdueMul);
         DiversityManager.setTextField(txtGeneration,"PetUI","petGeneration",[param1.generation],true);
         txtEnhanceLevel.text = "+" + param1.enhanceLevel;
         txtAbsorbRatio.text = obf_A_x_3023.getRateString(param1.attributes.damageAbsorbRatio);
         txtHP.text = param1.hp + "/" + param1.attributes.hpMax;
         txtMP.text = param1.mp + "/" + param1.attributes.mpMax;
         txtPhysicalAttack.text = param1.attributes.physicalAttack + "";
         txtMagicAttack.text = param1.attributes.magicAttack + "";
         txtHitValue.text = param1.attributes.hitValue + "(+" + obf_A_x_3023.getRateString(param1.attributes.hitRate - 1) + ")";
         txtCritValue.text = param1.attributes.critValue + "(" + obf_A_x_3023.getRateString(param1.attributes.critRate) + ")";
         txtStrength.text = param1.attributes.strength + "";
         txtAgility.text = param1.attributes.agility + "";
         txtWisdom.text = param1.attributes.wisdom + "";
         txtVitality.text = param1.attributes.vitality + "";
         txtAttrPoint.text = param1.freeAttrPt + "";
         var _loc4_:PetAttributesInfo = obf_c_4686.getEnhanceAttributes(param1);
         var _loc5_:int = (param1.baseAttributes.strengthApt - JSONUtil.getInt(_loc2_,["properties","strengthAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","strengthAptMax"]) - JSONUtil.getInt(_loc2_,["properties","strengthAptMin"])) * 100;
         barStrengthApt.gotoAndStop(_loc5_);
         txtStrengthApt.htmlText = param1.baseAttributes.strengthApt + " <font color=\'#0098FF\'>+" + _loc4_.strengthApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.strengthApt + "</font>";
         var _loc6_:int = (param1.baseAttributes.agilityApt - JSONUtil.getInt(_loc2_,["properties","agilityAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","agilityAptMax"]) - JSONUtil.getInt(_loc2_,["properties","agilityAptMin"])) * 100;
         barAgilityApt.gotoAndStop(_loc6_);
         txtAgilityApt.htmlText = param1.baseAttributes.agilityApt + " <font color=\'#0098FF\'>+" + _loc4_.agilityApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.agilityApt + "</font>";
         var _loc7_:int = (param1.baseAttributes.wisdomApt - JSONUtil.getInt(_loc2_,["properties","wisdomAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","wisdomAptMax"]) - JSONUtil.getInt(_loc2_,["properties","wisdomAptMin"])) * 100;
         barWisdomApt.gotoAndStop(_loc7_);
         txtWisdomApt.htmlText = param1.baseAttributes.wisdomApt + " <font color=\'#0098FF\'>+" + _loc4_.wisdomApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.wisdomApt + "</font>";
         var _loc8_:int = (param1.baseAttributes.vitalityApt - JSONUtil.getInt(_loc2_,["properties","vitalityAptMin"])) / (JSONUtil.getInt(_loc2_,["properties","vitalityAptMax"]) - JSONUtil.getInt(_loc2_,["properties","vitalityAptMin"])) * 100;
         barVitalityApt.gotoAndStop(_loc8_);
         txtVitalityApt.htmlText = param1.baseAttributes.vitalityApt + " <font color=\'#0098FF\'>+" + _loc4_.vitalityApt + "</font><font color=\'#FF00FF\'>+" + param1.fusionAttributes.vitalityApt + "</font>";
         this.showPetSkill(param1);
         this.showPetImage(this._petCode);
      }
      
      private function showPetImage(param1:String) : void
      {
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         this.petImage = new obf_t_T_3981(param1);
         this.petImage.x = 0;
         pointPetImage.addChild(this.petImage);
      }
      
      private function showPetSkill(param1:ItemPlayerPetInfo) : void
      {
         var _loc3_:PetSkillSlot = null;
         var _loc6_:PetSkillSlot = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItemSkill = null;
         var _loc2_:Object = GameItemManager.getItemConfig(this._petCode);
         if(_loc2_)
         {
            _loc3_ = new PetSkillSlot();
            _loc3_.skillCode = JSONUtil.getStr(_loc2_,["properties","defSkill"]);
            _loc3_.skillLevel = 1;
         }
         var _loc4_:Array = param1.learnedSkillList.concat();
         _loc4_.unshift(_loc3_);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length && _loc5_ < this._bags.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = this._bags[_loc5_];
            if(!(!_loc6_ || !_loc7_))
            {
               _loc8_ = IconItemSkill.getNewIconItem(_loc6_.skillCode,_loc6_.skillLevel);
               if(_loc8_)
               {
                  _loc7_.pushIconItem(_loc8_);
               }
            }
            _loc5_++;
         }
      }
      
      public function setPetExp(param1:int) : void
      {
         var _loc2_:int = JSONUtil.getInt(this._petInfo,["level"],1);
         var _loc3_:int = obf_c_4686.getPetLevelUpExp(_loc2_);
         txtExp.text = param1 + "/" + _loc3_;
         var _loc4_:int = Number(param1 / _loc3_) * 100;
         barExp.gotoAndStop(_loc4_);
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
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
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

