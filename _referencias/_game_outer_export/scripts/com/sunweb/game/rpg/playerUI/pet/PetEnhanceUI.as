package com.sunweb.game.rpg.playerUI.pet
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.obf_U_N_1827;
   import com.sunweb.game.rpg.pet.PetAttributesInfo;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PetEnhanceUIMC;
   
   public class PetEnhanceUI extends PetEnhanceUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var petBag:IconItemBag;
      
      private var costItemBag:IconItemBag;
      
      private var obf_m_F_1959:String;
      
      private var obf_i_y_3445:String;
      
      private var obf_m_2_1291:PetFullInfo;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      public function PetEnhanceUI()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = 200;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.bags = new Array();
         this.petBag = new IconItemBag(barPet,this,0);
         this.petBag.lockDrag = true;
         this.petBag.addValidType(GameItemType.PET);
         this.bags.push(this.petBag);
         this.costItemBag = new IconItemBag(barCostItem,this,0);
         this.costItemBag.lockDrag = true;
         this.costItemBag.addValidType(GameItemType.ALL);
         this.bags.push(this.costItemBag);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PetEnhanceUI","txtTitle");
         DiversityManager.setTextField(txtDeyBeforeEnhance,"PetEnhanceUI","txtBeforeEnhance");
         DiversityManager.setTextField(txtDeyAfterEnhance,"PetEnhanceUI","txtAfterEnhance");
         DiversityManager.setTextField(txtDeyStrengthApt,"PetEnhanceUI","txtStrengthApt");
         DiversityManager.setTextField(txtDeyStrengthAptAfter,"PetEnhanceUI","txtStrengthAptAfter");
         DiversityManager.setTextField(txtDeyAgilityApt,"PetEnhanceUI","txtAgilityApt");
         DiversityManager.setTextField(txtDeyAgilityAptAfter,"PetEnhanceUI","txtAgilityAptAfter");
         DiversityManager.setTextField(txtDeyWisdomApt,"PetEnhanceUI","txtWisdomApt");
         DiversityManager.setTextField(txtDeyWisdomAptAfter,"PetEnhanceUI","txtWisdomAptAfter");
         DiversityManager.setTextField(txtDeyVitalityApt,"PetEnhanceUI","txtVitalityApt");
         DiversityManager.setTextField(txtDeyVitalityAptAfter,"PetEnhanceUI","txtVitalityAptAfter");
         DiversityManager.setTextField(txtDeyPet,"PetEnhanceUI","txtPet");
         DiversityManager.setTextField(txtDeyCostItem,"PetEnhanceUI","txtCostItem");
         DiversityManager.setTextField(txtDeyChance,"PetEnhanceUI","txtChance");
         cmdEnhance.label = DiversityManager.getString("PetEnhanceUI","cmdEnhance");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdEnhance.addEventListener(MouseEvent.CLICK,this.obf_S_9_1151);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdEnhance.removeEventListener(MouseEvent.CLICK,this.obf_S_9_1151);
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
         if(!this.timeInv.checkTimeout())
         {
            return;
         }
         if(!obf_L_l_4100.isEmpty(this.obf_m_F_1959) && !obf_L_l_4100.isEmpty(this.obf_i_y_3445) && this.obf_m_2_1291 == null)
         {
            this.obf_m_2_1291 = obf_c_4686.getPetFullInfo(this.obf_m_F_1959);
            if(this.obf_m_2_1291)
            {
               this.showPetEnhance(this.obf_m_2_1291);
            }
         }
      }
      
      public function setPetToEnhance(param1:String, param2:String) : void
      {
         this.obf_B_A_1617();
         this.obf_m_F_1959 = param1;
         this.obf_i_y_3445 = param2;
         var _loc3_:obf_U_N_1827 = obf_U_N_1827.getNewIconItem(param2,param1);
         if(_loc3_)
         {
            this.petBag.pushIconItem(_loc3_);
         }
      }
      
      private function obf_S_9_1151(param1:Event) : void
      {
         if(!this.obf_m_2_1291)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","getItemInfo"));
            return;
         }
         var _loc2_:Object = obf_c_4686.getPetEnhanceLevelConfig(this.obf_m_2_1291.enhanceLevel);
         if(!ConditionScript.checkCondition(_loc2_.condition,null,true))
         {
            return;
         }
         if(!ConditionScript.checkCondition({"equalItemsInBag":_loc2_.costItems},null,true))
         {
            return;
         }
         if(!ConditionScript.checkCondition({"gold>=":_loc2_.costGold},null,true))
         {
            return;
         }
         obf_c_4686.sendPetEnhance(this.obf_m_2_1291.petId,this.obf_m_2_1291.enhanceLevel);
      }
      
      public function showPetEnhance(param1:PetFullInfo) : void
      {
         var _loc5_:String = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Object = null;
         var _loc13_:IconItem = null;
         if(!param1)
         {
            return;
         }
         if(param1.enhanceLevel >= JSONUtil.getInt(obf_c_4686.config,["enhance","enhanceLevelArray","length"]))
         {
            DiversityManager.setTextField(txtPetEnhance,"PetEnhanceUI","maxEnhanceLevel",null,true);
            return;
         }
         this.obf_m_2_1291 = param1;
         var _loc2_:Object = JSONUtil.getObject(obf_c_4686.config,["enhance"]);
         var _loc3_:obf_U_N_1827 = obf_U_N_1827.getNewIconItem(param1.petCode,param1.petId);
         if(!_loc3_ || !_loc2_)
         {
            return;
         }
         this.petBag.pushIconItem(_loc3_);
         cmdEnhance.enabled = true;
         txtPetEnhance.text = "+" + param1.enhanceLevel;
         var _loc4_:Object = obf_c_4686.getPetEnhanceLevelConfig(param1.enhanceLevel);
         var _loc14_:int = 0;
         var _loc15_:* = _loc4_.costItems;
         for(_loc5_ in _loc15_)
         {
            _loc13_ = IconItemManager.getIconItemByCode(_loc5_,"");
            if(_loc13_)
            {
               _loc13_.itemCount = _loc4_.costItems[_loc5_];
               this.costItemBag.pushIconItem(_loc13_);
            }
         }
         _loc6_ = obf_a_f_2935.getGoldDisplay(_loc4_.costGold);
         _loc6_.x = -(_loc6_.width / 2);
         pointCostGold.addChild(_loc6_);
         txtEnhanceChance.text = obf_A_x_3023.getRateString(_loc4_.enhanceChance);
         _loc7_ = GameItemManager.getItemConfig(param1.petCode);
         if(!_loc7_)
         {
            return;
         }
         var _loc8_:PetAttributesInfo = obf_c_4686.getSkillAttributes(param1);
         var _loc9_:int = (param1.baseAttributes.strengthApt - JSONUtil.getInt(_loc7_,["properties","strengthAptMin"])) / (JSONUtil.getInt(_loc7_,["properties","strengthAptMax"]) - JSONUtil.getInt(_loc7_,["properties","strengthAptMin"])) * 100;
         barStrengthApt.gotoAndStop(_loc9_);
         barStrengthAptAfter.gotoAndStop(_loc9_);
         txtStrengthApt.text = param1.baseAttributes.strengthApt + " +" + (_loc8_.strengthApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.strengthApt));
         txtStrengthAptAfter.text = param1.baseAttributes.strengthApt + " +" + (_loc8_.strengthApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel + 1,param1.baseAttributes.strengthApt));
         var _loc10_:int = (param1.baseAttributes.agilityApt - JSONUtil.getInt(_loc7_,["properties","agilityAptMin"])) / (JSONUtil.getInt(_loc7_,["properties","agilityAptMax"]) - JSONUtil.getInt(_loc7_,["properties","agilityAptMin"])) * 100;
         barAgilityApt.gotoAndStop(_loc10_);
         barAgilityAptAfter.gotoAndStop(_loc10_);
         txtAgilityApt.text = param1.baseAttributes.agilityApt + " +" + (_loc8_.agilityApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.agilityApt));
         txtAgilityAptAfter.text = param1.baseAttributes.agilityApt + " +" + (_loc8_.agilityApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel + 1,param1.baseAttributes.agilityApt));
         var _loc11_:int = (param1.baseAttributes.wisdomApt - JSONUtil.getInt(_loc7_,["properties","wisdomAptMin"])) / (JSONUtil.getInt(_loc7_,["properties","wisdomAptMax"]) - JSONUtil.getInt(_loc7_,["properties","wisdomAptMin"])) * 100;
         barWisdomApt.gotoAndStop(_loc11_);
         barWisdomAptAfter.gotoAndStop(_loc11_);
         txtWisdomApt.text = param1.baseAttributes.wisdomApt + " +" + (_loc8_.wisdomApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.wisdomApt));
         txtWisdomAptAfter.text = param1.baseAttributes.wisdomApt + " +" + (_loc8_.wisdomApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel + 1,param1.baseAttributes.wisdomApt));
         var _loc12_:int = (param1.baseAttributes.vitalityApt - JSONUtil.getInt(_loc7_,["properties","vitalityAptMin"])) / (JSONUtil.getInt(_loc7_,["properties","vitalityAptMax"]) - JSONUtil.getInt(_loc7_,["properties","vitalityAptMin"])) * 100;
         barVitalityApt.gotoAndStop(_loc12_);
         barVitalityAptAfter.gotoAndStop(_loc12_);
         txtVitalityApt.text = param1.baseAttributes.vitalityApt + " +" + (_loc8_.vitalityApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.vitalityApt));
         txtVitalityAptAfter.text = param1.baseAttributes.vitalityApt + " +" + (_loc8_.vitalityApt + obf_c_4686.getPetEnhanceAptUpValue(param1.enhanceLevel + 1,param1.baseAttributes.vitalityApt));
      }
      
      public function obf_B_A_1617() : void
      {
         this.obf_m_2_1291 = null;
         this.obf_m_F_1959 = "";
         this.obf_i_y_3445 = "";
         cmdEnhance.enabled = false;
         this.petBag.dropIconItem();
         txtPetEnhance.text = "";
         txtEnhanceChance.text = "";
         this.costItemBag.dropIconItem();
         while(pointCostGold.numChildren > 0)
         {
            pointCostGold.removeChildAt(0);
         }
         barStrengthApt.gotoAndStop(1);
         barStrengthAptAfter.gotoAndStop(1);
         txtStrengthApt.text = "";
         txtStrengthAptAfter.text = "";
         barAgilityApt.gotoAndStop(1);
         barAgilityAptAfter.gotoAndStop(1);
         txtAgilityApt.text = "";
         txtAgilityAptAfter.text = "";
         barWisdomApt.gotoAndStop(1);
         barWisdomAptAfter.gotoAndStop(1);
         txtWisdomApt.text = "";
         txtWisdomAptAfter.text = "";
         barVitalityApt.gotoAndStop(1);
         barVitalityAptAfter.gotoAndStop(1);
         txtVitalityApt.text = "";
         txtVitalityAptAfter.text = "";
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
         this.obf_B_A_1617();
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

