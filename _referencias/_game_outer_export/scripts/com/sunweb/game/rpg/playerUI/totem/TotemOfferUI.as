package com.sunweb.game.rpg.playerUI.totem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TotemOfferUIMC;
   
   public class TotemOfferUI extends TotemOfferUIMC implements IIconItemUI
   {
      
      private var allBags:Array;
      
      private var obf_9_9_3410:int;
      
      private var _currentLv:int;
      
      private var obf_b_6_3110:Object;
      
      private var itemObj:Object;
      
      private var gold:int;
      
      public function TotemOfferUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         super();
         this.visible = false;
         this.initDiversity();
         this.allBags = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = this["iconBar" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.allBags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdOffer.addEventListener(MouseEvent.CLICK,this.onUpLv);
      }
      
      private function removeListener() : void
      {
         cmdOffer.removeEventListener(MouseEvent.CLICK,this.onUpLv);
      }
      
      private function onUpLv(param1:Event) : void
      {
         var _loc2_:String = null;
         if(this.obf_9_9_3410 > 0)
         {
            if(this._currentLv >= this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1]["level"].length)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemOfferUI","maxLv"));
               return;
            }
         }
         if(this.gold > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemOfferUI","noGold"));
            return;
         }
         for(_loc2_ in this.itemObj)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < this.itemObj[_loc2_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemOfferUI","noSuff"));
               return;
            }
         }
         obf_J_w_1685.sendUpLv(obf_K_e_3075.totemBoxUI.list.selectedIndex,1);
      }
      
      public function init(param1:Object) : void
      {
         this.obf_b_6_3110 = param1;
      }
      
      public function obf_0_4_u_689(param1:int, param2:int) : void
      {
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:IconItemBag = null;
         var _loc15_:IconItem = null;
         this.obf_9_9_3410 = param1;
         this._currentLv = param2;
         this.clear();
         var _loc3_:String = "";
         _loc4_ = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         if(this.obf_9_9_3410 <= 0)
         {
            txtDayAttr.text = DiversityManager.getString("TotemOfferUI","noActivation");
            txtAttr.text = _loc3_;
            txtNameAttr.text = _loc4_;
            _loc10_ = JSONUtil.getObject(this.obf_b_6_3110["stage"][0],["level",0,"attr"]);
            for(_loc11_ in _loc10_)
            {
               _loc5_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc11_),_loc10_[_loc11_]) + "\r";
               _loc6_ += RoleAttributesModifierEnum.getAttributesName(int(_loc11_)) + ":\r";
            }
            txtNextAttr.text = _loc5_;
            txtNameNextAttr.text = _loc6_;
            this.itemObj = JSONUtil.getObject(this.obf_b_6_3110,["openItem"]);
            this.gold = JSONUtil.getInt(this.obf_b_6_3110,["openGold"]);
            cmdOffer.enabled = false;
         }
         else
         {
            txtDayAttr.text = DiversityManager.getString("TotemOfferUI","txtDayAttr");
            _loc12_ = JSONUtil.getObject(this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1],["level",this._currentLv - 1,"attr"]);
            for(_loc13_ in _loc12_)
            {
               _loc3_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc13_),_loc12_[_loc13_]) + "\r";
               _loc4_ += RoleAttributesModifierEnum.getAttributesName(int(_loc13_)) + ":\r";
            }
            txtAttr.text = _loc3_;
            txtNameAttr.text = _loc4_;
            _loc12_ = JSONUtil.getObject(this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1],["level",this._currentLv,"attr"]);
            for(_loc13_ in _loc12_)
            {
               _loc5_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc13_),_loc12_[_loc13_]) + "\r";
               _loc6_ += RoleAttributesModifierEnum.getAttributesName(int(_loc13_)) + ":\r";
            }
            this.itemObj = JSONUtil.getObject(this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1],["level",this._currentLv,"upItem"]);
            this.gold = JSONUtil.getInt(this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1],["level",this._currentLv,"upGold"]);
            txtNextAttr.text = _loc5_;
            txtNameNextAttr.text = _loc6_;
            cmdOffer.enabled = true;
         }
         if(this.obf_9_9_3410 >= this.obf_b_6_3110["stage"].length && this._currentLv >= this.obf_b_6_3110["stage"][this.obf_b_6_3110["stage"].length - 1]["level"].length)
         {
            cmdOffer.enabled = false;
         }
         if(this.obf_9_9_3410 > 0 && !this.obf_b_6_3110["stage"][this.obf_9_9_3410 - 1]["level"][this._currentLv])
         {
            txtNextDayAttr.text = DiversityManager.getString("TotemOfferUI","maxOffer");
         }
         else
         {
            txtNextDayAttr.text = DiversityManager.getString("TotemOfferUI","txtNextDayAttr");
         }
         goldPoint.addChild(obf_a_f_2935.getGoldDisplay(this.gold));
         var _loc7_:Array = new Array();
         for(_loc8_ in this.itemObj)
         {
            _loc7_.push({
               "itemCode":_loc8_,
               "itemCount":this.itemObj[_loc8_]
            });
         }
         _loc7_.sortOn("itemCode");
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            if(_loc9_ >= this.allBags.length)
            {
               break;
            }
            _loc14_ = this.allBags[_loc9_];
            _loc15_ = IconItemManager.getIconItemByCode(_loc7_[_loc9_].itemCode,"");
            _loc15_.itemCount = _loc7_[_loc9_].itemCount;
            if(GameContext.bagItemManager.getHaveItemCount(_loc15_.itemCode,true) < _loc15_.itemCount)
            {
               _loc15_.countTextColor = 16711680;
            }
            _loc14_.pushIconItem(_loc15_);
            _loc9_++;
         }
      }
      
      private function clear() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.allBags)
         {
            _loc1_.dropIconItem();
         }
         while(goldPoint.numChildren > 0)
         {
            goldPoint.removeChildAt(0);
         }
         txtAttr.text = "";
         txtNameAttr.text = "";
         txtNextAttr.text = "";
         txtNameNextAttr.text = "";
      }
      
      public function getIconItemBags() : Array
      {
         return this.allBags;
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
         DiversityManager.setTextField(txtNextDayAttr,"TotemOfferUI","txtNextDayAttr");
         cmdOffer.label = DiversityManager.getString("TotemOfferUI","cmdOffer");
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
         this.removeListener();
      }
   }
}

