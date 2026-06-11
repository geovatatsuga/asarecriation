package com.sunweb.game.rpg.playerUI.cloak
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.cloak.obf_b_T_3041;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemCollection;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import playerUI.CloakBoxUIMC;
   
   public class CloakBoxUI extends CloakBoxUIMC implements IIconItemUI, IPlayerUI
   {
      
      public var bags:Array = new Array();
      
      private var pageButtons:Array;
      
      private var selectButtons:Array;
      
      private var glyphConfigArr:Array;
      
      private var glyphConfigObj:Object;
      
      private var bagsBox:Array = new Array();
      
      private var bagsPage:Array = new Array();
      
      private var bagPageSize:int = 21;
      
      private var cloakIconBag:IconItemBag;
      
      private var cloakMaterialArr:Array = new Array();
      
      private var attactCloakCode:String;
      
      private var obf_r_G_3058:String;
      
      private var fusionMaterial:IconItemBag;
      
      private var upMaterialArr:Array = new Array();
      
      private var obf_v_U_1397:IconItemBag;
      
      private var type:int;
      
      private var obf_x_f_843:Array;
      
      private var glyphId:String;
      
      private var obf_8_w_2929:String;
      
      private var cloakGlyphMap:Object;
      
      private var glyphUpItems:Object = new Object();
      
      private var currentGlyphConfig:Object;
      
      private var obf_L_O_3078:Array = new Array();
      
      private var obf_0_2_S_180:Array;
      
      private var attCount:int = 0;
      
      private var obf_t_Q_2730:int = 0;
      
      private var obf_y_i_4081:TimeLimiter = new TimeLimiter(200);
      
      public function CloakBoxUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.onResize(null);
         this.pageButtons = new Array();
         this.selectButtons = new Array();
         this.cloakGlyphMap = new Object();
         this.currentGlyphConfig = new Object();
         this.initBags();
         obf_2_1924.visible = false;
         this.addListener();
      }
      
      public static function obf_t_Y_4076(param1:Event) : void
      {
         if(param1.currentTarget.haveIconItem)
         {
            return;
         }
         var _loc2_:GameTipUI = new GameTipUI("UIMouseCloakTip");
         _loc2_.addTipInfo(DiversityManager.getString("MouseToolTip","txtCmdExplain"),250,0);
         GameTipManager.showTip(_loc2_);
      }
      
      public static function obf_M_V_3343(param1:Event) : void
      {
         GameTipManager.closeTip("UIMouseCloakTip");
      }
      
      private function initBags() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         this.pageButtons = [this.tab1,this.tab2];
         this.selectButtons = [this.cmdSelect1,this.cmdSelect2,this.cmdSelect3,this.cmdSelect4,this.cmdSelect5];
         this.glyphConfigArr = new Array();
         this.glyphConfigObj = new Object();
         var _loc1_:Array = obf_b_T_3041.cloakGlyphConfig;
         if(_loc1_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               this.glyphConfigArr.push({
                  "key":this.selectButtons[_loc4_],
                  "value":_loc1_[_loc4_]
               });
               this.glyphConfigObj[_loc1_[_loc4_].id] = _loc1_[_loc4_];
               _loc4_++;
            }
         }
         var _loc2_:int = 1;
         while(_loc2_ <= this.pageButtons.length)
         {
            this.bagsBox.push(this["tabIconBg" + _loc2_]);
            _loc5_ = 1;
            while(_loc5_ <= this.bagPageSize)
            {
               _loc6_ = this["tabIconBg" + _loc2_]["icon" + _loc5_] as MovieClip;
               if(_loc6_ != null)
               {
                  _loc7_ = new IconItemBag(_loc6_,this,(_loc2_ - 1) * this.bagPageSize + _loc5_);
                  _loc7_.lockDrag = true;
                  _loc7_.addValidType(GameItemType.COLLECTION);
                  this.bagsPage.push(_loc7_);
                  this.bags.push(_loc7_);
               }
               _loc5_++;
            }
            _loc2_++;
         }
         this.cloakIconBag = new IconItemBag(cloakIcon,this,0);
         this.cloakIconBag.lockDrag = true;
         this.cloakIconBag.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.cloakIconBag);
         var _loc3_:int = 1;
         while(_loc3_ <= 2)
         {
            _loc8_ = this["cloakMaterial" + _loc3_] as MovieClip;
            if(_loc8_ != null)
            {
               _loc9_ = new IconItemBag(_loc8_,this,_loc3_);
               _loc9_.lockDrag = true;
               _loc9_.addValidType(GameItemType.COLLECTION);
               this.cloakMaterialArr.push(_loc9_);
               this.bags.push(_loc9_);
            }
            _loc3_++;
         }
         this.fusionMaterial = new IconItemBag(cloakMaterial3,this,0);
         this.fusionMaterial.lockDrag = true;
         this.fusionMaterial.addValidType(GameItemType.COLLECTION);
         this.bags.push(this.fusionMaterial);
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_t_0_3364);
         }
         for each(_loc2_ in this.selectButtons)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.obf_V_5_2413);
         }
         cmdAcquire.addEventListener(MouseEvent.CLICK,this.obf_I_y_3082);
         cmdUpgrade.addEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
         cmdFusion.addEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
         obf_K_e_3075.addUIMouseToolTip(txtCmdExplain,"txtCmdExplain");
         obf_K_e_3075.addUIMouseToolTip(txtCmdFusionExplain,"txtCmdFusionExplain");
         for each(_loc3_ in this.bagsPage)
         {
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,obf_t_Y_4076);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,obf_M_V_3343);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_t_0_3364);
         }
         for each(_loc2_ in this.selectButtons)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.obf_V_5_2413);
         }
         cmdAcquire.removeEventListener(MouseEvent.CLICK,this.obf_I_y_3082);
         cmdUpgrade.removeEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
         cmdFusion.removeEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
         obf_K_e_3075.removeUIMouseToolTip(txtCmdExplain);
         obf_K_e_3075.removeUIMouseToolTip(txtCmdFusionExplain);
         for each(_loc3_ in this.bagsPage)
         {
            _loc3_.removeUIMouseToolTip(MouseEvent.MOUSE_OVER,obf_t_Y_4076);
            _loc3_.removeUIMouseToolTip(MouseEvent.MOUSE_OUT,obf_M_V_3343);
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
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function obf_I_y_3082(param1:Event) : void
      {
         if(this.type == 1)
         {
            if(obf_b_T_3041.obf_k_s_4303 == 0 && this.attCount < 3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","NotChip"));
               return;
            }
            if(obf_b_T_3041.obf_k_s_4303 > 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasCloak"));
               return;
            }
         }
         if(this.type == 2)
         {
            if(obf_b_T_3041._defenseCloaks == 0 && this.obf_t_Q_2730 < 3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","NotChip"));
               return;
            }
            if(obf_b_T_3041._defenseCloaks > 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasCloak"));
               return;
            }
         }
         obf_b_T_3041.sendCloakGetUp(this.type);
      }
      
      private function obf_Z_v_1153(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(this.type == 1)
         {
            _loc2_ = obf_b_T_3041.cloakAttact;
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = "";
            _loc4_ = "";
            switch(obf_b_T_3041.obf_k_s_4303)
            {
               case 1:
                  _loc4_ = "initCode";
                  break;
               case 2:
                  _loc4_ = "twoCode";
                  break;
               case 3:
                  _loc4_ = "threeCode";
                  break;
               case 4:
                  _loc4_ = "fourCode";
                  break;
               default:
                  _loc4_ = "";
            }
            _loc3_ = _loc2_[_loc4_];
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotCloak1"));
               return;
            }
            if(obf_b_T_3041.obf_k_s_4303 == 1 && this.attCount < 9)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot2Cloak1"));
               return;
            }
            if(obf_b_T_3041.obf_k_s_4303 == 2 && this.attCount < 15)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot3Cloak1"));
               return;
            }
            if(obf_b_T_3041.obf_k_s_4303 == 3 && this.attCount < 21)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot4Cloak1"));
               return;
            }
            if(obf_b_T_3041.obf_k_s_4303 >= 4 && this.attCount >= 21)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasMaxCloak1"));
               return;
            }
            if(!obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc3_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotCloak1"));
               return;
            }
         }
         else if(this.type == 2)
         {
            _loc5_ = obf_b_T_3041.cloakDefense;
            if(!_loc5_)
            {
               return;
            }
            _loc6_ = "";
            _loc7_ = "";
            switch(obf_b_T_3041._defenseCloaks)
            {
               case 1:
                  _loc7_ = "initCode";
                  break;
               case 2:
                  _loc7_ = "twoCode";
                  break;
               case 3:
                  _loc7_ = "threeCode";
                  break;
               case 4:
                  _loc7_ = "fourCode";
                  break;
               default:
                  _loc7_ = "";
            }
            _loc6_ = _loc5_[_loc7_];
            if(obf_L_l_4100.isEmpty(_loc6_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotCloak2"));
               return;
            }
            if(obf_b_T_3041._defenseCloaks == 1 && this.obf_t_Q_2730 < 9)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot2Cloak2"));
               return;
            }
            if(obf_b_T_3041._defenseCloaks == 2 && this.obf_t_Q_2730 < 15)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot3Cloak2"));
               return;
            }
            if(obf_b_T_3041._defenseCloaks == 3 && this.obf_t_Q_2730 < 21)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNot4Cloak2"));
               return;
            }
            if(obf_b_T_3041._defenseCloaks >= 4 && this.obf_t_Q_2730 >= 21)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasMaxCloak2"));
               return;
            }
            if(!obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc6_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotCloak2"));
               return;
            }
         }
         obf_b_T_3041.sendCloakGetUp(this.type);
      }
      
      private function obf_c_Z_1811(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!this.cloakIconBag.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotFusionCloak"));
            return;
         }
         var _loc2_:Object = obf_b_T_3041.cloakAttact;
         var _loc3_:Object = obf_b_T_3041.cloakDefense;
         if(_loc2_["fourCode"] == this.cloakIconBag.haveIconItem.itemCode || _loc3_["fourCode"] == this.cloakIconBag.haveIconItem.itemCode)
         {
            if(!this.cloakMaterialArr[0].haveIconItem || !this.cloakMaterialArr[1].haveIconItem || !this.fusionMaterial.haveIconItem)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotEnoughChip"));
               return;
            }
            for(_loc4_ in obf_b_T_3041.cloakMeltNeeds)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc4_) < obf_b_T_3041.cloakMeltNeeds[_loc4_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotFusionMaterial"));
                  return;
               }
            }
            _loc5_ = "";
            _loc6_ = "";
            _loc7_ = "";
            if(this.cloakIconBag.haveIconItem)
            {
               _loc5_ = this.cloakIconBag.haveIconItem.itemId;
            }
            if(this.cloakMaterialArr[0].haveIconItem)
            {
               _loc6_ = this.cloakMaterialArr[0].haveIconItem.itemCode;
            }
            if(this.cloakMaterialArr[1].haveIconItem)
            {
               _loc7_ = this.cloakMaterialArr[1].haveIconItem.itemCode;
            }
            if(_loc6_ == _loc7_)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc7_) < 2)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotFusionMaterial"));
                  return;
               }
            }
            else
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc6_) < 1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotFusionMaterial"));
                  return;
               }
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc7_) < 1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotFusionMaterial"));
                  return;
               }
            }
            obf_b_T_3041.sendCloakMelt(_loc5_,_loc6_,_loc7_);
            return;
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotEnough4"));
      }
      
      public function showFusionEffect(param1:Boolean) : void
      {
         while(effectPointMC.numChildren > 0)
         {
            effectPointMC.removeChildAt(0);
         }
         if(param1)
         {
            obf_0_P_4381.obf_m_X_1194("win@CloakFunsionSucceed",effectPointMC);
         }
         else
         {
            obf_0_P_4381.obf_m_X_1194("lose@CloakFunsionFail",effectPointMC);
         }
      }
      
      private function obf_V_5_2413(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.selectButtons.length)
         {
            if(param1.currentTarget.name == this.selectButtons[_loc2_].name)
            {
               obf_2_1924.visible = true;
               if(param1.currentTarget.name == "cmdSelect5")
               {
                  obf_2_1924.scaleX = 1;
                  obf_2_1924.scaleY = 1;
                  obf_2_1924.x = this.selectButtons[_loc2_].x;
                  obf_2_1924.y = this.selectButtons[_loc2_].y;
               }
               else
               {
                  obf_2_1924.scaleX = 0.75;
                  obf_2_1924.scaleY = 0.75;
                  obf_2_1924.x = this.selectButtons[_loc2_].x + 2;
                  obf_2_1924.y = this.selectButtons[_loc2_].y + 2;
               }
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.glyphConfigArr.length)
         {
            if(param1.currentTarget.name == this.glyphConfigArr[_loc3_].key.name)
            {
               this.currentGlyphConfig = this.glyphConfigArr[_loc3_].value;
               this.setShowCloakGlyph(this.glyphConfigArr[_loc3_].value);
               break;
            }
            _loc3_++;
         }
      }
      
      private function setShowCloakGlyph(param1:Object) : void
      {
         var _loc2_:CloakUnlockMC = null;
         var _loc3_:CloakUpGradeMC = null;
         var _loc4_:int = 0;
         var _loc5_:CLoakActivationMC = null;
         this.obf_s_G_2224();
         if(!param1)
         {
            return;
         }
         this.glyphId = param1.id;
         if(obf_L_l_4100.isEmpty(this.glyphId))
         {
            return;
         }
         this.glyphUpItems = new Object();
         if(!ConditionScript.checkCondition(JSONUtil.getObject(param1,["openCon"]),null,true))
         {
            _loc2_ = new CloakUnlockMC();
            _loc2_.setName(this.glyphId);
            _loc2_.setLevel(0);
            _loc2_.setRemark(param1.unlockExplain);
            glyphPoint.addChild(_loc2_);
         }
         else if(obf_b_T_3041.obf_0_4_Z_273.hasOwnProperty(param1.id))
         {
            _loc3_ = new CloakUpGradeMC(this,param1.levelConfig,obf_b_T_3041.obf_0_4_Z_273[param1.id]);
            _loc4_ = obf_b_T_3041.obf_0_4_Z_273[param1.id] - 1;
            this.glyphUpItems = param1.levelConfig[_loc4_].items;
            _loc3_.setName(this.glyphId);
            _loc3_.setLevel(obf_b_T_3041.obf_0_4_Z_273[param1.id]);
            _loc3_.setRemark(param1.levelConfig[obf_b_T_3041.obf_0_4_Z_273[param1.id] - 1].upExplain);
            this.cloakGlyphMap[this.glyphId] = _loc3_;
            this.obf_L_O_3078 = _loc3_.getIconItemBags();
            _loc3_.addEventListener(CloakUpGradeMC.upGradeMCEvent,this.obf_2_0_1387);
            glyphPoint.addChild(_loc3_);
         }
         else
         {
            this.obf_8_w_2929 = param1.openItem;
            _loc5_ = new CLoakActivationMC(this);
            _loc5_.setName(this.glyphId);
            _loc5_.setLevel(0);
            _loc5_.iconBag.pushIconItem(IconItemManager.getIconItemByCode(this.obf_8_w_2929,""));
            _loc5_.setRemark(param1.activationExplain);
            this.obf_0_2_S_180 = new Array();
            this.obf_0_2_S_180.push(_loc5_.iconBag);
            _loc5_.addEventListener(CLoakActivationMC.obf_S_S_1707,this.obf_1_h_2188);
            glyphPoint.addChild(_loc5_);
         }
      }
      
      public function obf_0_4_I_321(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:CloakUpGradeMC = null;
         if(!param1)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = this.cloakGlyphMap[_loc2_] as CloakUpGradeMC;
            if(_loc3_)
            {
               _loc3_.setLevel(param1[_loc2_]);
            }
         }
         this.setShowCloakGlyph(this.currentGlyphConfig);
      }
      
      private function obf_1_h_2188(param1:Event) : void
      {
         if(obf_K_e_3075.playerBagUI.getEqualItemCount(this.obf_8_w_2929) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotAct"));
            return;
         }
         obf_b_T_3041.sendGlyphOpenUp(this.glyphId);
      }
      
      private function obf_2_0_1387(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!this.glyphUpItems)
         {
            return;
         }
         for(_loc2_ in this.glyphUpItems)
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < this.glyphUpItems[_loc2_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","HasNotUp"));
               return;
            }
         }
         obf_b_T_3041.sendGlyphOpenUp(this.glyphId);
      }
      
      private function obf_s_G_2224() : void
      {
         var _loc1_:* = undefined;
         while(glyphPoint.numChildren > 0)
         {
            _loc1_ = glyphPoint.getChildAt(0);
            if(_loc1_ is CloakUpGradeMC)
            {
               _loc1_.removeEventListener(CloakUpGradeMC.upGradeMCEvent,this.obf_2_0_1387);
               _loc1_.destroy();
            }
            if(_loc1_ is CLoakActivationMC)
            {
               _loc1_.removeEventListener(CLoakActivationMC.obf_S_S_1707,this.obf_1_h_2188);
               _loc1_.destroy();
            }
            glyphPoint.removeChildAt(0);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.obf_y_i_4081.checkTimeout())
         {
            if(this.type == 1)
            {
               if(obf_b_T_3041.obf_k_s_4303 < 1 && this.attCount >= 3)
               {
                  cmdAcquire.filters = [new GlowFilter(7732992)];
                  cmdAcquire.enabled = true;
               }
               else
               {
                  cmdAcquire.filters = [obf_9_V_1635.getGrayFilter()];
                  cmdAcquire.enabled = false;
               }
            }
            else if(this.type == 2)
            {
               if(obf_b_T_3041._defenseCloaks < 1 && this.obf_t_Q_2730 >= 3)
               {
                  cmdAcquire.filters = [new GlowFilter(7732992)];
                  cmdAcquire.enabled = true;
               }
               else
               {
                  cmdAcquire.filters = [obf_9_V_1635.getGrayFilter()];
                  cmdAcquire.enabled = false;
               }
            }
         }
      }
      
      private function obf_t_0_3364(param1:Event) : void
      {
         this.chearFusionItem();
         this.setBagsPage(this.pageButtons.indexOf(param1.currentTarget) + 1);
      }
      
      public function setBagsPage(param1:int) : void
      {
         var i:int;
         var bagBox:MovieClip = null;
         var page:int = param1;
         this.type = page;
         i = 0;
         while(i < this.pageButtons.length)
         {
            (this.pageButtons[i] as MovieClip).gotoAndStop(i + 1 == page ? 2 : 1);
            if(i + 1 == page)
            {
               (this.pageButtons[i] as MovieClip).filters = [new GlowFilter(6684671)];
            }
            else
            {
               (this.pageButtons[i] as MovieClip).filters = null;
            }
            i++;
         }
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
      }
      
      private function obf_T_z_3663(param1:IconItemCollection) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:IconItemBag = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:* = obf_b_T_3041.chipCodes;
         for(_loc3_ in _loc2_)
         {
            if(param1.itemCode == _loc2_[_loc3_])
            {
               obf_b_T_3041.sendCloakInChip(this.type,_loc3_);
               _loc4_ = this.bagsPage[(_loc3_ - 1) % 21 + (this.type - 1) * 21];
               _loc4_.dropIconItem();
               param1.itemCount = 1;
               _loc4_.pushIconItem(param1);
               break;
            }
         }
      }
      
      private function pushChipInIndex(param1:IconItem, param2:int, param3:int) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc4_:IconItemBag = this.bagsPage[(param3 - 1) % 21 + (this.type - 1) * 21];
         _loc4_.dropIconItem();
         param1.itemCount = 1;
         _loc4_.pushIconItem(param1);
      }
      
      public function cloakChipNotify(param1:Object, param2:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:IconItemBag = null;
         var _loc6_:IconItemCollection = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItemCollection = null;
         this.attCount = 0;
         this.obf_t_Q_2730 = 0;
         this.obf_h_Q_3417();
         for(_loc3_ in param1)
         {
            _loc5_ = this.bagsPage[(_loc3_ - 1) % 21];
            _loc6_ = IconItemCollection.getNewIconItem(param1[_loc3_],"");
            if(!_loc6_)
            {
               return;
            }
            _loc5_.dropIconItem();
            _loc6_.itemCount = 1;
            _loc5_.pushIconItem(_loc6_);
            ++this.attCount;
         }
         for(_loc4_ in param2)
         {
            _loc7_ = this.bagsPage[(_loc4_ - 1) % 21 + 21];
            _loc8_ = IconItemCollection.getNewIconItem(param2[_loc4_],"");
            if(!_loc8_)
            {
               return;
            }
            _loc7_.dropIconItem();
            _loc8_.itemCount = 1;
            _loc7_.pushIconItem(_loc8_);
            ++this.obf_t_Q_2730;
         }
      }
      
      private function obf_h_Q_3417() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bagsPage)
         {
            _loc1_.dropIconItem();
         }
      }
      
      private function obf_r_i_2856(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.subtype == GameItemSubtype.obf_7_3856)
         {
            this.cloakIconBag.dropIconItem();
            this.cloakIconBag.pushIconItem(param1);
         }
      }
      
      private function obf_Q_k_2159(param1:IconItemCollection, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:IconItemBag = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:* = obf_b_T_3041.chipCodes;
         for(_loc4_ in _loc3_)
         {
            if(param1.itemCode == _loc3_[_loc4_])
            {
               _loc5_ = this.cloakMaterialArr[param2 - 1];
               _loc5_.dropIconItem();
               param1.itemCount = 1;
               _loc5_.pushIconItem(param1);
               break;
            }
         }
      }
      
      private function obf_a_q_1830(param1:IconItemCollection) : void
      {
         var _loc3_:String = null;
         var _loc4_:IconItem = null;
         this.fusionMaterial.dropIconItem();
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = obf_b_T_3041.cloakMeltNeeds;
         for(_loc3_ in _loc2_)
         {
            if(param1.itemCode == _loc3_)
            {
               _loc4_ = IconItemManager.getIconItemByCode(_loc3_,"");
               if(_loc4_)
               {
                  _loc4_.itemCount = _loc2_[_loc3_];
                  this.fusionMaterial.pushIconItem(_loc4_);
                  break;
               }
            }
         }
      }
      
      public function chearFusionItem() : void
      {
         var _loc1_:IconItemBag = null;
         this.cloakIconBag.dropIconItem();
         this.fusionMaterial.dropIconItem();
         for each(_loc1_ in this.cloakMaterialArr)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags.concat(this.obf_0_2_S_180,this.obf_L_O_3078);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc5_:* = undefined;
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:* = obf_b_T_3041.chipCodes;
         if(this.bagsPage.indexOf(param1) > -1)
         {
            for(_loc5_ in _loc4_)
            {
               if(param2.itemCode == _loc4_[_loc5_])
               {
                  obf_b_T_3041.sendCloakInChip(this.type,_loc5_);
                  this.pushChipInIndex(param2,this.type,_loc5_);
                  break;
               }
            }
         }
         if(param1 == this.cloakIconBag && param2 is IconItemEquip)
         {
            this.obf_r_i_2856(param2 as IconItemEquip);
         }
         if(this.cloakMaterialArr.indexOf(param1) > -1 && param1 != this.cloakIconBag && param2 is IconItemCollection)
         {
            this.obf_Q_k_2159(param2 as IconItemCollection,param1.itemIndex);
         }
         if(param1 == this.fusionMaterial && param2 is IconItemCollection)
         {
            this.obf_a_q_1830(param2 as IconItemCollection);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"CloakBoxUI","txtTitle");
         txtCmdExplain.label = DiversityManager.getString("CloakBoxUI","txtCmdExplain");
         DiversityManager.setTextField(tab1.txtLabel,"CloakBoxUI","tab1",null,true);
         DiversityManager.setTextField(tab2.txtLabel,"CloakBoxUI","tab2",null,true);
         cmdAcquire.label = DiversityManager.getString("CloakBoxUI","cmdAcquire");
         cmdUpgrade.label = DiversityManager.getString("CloakBoxUI","cmdUpgrade");
         var _loc1_:int = 1;
         while(_loc1_ < 22)
         {
            DiversityManager.setTextField(this["tabIconBg1"]["txtChip" + _loc1_],"CloakBoxUI","txtChip_",[_loc1_]);
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 22)
         {
            DiversityManager.setTextField(this["tabIconBg2"]["txtChip" + _loc2_],"CloakBoxUI","txtChip_",[_loc2_]);
            _loc2_++;
         }
         DiversityManager.setTextField(txtDeyFusion,"CloakBoxUI","txtFusion");
         DiversityManager.setTextField(txtDeyMaterial,"CloakBoxUI","txtMaterial");
         DiversityManager.setTextField(txtFuse1,"CloakBoxUI","txtFuse");
         DiversityManager.setTextField(txtFuse2,"CloakBoxUI","txtFuse");
         DiversityManager.setTextField(txtFuse3,"CloakBoxUI","txtFuse3");
         cmdFusion.label = DiversityManager.getString("CloakBoxUI","cmdFusion");
         txtCmdFusionExplain.label = DiversityManager.getString("CloakBoxUI","txtCmdExplain");
         DiversityManager.setTextField(txtDeyClew,"CloakBoxUI","txtClew");
         DiversityManager.setTextField(upGradeMC.txtUpExplain,"CloakBoxUI","txtUpExplain");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.setBagsPage(1);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.chearFusionItem();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_s_G_2224();
      }
   }
}

