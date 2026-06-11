package com.sunweb.game.rpg.playerUI.wingSpirit
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.wingSpirit.WingSpiritInfo;
   import com.sunweb.game.rpg.wingSpirit.obf_B_5_1274;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.setTimeout;
   import playerUI.WingSpiritUIMC;
   
   public class WingSpiritUI extends WingSpiritUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var bags:Array;
      
      private var cmdArrs:Array;
      
      private var skillBagArr:Array;
      
      private var obf_8_T_2770:int;
      
      private var skillType:int;
      
      public var equipInfo:GameItemFullInfo;
      
      public var spiritEnu:int;
      
      public var spiritValue:int;
      
      public var attrType:int;
      
      public var attrValue:int;
      
      private var wingSpiritCode:String;
      
      private var wingSpiritId:String;
      
      private var wingBag:IconItemBag;
      
      private var wingSpirit:Array = new Array();
      
      private var skillMap:Object;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      public function WingSpiritUI()
      {
         super();
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.initDiversity();
         this.onResize(null);
         this.bags = new Array();
         this.cmdArrs = new Array();
         this.skillBagArr = new Array();
         this.init();
         this.addListener();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         this.cmdArrs = [attrMC1,attrMC2,attrMC3,attrMC4,attrMC5,attrMC6,attrMC7,attrMC8];
         var _loc1_:Array = obf_B_5_1274.wingSpiritConfig.openConfig;
         if(_loc1_.length == this.cmdArrs.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               (this.cmdArrs[_loc3_] as MovieClip).config = _loc1_[_loc3_];
               (this.cmdArrs[_loc3_] as MovieClip).txtName.text = "";
               (this.cmdArrs[_loc3_] as MovieClip).txtNum.text = "";
               (this.cmdArrs[_loc3_] as MovieClip).txtAttr.text = "";
               _loc3_++;
            }
         }
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc4_ = this["icon" + _loc2_];
            if(_loc4_)
            {
               _loc5_ = new IconItemBag(_loc4_,this,_loc2_);
               _loc5_.addValidType(GameItemType.SKILL);
               this.skillBagArr.push(_loc5_);
               this.bags.push(_loc5_);
            }
            _loc2_++;
         }
         this.wingBag = new IconItemBag(wingIcon,this,0);
         this.wingBag.addValidType(GameItemType.EQUIPMENT);
         this.wingBag.lockDrag = true;
         this.bags.push(this.wingBag);
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.cmdArrs)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_J_G_3918);
         }
         cmdSeparate.addEventListener(MouseEvent.CLICK,this.obf_z_k_2860);
         cmdClever.addEventListener(MouseEvent.CLICK,this.obf_C_t_2624);
         cmdReset.addEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"txtWingSpirit");
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.cmdArrs)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_J_G_3918);
         }
         cmdSeparate.removeEventListener(MouseEvent.CLICK,this.obf_z_k_2860);
         cmdClever.removeEventListener(MouseEvent.CLICK,this.obf_C_t_2624);
         cmdReset.removeEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
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
      
      private function obf_z_k_2860(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!this.wingBag.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pushWing"));
            return;
         }
         var _loc2_:Array = new Array();
         if(this.equipInfo)
         {
            this.wingSpirit = this.equipInfo.equipmentInfo.wingSpiritMap;
         }
         if(this.wingSpirit.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < this.wingSpirit.length)
            {
               _loc2_.push(this.wingSpirit[_loc4_].spiritType);
               _loc4_++;
            }
            _loc2_.sort(Array.NUMERIC);
         }
         if(_loc2_.length == 8)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasAlready"));
            return;
         }
         if(_loc2_.indexOf(this.spiritEnu) > -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasAlready"));
            return;
         }
         if(this.spiritEnu >= 10)
         {
            if(_loc2_.length < 3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasAppeal"));
               return;
            }
            if(this.spiritEnu % 10 != this.cmdArrs[_loc2_.length].config.type % 10)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasAppeal"));
               return;
            }
         }
         else if(this.spiritEnu != this.cmdArrs[_loc2_.length].config.type)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasAppeal"));
            return;
         }
         for(_loc3_ in obf_B_5_1274.getOpenEnvelopItem(this.spiritEnu))
         {
            if(!obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc3_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasItems",[GameItemManager.getItemName(_loc3_),obf_B_5_1274.getOpenEnvelopItem(this.spiritEnu)[_loc3_]]));
               return;
            }
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < obf_B_5_1274.getOpenEnvelopItem(this.spiritEnu)[_loc3_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasItems",[GameItemManager.getItemName(_loc3_),obf_B_5_1274.getOpenEnvelopItem(this.spiritEnu)[_loc3_]]));
               return;
            }
         }
         cmdSeparate.enabled = false;
         setTimeout(this.delaySeparate,1000);
         obf_B_5_1274.sendDoWingSpirit(this.wingSpiritId,this.spiritEnu,0);
      }
      
      private function delaySeparate() : void
      {
         cmdSeparate.enabled = true;
      }
      
      private function delayClever() : void
      {
         cmdClever.enabled = true;
      }
      
      private function delayReset() : void
      {
         cmdReset.enabled = true;
      }
      
      private function obf_C_t_2624(param1:Event) : void
      {
         var _loc3_:WingSpiritInfo = null;
         var _loc4_:String = null;
         var _loc5_:WingSpiritInfo = null;
         if(!this.wingBag.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pushWing"));
            return;
         }
         if(this.equipInfo.equipmentInfo.wingSpiritMap.length == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pleasePirit"));
            return;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.equipInfo.equipmentInfo.wingSpiritMap)
         {
            _loc2_.push(_loc3_.spiritType);
         }
         if(_loc2_.indexOf(this.spiritEnu) < 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pleasePirit"));
            return;
         }
         for(_loc4_ in obf_B_5_1274.getCostItems())
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc4_) < obf_B_5_1274.getCostItems()[_loc4_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasItems",[GameItemManager.getItemName(_loc4_),obf_B_5_1274.getCostItems()[_loc4_]]));
               return;
            }
         }
         for each(_loc5_ in this.equipInfo.equipmentInfo.wingSpiritMap)
         {
            if(_loc5_.spiritType == this.spiritEnu && _loc5_.spirit >= obf_B_5_1274.getMaxValue())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasMax"));
               return;
            }
         }
         cmdClever.enabled = false;
         setTimeout(this.delayClever,1000);
         obf_B_5_1274.sendDoWingSpirit(this.wingSpiritId,this.spiritEnu,1);
      }
      
      private function obf_W_g_1639(param1:Event) : void
      {
         var _loc3_:WingSpiritInfo = null;
         var _loc4_:String = null;
         if(!this.wingBag.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pushWing"));
            return;
         }
         if(this.equipInfo.equipmentInfo.wingSpiritMap.length == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pleasePirit"));
            return;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.equipInfo.equipmentInfo.wingSpiritMap)
         {
            _loc2_.push(_loc3_.spiritType);
         }
         if(_loc2_.indexOf(this.spiritEnu) < 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","pleasePirit"));
            return;
         }
         for(_loc4_ in obf_B_5_1274.getReSet())
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc4_) < obf_B_5_1274.getReSet()[_loc4_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","HasItems",[GameItemManager.getItemName(_loc4_),obf_B_5_1274.getReSet()[_loc4_]]));
               return;
            }
         }
         cmdReset.enabled = false;
         setTimeout(this.delayReset,1000);
         WindowManager.showConfirmBox(DiversityManager.getString("WingSpiritUI","promptConfirmReset"),this.confirmReset);
      }
      
      private function confirmReset(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_B_5_1274.sendDoWingSpirit(this.wingSpiritId,this.spiritEnu,2);
         }
      }
      
      private function obf_J_G_3918(param1:Event) : void
      {
         this.obf_8_T_2770 = this.cmdArrs.indexOf(param1.currentTarget);
         this.spiritEnu = param1.currentTarget.config.type;
         this.showState(this.spiritEnu);
      }
      
      private function showState(param1:int) : void
      {
         this.spiritEnu = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.cmdArrs.length)
         {
            if((this.cmdArrs[_loc2_] as MovieClip).config.type == param1)
            {
               (this.cmdArrs[_loc2_] as MovieClip).filters = [new GlowFilter(7732992)];
            }
            else
            {
               (this.cmdArrs[_loc2_] as MovieClip).filters = null;
            }
            _loc2_++;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.visible && this.timeInv.checkTimeout() && !this.equipInfo && Boolean(this.wingBag.haveIconItem))
         {
            this.equipInfo = GameItemInfoManager.getItemInfo(this.wingBag.haveIconItem.itemId);
            if(this.equipInfo)
            {
               this.obf_l_n_3275();
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(this.wingBag.haveIconItem.itemId);
            }
         }
      }
      
      private function showAttr() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.cmdArrs.length)
         {
            (this.cmdArrs[_loc1_] as MovieClip).txtName.text = this.cmdArrs[_loc1_].config.name;
            (this.cmdArrs[_loc1_] as MovieClip).txtNum.text = "";
            (this.cmdArrs[_loc1_] as MovieClip).txtAttr.text = DiversityManager.getString("WingSpiritUI","notOpen");
            _loc1_++;
         }
      }
      
      private function skillIcons() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:IconItemSkill = null;
         var _loc5_:String = null;
         for each(_loc1_ in this.skillBagArr)
         {
            if(_loc1_)
            {
               _loc1_.dropIconItem();
            }
         }
         _loc2_ = obf_B_5_1274.wingSpiritConfig.skillConfig;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = IconItemSkill.getNewIconItem(_loc2_[_loc3_],1);
            if(_loc4_)
            {
               _loc4_.filters = [obf_9_V_1635.getGrayFilter()];
               _loc4_.itemCount = 1;
               for(_loc5_ in this.skillMap)
               {
                  if(_loc5_ == _loc2_[_loc3_])
                  {
                     _loc4_.level = this.skillMap[_loc5_];
                     _loc4_.itemCount = this.skillMap[_loc5_];
                     _loc4_.filters = [obf_9_V_1635.getHighLightFilter()];
                     break;
                  }
               }
               this.skillBagArr[_loc3_].pushIconItem(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function obf_l_P_2874() : void
      {
         var _loc1_:IconItemBag = null;
         this.equipInfo = null;
         this.wingBag.dropIconItem();
         for each(_loc1_ in this.skillBagArr)
         {
            _loc1_.dropIconItem();
         }
         this.hide();
         this.wingSpiritId = "";
         this.spiritEnu = 0;
      }
      
      private function hide() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.cmdArrs.length)
         {
            (this.cmdArrs[_loc1_] as MovieClip).txtName.text = "";
            (this.cmdArrs[_loc1_] as MovieClip).txtNum.text = "";
            (this.cmdArrs[_loc1_] as MovieClip).txtAttr.text = "";
            _loc1_++;
         }
      }
      
      public function obf_l_n_3275() : void
      {
         var _loc1_:Array = null;
         var _loc2_:WingSpiritInfo = null;
         var _loc3_:int = 0;
         if(!this.wingBag.haveIconItem)
         {
            return;
         }
         this.showAttr();
         this.wingSpiritCode = this.wingBag.haveIconItem.itemCode;
         this.wingSpiritId = this.wingBag.haveIconItem.itemId;
         if(this.equipInfo)
         {
            if(this.equipInfo.isEmpty)
            {
               return;
            }
            this.skillMap = this.equipInfo.equipmentInfo.wingSpiritSkills;
            this.skillIcons();
            _loc1_ = new Array();
            for each(_loc2_ in this.equipInfo.equipmentInfo.wingSpiritMap)
            {
               _loc1_.push({
                  "type":_loc2_.spiritType,
                  "value":_loc2_
               });
            }
            _loc1_.sortOn("type",Array.NUMERIC);
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               (this.cmdArrs[_loc3_] as MovieClip).txtNum.text = _loc1_[_loc3_].value.spirit;
               (this.cmdArrs[_loc3_] as MovieClip).txtAttr.text = RoleAttributesModifierEnum.getAttributesName(_loc1_[_loc3_].value.attrType) + ":" + RoleAttributesModifierEnum.getAttributesValueString(_loc1_[_loc3_].value.attrType,_loc1_[_loc3_].value.attrValue,true);
               _loc3_++;
            }
         }
      }
      
      public function wingSpiritInfo(param1:GameItemFullInfo) : void
      {
         this.equipInfo = param1;
         if(this.visible)
         {
            this.obf_l_n_3275();
         }
      }
      
      public function getEquipBindSkills() : Array
      {
         var _loc2_:String = null;
         var _loc3_:IconItemBag = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.skillMap)
         {
            _loc3_ = this.skillBagArr[_loc2_];
            if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
            {
               _loc1_.push(_loc3_.haveIconItem.itemCode);
            }
         }
         return _loc1_;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:Object = null;
         if(this.visible && param1 == this.wingBag && param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            this.obf_l_P_2874();
            _loc4_ = GameItemManager.getItemConfig(param2.itemCode);
            if((Boolean(_loc4_)) && _loc4_.subtype == GameItemSubtype.EQUIPMENT_WING)
            {
               this.wingBag.pushIconItem(param2);
               GameContext.bagItemManager.sendViewItem(param2.itemId);
               this.showState(0);
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
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
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"WingSpiritUI","txtDeyTitle");
         cmdSeparate.label = DiversityManager.getString("WingSpiritUI","cmdSeparate");
         cmdClever.label = DiversityManager.getString("WingSpiritUI","cmdClever");
         cmdReset.label = DiversityManager.getString("WingSpiritUI","cmdReset");
         DiversityManager.setTextField(txtExplain,"WingSpiritUI","txtExplain",null,true);
         DiversityManager.setTextField(txtPushWing,"WingSpiritUI","pushWing");
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
         this.obf_l_P_2874();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_l_P_2874();
      }
   }
}

