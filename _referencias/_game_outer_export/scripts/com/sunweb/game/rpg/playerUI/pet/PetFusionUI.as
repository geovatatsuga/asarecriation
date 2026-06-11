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
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.obf_U_N_1827;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PetFusionUIMC;
   
   public class PetFusionUI extends PetFusionUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var mainPetBag:IconItemBag;
      
      private var subPetBag:IconItemBag;
      
      private var fusionItemBag:IconItemBag;
      
      private var fusionProtectBag:IconItemBag;
      
      private var mainPetInfo:GameItemFullInfo;
      
      private var mainPetConfig:Object;
      
      private var obf_I_h_4487:GameItemFullInfo;
      
      private var subPetConfig:Object;
      
      private var fusionValue:int;
      
      private var fusionConvert:int;
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      public function PetFusionUI()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.bags = new Array();
         this.mainPetBag = new IconItemBag(bagMainPet,this,0);
         this.mainPetBag.addValidType(GameItemType.PET);
         this.mainPetBag.lockDrag = true;
         this.bags.push(this.mainPetBag);
         this.subPetBag = new IconItemBag(bagSubPet,this,1);
         this.subPetBag.addValidType(GameItemType.PET);
         this.bags.push(this.subPetBag);
         this.fusionItemBag = new IconItemBag(bagFusionItem,this,2);
         this.fusionItemBag.addValidType(GameItemType.ALL);
         this.bags.push(this.fusionItemBag);
         this.fusionProtectBag = new IconItemBag(bagFusionProtect,this,3);
         this.fusionProtectBag.addValidType(GameItemType.ALL);
         this.bags.push(this.fusionProtectBag);
         this.obf_2_B_4604();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PetFusionUI","txtTitle");
         DiversityManager.setTextField(txtDeyMainPet,"PetFusionUI","txtMainPet");
         DiversityManager.setTextField(txtDeySubPet,"PetFusionUI","txtSubPet");
         DiversityManager.setTextField(txtDeyMainPetGrowth,"PetFusionUI","txtPetGrowth");
         DiversityManager.setTextField(txtDeySubPetGrowth,"PetFusionUI","txtPetGrowth");
         DiversityManager.setTextField(txtDeyMainPetSApt,"PetFusionUI","txtPetSApt");
         DiversityManager.setTextField(txtDeySubPetSApt,"PetFusionUI","txtPetSApt");
         DiversityManager.setTextField(txtDeyMainPetDApt,"PetFusionUI","txtPetDApt");
         DiversityManager.setTextField(txtDeySubPetDApt,"PetFusionUI","txtPetDApt");
         DiversityManager.setTextField(txtDeyMainPetWApt,"PetFusionUI","txtPetWApt");
         DiversityManager.setTextField(txtDeySubPetWApt,"PetFusionUI","txtPetWApt");
         DiversityManager.setTextField(txtDeyMainPetAApt,"PetFusionUI","txtPetAApt");
         DiversityManager.setTextField(txtDeySubPetAApt,"PetFusionUI","txtPetAApt");
         DiversityManager.setTextField(txtDeyGeneration,"PetFusionUI","txtGeneration");
         DiversityManager.setTextField(txtDeyFusion,"PetFusionUI","txtFusion");
         DiversityManager.setTextField(txtDeyConvert,"PetFusionUI","txtConvert");
         DiversityManager.setTextField(txtDeyFusionItem,"PetFusionUI","txtFusionItem");
         DiversityManager.setTextField(txtDeyProtect,"PetFusionUI","txtProtect");
         DiversityManager.setTextField(txtDeyFusionPrompt,"PetFusionUI","txtFusionPrompt");
         DiversityManager.setTextField(txtDeyProtectPrompt,"PetFusionUI","txtProtectPrompt");
         DiversityManager.setTextField(txtDeyChance,"PetFusionUI","txtChance");
         DiversityManager.setTextField(txtDeyPrompt,"PetFusionUI","txtPrompt");
         cmdFusion.label = DiversityManager.getString("PetFusionUI","cmdFusion");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUpFusionValue.addEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDbUpFusionValue.addEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDownFusionValue.addEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDbDownFusionValue.addEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdFusion.addEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdUpFusionValue.removeEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDbUpFusionValue.removeEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDownFusionValue.removeEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdDbDownFusionValue.removeEventListener(MouseEvent.CLICK,this.obf_h_B_3464);
         cmdFusion.removeEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
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
         if(this.timeInv.checkTimeout())
         {
            if(Boolean(this.mainPetBag.haveIconItem) && this.mainPetInfo == null)
            {
               this.mainPetInfo = GameItemInfoManager.getItemInfo(this.mainPetBag.haveIconItem.itemId);
               if(!this.mainPetInfo)
               {
                  GameContext.bagItemManager.sendViewItem(this.mainPetBag.haveIconItem.itemId);
               }
               this.showMainPetInfo();
               this.obf_s_x_1694();
            }
            if(Boolean(this.subPetBag.haveIconItem) && this.obf_I_h_4487 == null)
            {
               this.obf_I_h_4487 = GameItemInfoManager.getItemInfo(this.subPetBag.haveIconItem.itemId);
               if(!this.obf_I_h_4487)
               {
                  GameContext.bagItemManager.sendViewItem(this.subPetBag.haveIconItem.itemId);
               }
               this.showSubPetInfo();
               this.obf_s_x_1694();
            }
         }
      }
      
      public function showMainPetInfo() : void
      {
         if(!this.mainPetInfo || this.mainPetInfo.isEmpty)
         {
            return;
         }
         this.mainPetConfig = GameItemManager.getItemConfig(this.mainPetInfo.itemCode);
         var _loc1_:int = JSONUtil.getInt(obf_c_4686.config,["fusion","mainPetLevel"]);
         if(this.mainPetInfo.petInfo.level < _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_MainPetLevel",[_loc1_]));
            this.obf_0_1_4_232();
            this.obf_2_B_4604();
            return;
         }
         txtMainPetGrowth.text = obf_c_4686.getPetGrowthRate(this.mainPetInfo.petInfo.attributes).toFixed(1);
         txtMainPetSApt.text = this.mainPetInfo.petInfo.attributes.strengthApt + "";
         txtMainPetDApt.text = this.mainPetInfo.petInfo.attributes.agilityApt + "";
         txtMainPetWApt.text = this.mainPetInfo.petInfo.attributes.wisdomApt + "";
         txtMainPetAApt.text = this.mainPetInfo.petInfo.attributes.vitalityApt + "";
      }
      
      public function showSubPetInfo() : void
      {
         if(!this.obf_I_h_4487 || this.obf_I_h_4487.isEmpty)
         {
            return;
         }
         this.subPetConfig = GameItemManager.getItemConfig(this.obf_I_h_4487.itemCode);
         var _loc1_:int = JSONUtil.getInt(obf_c_4686.config,["fusion","minorPetLevel"]);
         if(this.obf_I_h_4487.petInfo.level < _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_SubPetLevel",[_loc1_]));
            this.obf_I_H_3596();
            this.obf_2_B_4604();
            return;
         }
         txtSubPetGrowth.text = obf_c_4686.getPetGrowthRate(this.obf_I_h_4487.petInfo.attributes).toFixed(1);
         txtSubPetSApt.text = this.obf_I_h_4487.petInfo.attributes.strengthApt + "";
         txtSubPetDApt.text = this.obf_I_h_4487.petInfo.attributes.agilityApt + "";
         txtSubPetWApt.text = this.obf_I_h_4487.petInfo.attributes.wisdomApt + "";
         txtSubPetAApt.text = this.obf_I_h_4487.petInfo.attributes.vitalityApt + "";
      }
      
      private function obf_c_Z_1811(param1:Event) : void
      {
         if(!this.mainPetInfo || !this.obf_I_h_4487)
         {
            return;
         }
         if(this.fusionConvert <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_LowFusionConvert"));
            return;
         }
         if(this.mainPetInfo.petInfo.sex == this.obf_I_h_4487.petInfo.sex)
         {
            return;
         }
         var _loc2_:Object = new Object();
         if(this.fusionItemBag.haveIconItem)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(this.fusionItemBag.haveIconItem.itemCode) < this.fusionItemBag.haveIconItem.itemCount)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_NoMoreFusionItem",[GameItemManager.getItemName(this.fusionItemBag.haveIconItem.itemCode)]));
               return;
            }
            _loc2_[this.fusionItemBag.haveIconItem.itemCode] = this.fusionItemBag.haveIconItem.itemCount;
         }
         var _loc3_:String = "";
         if(this.fusionProtectBag.haveIconItem)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(this.fusionProtectBag.haveIconItem.itemCode) < 1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_NoMoreFusionProtect",[GameItemManager.getItemName(this.fusionProtectBag.haveIconItem.itemCode)]));
               return;
            }
            _loc3_ = this.fusionProtectBag.haveIconItem.itemCode;
         }
         var _loc4_:Object = JSONUtil.getObject(obf_c_4686.config,["fusion","condition"]);
         if(!ConditionScript.checkCondition(_loc4_,null,true))
         {
            return;
         }
         obf_c_4686.sendPetFusion(this.mainPetInfo.itemId,this.obf_I_h_4487.itemId,_loc2_,_loc3_);
      }
      
      public function obf_s_x_1694() : void
      {
         var _loc2_:int = 0;
         if(!this.mainPetInfo || !this.obf_I_h_4487)
         {
            return;
         }
         if(this.mainPetInfo.petInfo.generation >= JSONUtil.getInt(obf_c_4686.config,["fusion","maxFusion"]))
         {
            DiversityManager.setTextField(txtGeneration,"PetFusionUI","maxGeneration",null,true);
            return;
         }
         if(this.mainPetInfo.petInfo.generation != this.obf_I_h_4487.petInfo.generation)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_Generation"));
            this.obf_I_H_3596();
            return;
         }
         if(this.mainPetInfo.petInfo.sex == this.obf_I_h_4487.petInfo.sex)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetFusionUI","error_Sex"));
            this.obf_I_H_3596();
            return;
         }
         txtGeneration.text = this.mainPetInfo.petInfo.generation + " / " + JSONUtil.getInt(obf_c_4686.config,["fusion","maxFusion"]);
         if(this.fusionItemBag.haveIconItem)
         {
            this.fusionValue = obf_c_4686.getItemFusionValue(this.fusionItemBag.haveIconItem.itemCode) * this.fusionItemBag.haveIconItem.itemCount;
            _loc2_ = this.fusionValue / obf_c_4686.getMaxFusionConvertValue(this.mainPetInfo.petInfo.generation) * 100;
            barFusionValue.gotoAndStop(_loc2_);
         }
         txtFusion.text = this.fusionValue + "";
         this.fusionConvert = obf_c_4686.getFusionConvertValue(this.fusionValue,this.mainPetInfo.petInfo.generation);
         txtConvert.text = this.fusionConvert + "%";
         var _loc1_:Number = 0;
         if(this.mainPetConfig.code == this.subPetConfig.code)
         {
            _loc1_ = JSONUtil.getNumber(obf_c_4686.config,["fusion","fusionHighChance"]);
         }
         else if(JSONUtil.getInt(this.mainPetConfig,["properties","petKind"]) == JSONUtil.getInt(this.subPetConfig,["properties","petKind"]))
         {
            _loc1_ = JSONUtil.getNumber(obf_c_4686.config,["fusion","fusionMeduimChance"]);
         }
         else
         {
            _loc1_ = JSONUtil.getNumber(obf_c_4686.config,["fusion","fusionLowChance"]);
         }
         txtChance.text = obf_A_x_3023.getRateString(_loc1_);
      }
      
      private function obf_h_B_3464(param1:Event) : void
      {
         if(!this.fusionItemBag.haveIconItem)
         {
            return;
         }
         var _loc2_:* = this.fusionItemBag.haveIconItem.itemCount;
         if(param1.currentTarget == cmdUpFusionValue)
         {
            _loc2_++;
         }
         else if(param1.currentTarget == cmdDbUpFusionValue)
         {
            _loc2_ += 10;
         }
         else if(param1.currentTarget == cmdDownFusionValue)
         {
            _loc2_--;
         }
         else if(param1.currentTarget == cmdDbDownFusionValue)
         {
            _loc2_ -= 10;
         }
         this.fusionItemBag.haveIconItem.itemCount = Math.max(0,_loc2_);
         this.obf_s_x_1694();
      }
      
      public function obf_f_F_4408(param1:String, param2:String) : void
      {
         this.obf_0_1_4_232();
         var _loc3_:obf_U_N_1827 = IconItemManager.getIconItemByCode(param1,param2) as obf_U_N_1827;
         if(!_loc3_)
         {
            return;
         }
         this.obf_2_B_4604();
         this.mainPetBag.pushIconItem(_loc3_);
      }
      
      public function obf_J_i_2170(param1:String, param2:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:IconItem = null;
         this.obf_I_H_3596();
         if(!this.mainPetInfo)
         {
            return;
         }
         var _loc3_:obf_U_N_1827 = IconItemManager.getIconItemByCode(param1,param2) as obf_U_N_1827;
         if(!_loc3_)
         {
            return;
         }
         this.subPetBag.pushIconItem(_loc3_);
         var _loc4_:Array = JSONUtil.getStr(obf_c_4686.config,["fusion","autoFusionItems"]).split(",");
         for each(_loc5_ in _loc4_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc5_) > 0)
            {
               _loc6_ = IconItemManager.getIconItemByCode(_loc5_,"");
               _loc6_.itemCount = 1;
               this.fusionItemBag.pushIconItem(_loc6_);
               break;
            }
         }
      }
      
      public function obf_2_B_4604() : void
      {
         this.fusionValue = 0;
         this.fusionConvert = 0;
         barFusionValue.gotoAndStop(1);
         txtGeneration.text = "";
         txtFusion.text = "";
         txtConvert.text = "";
         this.fusionItemBag.dropIconItem();
         this.fusionProtectBag.dropIconItem();
      }
      
      public function obf_0_1_4_232() : void
      {
         this.mainPetInfo = null;
         this.mainPetConfig = null;
         this.mainPetBag.dropIconItem();
         txtMainPetGrowth.text = "";
         txtMainPetSApt.text = "";
         txtMainPetDApt.text = "";
         txtMainPetWApt.text = "";
         txtMainPetAApt.text = "";
      }
      
      public function obf_I_H_3596() : void
      {
         this.obf_I_h_4487 = null;
         this.subPetConfig = null;
         this.subPetBag.dropIconItem();
         txtSubPetGrowth.text = "";
         txtSubPetSApt.text = "";
         txtSubPetDApt.text = "";
         txtSubPetWApt.text = "";
         txtSubPetAApt.text = "";
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
         this.obf_0_1_4_232();
         this.obf_I_H_3596();
         this.obf_2_B_4604();
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == this.mainPetBag)
         {
            this.obf_f_F_4408(param2.itemCode,param2.itemId);
         }
         if(param1 == this.subPetBag)
         {
            this.obf_J_i_2170(param2.itemCode,param2.itemId);
         }
         if(param1 == this.fusionItemBag && Boolean(JSONUtil.getObject(obf_c_4686.config,["fusion","fusionValueItems"])[param2.itemCode]))
         {
            param2.itemCount = 1;
            this.fusionItemBag.dropIconItem();
            this.fusionItemBag.pushIconItem(param2);
            this.obf_s_x_1694();
         }
         if(param1 == this.fusionProtectBag && (JSONUtil.getObject(obf_c_4686.config,["fusion","fusionProtectItems"]) as Array).indexOf(param2.itemCode) > -1)
         {
            param2.itemCount = 1;
            this.fusionProtectBag.dropIconItem();
            this.fusionProtectBag.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.subPetBag)
         {
            this.obf_I_H_3596();
            this.obf_2_B_4604();
         }
      }
   }
}

