package com.sunweb.game.rpg.playerUI.itemManual
{
   import obf_Z_Y_1344.ItemManualManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import playerUI.ItemManualIcon;
   import playerUI.ItemManualUIMC;
   
   public class ItemManualUI extends ItemManualUIMC implements IPlayerUI, IIconItemUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private static var mouseTipMapI:Dictionary = new Dictionary();
      
      private var bags:Array;
      
      private var iconBags:Array;
      
      private var buttonArr:Array;
      
      private var allItemManualArr:Array;
      
      private var successArr:Array;
      
      private var selectButtonType:int = 0;
      
      private var obf_T_u_4038:Object;
      
      private var obf_j_W_3386:int;
      
      private var obf_m_h_2373:Array;
      
      private var obf_s_f_2004:Array;
      
      private var obf_m_G_3836:Boolean = true;
      
      public function ItemManualUI()
      {
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         this.obf_m_h_2373 = new Array();
         this.obf_s_f_2004 = new Array();
         super();
         this.visible = false;
         this.onResize(null);
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         bgBox1.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         this.initDiversity();
         this.bags = new Array();
         this.iconBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc5_ = this["icon" + _loc1_];
            if(_loc5_)
            {
               _loc6_ = new IconItemBag(_loc5_,this,_loc1_);
               _loc6_.addValidType(GameItemType.ALL);
               _loc6_.lockDrag = true;
               _loc6_.showInfoTip = true;
               this.iconBags.push(_loc6_);
               this.bags.push(_loc6_);
            }
            _loc1_++;
         }
         this.buttonArr = [this.button0,this.button1,this.button2,this.button3,this.button4,this.button5,this.button6,this.button7];
         var _loc2_:Array = [{"label":DiversityManager.getString("ItemManualUI","showAll")},{"label":DiversityManager.getString("ItemManualUI","showDone")},{"label":DiversityManager.getString("ItemManualUI","showNotDone")}];
         listRank.dataProvider = new DataProvider(_loc2_);
         listRank.selectedIndex = 0;
         this.allItemManualArr = new Array();
         var _loc3_:Array = ItemManualManager.itemManualKind();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc4_].items;
            if(!_loc7_)
            {
               return;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc7_[_loc8_].itemCount = 0;
               _loc7_[_loc8_].id = _loc4_;
               this.allItemManualArr.push(_loc7_[_loc8_]);
               _loc8_++;
            }
            _loc4_++;
         }
         this.successArr = new Array();
         this.successArr = ItemManualManager.itemManualSuccess();
         this.obf_x_v_2806();
      }
      
      public function itemManualMap(param1:Object) : void
      {
         var _loc3_:String = null;
         this.obf_T_u_4038 = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.allItemManualArr.length)
         {
            for(_loc3_ in param1)
            {
               if(_loc3_ == this.allItemManualArr[_loc2_].code)
               {
                  this.allItemManualArr[_loc2_].itemCount += param1[_loc3_];
                  break;
               }
            }
            _loc2_++;
         }
         this.setShowBagType(this.selectButtonType);
      }
      
      public function itemManualChange(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.allItemManualArr.length)
         {
            for(_loc3_ in param1)
            {
               if(_loc3_ == this.allItemManualArr[_loc2_].code)
               {
                  this.allItemManualArr[_loc2_].itemCount = param1[_loc3_];
                  break;
               }
            }
            _loc2_++;
         }
         this.setShowBagType(this.selectButtonType);
      }
      
      public function starValue(param1:int) : void
      {
         this.obf_j_W_3386 = param1;
         DiversityManager.setTextField(txtAll,"ItemManualUI","txtAll",[param1]);
         DiversityManager.setTextField(txtOne,"ItemManualUI","txtNeed",[ItemManualManager.itemManualLotteryNeed()]);
         DiversityManager.setTextField(txtTen,"ItemManualUI","txtNeed",[ItemManualManager.itemManualLotteryNeed() * 10]);
      }
      
      public function awardSuccessIds(param1:Array) : void
      {
         this.obf_s_f_2004 = param1;
         this.setShowBagType(this.buttonArr.length - 1);
      }
      
      public function successIds(param1:Array) : void
      {
         this.obf_m_h_2373 = param1;
         this.setShowBagType(this.buttonArr.length - 1);
      }
      
      public function getCodes(param1:Array) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:int = 0;
         var _loc5_:IconItemBag = null;
         var _loc6_:IconItem = null;
         var _loc7_:int = 0;
         for each(_loc2_ in this.iconBags)
         {
            _loc2_.dropIconItem();
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ >= this.iconBags.length)
            {
               break;
            }
            _loc5_ = this.iconBags[_loc3_];
            _loc6_ = IconItemManager.getIconItemByCode(param1[_loc3_],"");
            if(Boolean(_loc5_) && Boolean(_loc6_))
            {
               _loc6_.itemCount = 1;
               _loc5_.dropIconItem();
               _loc5_.pushIconItem(_loc6_);
               _loc7_ = 0;
               while(_loc7_ < this.allItemManualArr.length)
               {
                  if(param1[_loc3_] == this.allItemManualArr[_loc7_].code)
                  {
                     this.allItemManualArr[_loc7_].itemCount += 1;
                     this.addUIMouseToolTip(_loc6_,this.allItemManualArr[_loc7_],0);
                     break;
                  }
                  _loc7_++;
               }
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.successArr.length)
         {
            if(this.obf_m_h_2373.indexOf(this.successArr[_loc4_].id) <= -1)
            {
               if(ConditionScript.checkCondition(this.successArr[_loc4_].condition,null,false))
               {
                  ItemManualManager.sendItemManualSuccessReq(this.successArr[_loc4_].id);
               }
            }
            _loc4_++;
         }
         this.setShowBagType(this.selectButtonType);
      }
      
      private function obf_x_v_2806() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdSummonOne.addEventListener(MouseEvent.CLICK,this.obf_0_5_p_234);
         cmdSummonTen.addEventListener(MouseEvent.CLICK,this.obf_w_D_1925);
         listRank.addEventListener(Event.CHANGE,this.onList);
         for each(_loc1_ in this.buttonArr)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickButton);
         }
         _loc2_ = 0;
         while(_loc2_ < this.buttonArr.length)
         {
            this.buttonArr[_loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.obf_1_7_2698);
            this.buttonArr[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.obf_x_4_4259);
            _loc2_++;
         }
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function removerLsiten() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdSummonOne.removeEventListener(MouseEvent.CLICK,this.obf_0_5_p_234);
         cmdSummonTen.removeEventListener(MouseEvent.CLICK,this.obf_w_D_1925);
         listRank.removeEventListener(Event.CHANGE,this.onList);
         for each(_loc1_ in this.buttonArr)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         }
         _loc2_ = 0;
         while(_loc2_ < this.buttonArr.length)
         {
            this.buttonArr[_loc2_].removeUIMouseToolTip(MouseEvent.MOUSE_OVER,this.obf_1_7_2698);
            this.buttonArr[_loc2_].removeUIMouseToolTip(MouseEvent.MOUSE_OUT,this.obf_x_4_4259);
            _loc2_++;
         }
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
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
      
      private function obf_0_5_p_234(param1:Event) : void
      {
         if(this.obf_j_W_3386 < ItemManualManager.itemManualLotteryNeed())
         {
            WindowManager.showMessageBox(DiversityManager.getString("ItemManualUI","warn_NotStar"));
            return;
         }
         ItemManualManager.sendItemManualLotteryReq(0);
      }
      
      private function obf_w_D_1925(param1:Event) : void
      {
         if(this.obf_j_W_3386 < ItemManualManager.itemManualLotteryNeed() * 10)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ItemManualUI","warn_NotStar"));
            return;
         }
         ItemManualManager.sendItemManualLotteryReq(1);
      }
      
      private function onList(param1:Event) : void
      {
         this.setShowBagType(this.selectButtonType);
      }
      
      private function onClickButton(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.buttonArr.length)
         {
            if(this.buttonArr[_loc2_].name == param1.currentTarget.name)
            {
               this.setShowBagType(_loc2_);
               this.selectButtonType = _loc2_;
               this.buttonArr[_loc2_].filters = [obf_9_V_1635.getHighLightFilter()];
            }
            else
            {
               this.buttonArr[_loc2_].filters = [];
            }
            _loc2_++;
         }
      }
      
      private function onScrollList(param1:Event) : void
      {
         itemPoint.scrollRect = new Rectangle(0,obf_H_w_3575.scrollPosition,obf_H_w_3575.x - itemPoint.x,itemPoint.height);
      }
      
      private function setShowBagType(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:ItemManualIcon = null;
         var _loc7_:IconItem = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:IconItem = null;
         var _loc11_:* = undefined;
         while(itemPoint.numChildren > 0)
         {
            itemPoint.removeChildAt(0);
         }
         mouseTipMap = new Dictionary();
         var _loc2_:int = -1;
         var _loc3_:int = 2;
         var _loc4_:int = 0;
         itemPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height);
         if(param1 < this.buttonArr.length - 1)
         {
            listRank.visible = true;
            this.allItemManualArr.sortOn("itemCount",Array.NUMERIC | Array.DESCENDING);
            _loc5_ = 0;
            while(_loc5_ < this.allItemManualArr.length)
            {
               if(param1 == this.allItemManualArr[_loc5_].id)
               {
                  _loc6_ = new ItemManualIcon();
                  _loc7_ = IconItemManager.getIconItemByCode(this.allItemManualArr[_loc5_].code,"");
                  if(_loc7_)
                  {
                     if(listRank.selectedIndex == 0)
                     {
                        if(this.allItemManualArr[_loc5_].itemCount != 0)
                        {
                           _loc7_.itemCount = this.allItemManualArr[_loc5_].itemCount;
                           _loc6_.filters = [];
                           if(this.allItemManualArr[_loc5_].itemCount > 1)
                           {
                              _loc6_.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
                           }
                        }
                        else
                        {
                           _loc6_.filters = [obf_9_V_1635.getGrayFilter()];
                        }
                        _loc6_.addChild(_loc7_);
                        this.addUIMouseToolTip(_loc7_,this.allItemManualArr[_loc5_],1);
                        if(++_loc2_ > 5)
                        {
                           _loc2_ = 0;
                           _loc3_ += _loc6_.height + 2;
                        }
                        _loc6_.x = 40 * _loc2_ + 2;
                        _loc6_.y = _loc3_;
                        _loc4_ = _loc6_.y + _loc6_.height;
                        itemPoint.addChild(_loc6_);
                     }
                     else if(listRank.selectedIndex == 1)
                     {
                        if(this.allItemManualArr[_loc5_].itemCount != 0)
                        {
                           _loc7_.itemCount = this.allItemManualArr[_loc5_].itemCount;
                           _loc6_.filters = [];
                           _loc6_.addChild(_loc7_);
                           this.addUIMouseToolTip(_loc7_,this.allItemManualArr[_loc5_],1);
                           if(this.allItemManualArr[_loc5_].itemCount > 1)
                           {
                              _loc6_.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
                           }
                           if(++_loc2_ > 5)
                           {
                              _loc2_ = 0;
                              _loc3_ += _loc6_.height + 2;
                           }
                           _loc6_.x = 40 * _loc2_ + 2;
                           _loc6_.y = _loc3_;
                           _loc4_ = _loc6_.y + _loc6_.height;
                           itemPoint.addChild(_loc6_);
                        }
                     }
                     else if(this.allItemManualArr[_loc5_].itemCount == 0)
                     {
                        _loc6_.filters = [obf_9_V_1635.getGrayFilter()];
                        _loc6_.addChild(_loc7_);
                        this.addUIMouseToolTip(_loc7_,this.allItemManualArr[_loc5_],1);
                        if(++_loc2_ > 5)
                        {
                           _loc2_ = 0;
                           _loc3_ += _loc6_.height + 2;
                        }
                        _loc6_.x = 40 * _loc2_ + 2;
                        _loc6_.y = _loc3_;
                        _loc4_ = _loc6_.y + _loc6_.height;
                        itemPoint.addChild(_loc6_);
                     }
                  }
               }
               _loc5_++;
            }
         }
         else if(param1 == this.buttonArr.length - 1)
         {
            listRank.visible = false;
            _loc8_ = 0;
            while(_loc8_ < this.successArr.length)
            {
               _loc9_ = this.successArr[_loc8_];
               _loc10_ = IconItemManager.getIconItemByCode(_loc9_.award,"");
               _loc11_ = new ItemmanualCeilUI(this);
               _loc11_.iconBag.pushIconItem(_loc10_);
               this.bags.push(_loc11_.iconBag);
               _loc11_.setName(_loc9_.name);
               _loc11_.setInfo(_loc9_.info);
               _loc11_.setExpBar(_loc9_.condition);
               if(_loc11_.setCond())
               {
                  _loc11_.filters = [];
               }
               else
               {
                  _loc11_.filters = [obf_9_V_1635.getGrayFilter()];
               }
               if(this.obf_m_h_2373.indexOf(_loc9_.id) > -1 && this.obf_s_f_2004.indexOf(_loc9_.id) == -1)
               {
                  _loc11_.cmdGet.enabled = false;
                  _loc11_.cmdGet.label = DiversityManager.getString("ItemManualUI","cmdGeted");
               }
               _loc11_.setPic(_loc9_.pic);
               _loc11_.setId(_loc9_.id);
               if(++_loc2_ > 0)
               {
                  _loc2_ = 0;
                  _loc3_ += _loc11_.height + 2;
               }
               _loc11_.x = 43 * _loc2_;
               _loc11_.y = _loc3_;
               _loc4_ = _loc11_.y + _loc11_.height;
               itemPoint.addChild(_loc11_);
               _loc8_++;
            }
         }
         if(_loc4_ > obf_H_w_3575.height)
         {
            obf_H_w_3575.maxScrollPosition = _loc4_ - obf_H_w_3575.height;
            obf_H_w_3575.visible = true;
         }
         else
         {
            obf_H_w_3575.visible = false;
         }
      }
      
      private function obf_C_N_3764(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:ItemManualSellCeil = new ItemManualSellCeil();
         _loc2_.getCode(param1.target.itemCode);
         WindowManager.showWindow(_loc2_);
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:Object, param3:int) : void
      {
         mouseTipMap[param1] = param3;
         mouseTipMapI[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         delete mouseTipMapI[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc9_:* = undefined;
         var _loc2_:GameTipUI = new GameTipUI("ItemManualMouseTip");
         var _loc3_:int = 200;
         var _loc4_:* = mouseTipMap[param1.currentTarget];
         var _loc5_:* = mouseTipMapI[param1.currentTarget];
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Object = new Object();
         _loc6_ = _loc5_.attr;
         var _loc7_:Object = GameItemManager.getItemConfig(_loc5_.code);
         var _loc8_:String = GameItemRank.getRankColor(_loc7_.rank).toString(16);
         _loc2_.addTipInfo("<P align=\'center\'><FONT size=\'14\' COLOR=\'#" + _loc8_ + "\'><B>" + GameItemManager.getItemName(_loc5_.code) + "</B></FONT></P>",_loc3_,_loc2_.maxRow);
         if(_loc6_)
         {
            for(_loc9_ in _loc6_)
            {
               _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc9_) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
               _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc9_,_loc6_[_loc9_]) + "</FONT></P>",_loc3_,_loc2_.maxRow);
            }
         }
         _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("ItemManualUI","itemPrice") + "</FONT>",_loc3_,_loc2_.maxRow + 1);
         _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + _loc5_.price + DiversityManager.getString("ItemManualUI","itemPrice1") + "</FONT></P>",_loc3_,_loc2_.maxRow);
         if(!obf_L_l_4100.isEmpty(_loc7_.remark))
         {
            _loc2_.addTipInfo(_loc7_.remark,_loc3_,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("ItemManualMouseTip");
      }
      
      private function obf_1_7_2698(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("ItemManualButtonMouseTip");
         _loc2_.addTipInfo(DiversityManager.getString("MouseToolTip","ItemManual_" + param1.target.name),100,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_x_4_4259(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("ItemManualButtonMouseTip");
      }
      
      public function getItemManualAll(param1:int) : int
      {
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.allItemManualArr.length)
         {
            _loc4_ = GameItemManager.getItemConfig(this.allItemManualArr[_loc3_].code);
            if((Boolean(_loc4_)) && Boolean(param1 == _loc4_.rank) && this.allItemManualArr[_loc3_].itemCount > 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
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
         DiversityManager.setTextField(txtDeyTitle,"ItemManualUI","txtDeyTitle");
         DiversityManager.setTextField(itemManualTxt,"ItemManualUI","itemManualTxt");
         DiversityManager.setTextField(txtOne,"ItemManualUI","txtNeed",[0]);
         DiversityManager.setTextField(txtTen,"ItemManualUI","txtNeed",[0]);
         DiversityManager.setTextField(txtAll,"ItemManualUI","txtAll",[0]);
         cmdSummonOne.label = DiversityManager.getString("ItemManualUI","cmdSummonOne");
         cmdSummonTen.label = DiversityManager.getString("ItemManualUI","cmdSummonTen");
      }
      
      public function showUI() : void
      {
         var _loc2_:int = 0;
         if(this.obf_m_G_3836)
         {
            _loc2_ = 0;
            while(_loc2_ < this.successArr.length)
            {
               if(this.obf_m_h_2373.indexOf(this.successArr[_loc2_].id) <= -1)
               {
                  if(ConditionScript.checkCondition(this.successArr[_loc2_].condition,null,false))
                  {
                     ItemManualManager.sendItemManualSuccessReq(this.successArr[_loc2_].id);
                  }
               }
               _loc2_++;
            }
            this.obf_m_G_3836 = false;
         }
         this.visible = true;
         var _loc1_:int = 0;
         while(_loc1_ < this.buttonArr.length)
         {
            if(_loc1_ == 0)
            {
               this.setShowBagType(_loc1_);
               this.selectButtonType = _loc1_;
               this.buttonArr[_loc1_].filters = [obf_9_V_1635.getHighLightFilter()];
            }
            else
            {
               this.buttonArr[_loc1_].filters = [];
            }
            _loc1_++;
         }
      }
      
      public function closeUI() : void
      {
         var _loc1_:IconItemBag = null;
         this.visible = false;
         for each(_loc1_ in this.iconBags)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function destroy() : void
      {
         this.removerLsiten();
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

