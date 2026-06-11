package com.sunweb.game.rpg.playerUI.favor
{
   import obf_R_w_4473.obf_A_S_2214;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import playerUI.FavorUIMC;
   
   public class obf_0_9_B_282 extends FavorUIMC implements IPlayerUI, IIconItemUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private static var mouseTipMapI:Dictionary = new Dictionary();
      
      private var bags:Array;
      
      private var itemBag1:IconItemBag;
      
      private var itemBag2:IconItemBag;
      
      private var itemBag3:IconItemBag;
      
      private var lvNum:int = 15;
      
      private var obf_9_g_2823:Array;
      
      private var obf_n_c_2100:Array;
      
      private var interval:int;
      
      private var index:int = 0;
      
      private var obf_B_W_3329:String = "";
      
      public function obf_0_9_B_282()
      {
         var _loc2_:MovieClip = null;
         this.obf_n_c_2100 = new Array();
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         num1.mouseEnabled = false;
         num2.mouseEnabled = false;
         num3.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.bags = new Array();
         this.itemBag1 = new IconItemBag(iconItem1,this,0);
         this.itemBag1.lockDrag = true;
         this.itemBag1.addValidType(GameItemType.ALL);
         this.bags.push(this.itemBag1);
         this.itemBag2 = new IconItemBag(iconItem2,this,1);
         this.itemBag2.lockDrag = true;
         this.itemBag2.addValidType(GameItemType.ALL);
         this.bags.push(this.itemBag2);
         this.itemBag3 = new IconItemBag(iconItem3,this,2);
         this.itemBag3.lockDrag = true;
         this.itemBag3.addValidType(GameItemType.ALL);
         this.bags.push(this.itemBag3);
         var _loc1_:int = 1;
         while(_loc1_ <= this.lvNum)
         {
            _loc2_ = this.favorLv["lv" + _loc1_];
            _loc2_.gotoAndStop("dark");
            _loc1_++;
         }
         this.showIcon(0);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdFavor.addEventListener(MouseEvent.CLICK,this.obf_0_6_j_570);
         var _loc1_:int = 1;
         while(_loc1_ <= this.lvNum)
         {
            this.addUIMouseToolTip(this.favorLv["lv" + _loc1_],0,_loc1_);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdFavor.removeEventListener(MouseEvent.CLICK,this.obf_0_6_j_570);
         var _loc1_:int = 1;
         while(_loc1_ <= this.lvNum)
         {
            this.removeUIMouseToolTip(this.favorLv["lv" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int, param3:int) : void
      {
         mouseTipMap[param1] = param2;
         mouseTipMapI[param1] = param3;
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
         var _loc4_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("FavorMouseTip");
         var _loc3_:int = 200;
         _loc3_ = 150;
         var _loc5_:Array = obf_A_S_2214.getFavorValues();
         if(_loc5_[mouseTipMapI[param1.currentTarget] - 1])
         {
            _loc4_ = _loc5_[mouseTipMapI[param1.currentTarget] - 1].tips;
         }
         if(_loc4_)
         {
            _loc2_.addTipInfo("<P align=\'left\'><FONT color=\'#FFFF00\'>" + _loc4_ + "</FONT>",_loc3_,_loc2_.maxRow + 1);
            GameTipManager.showTip(_loc2_);
            return;
         }
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("FavorMouseTip");
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
      
      private function obf_0_6_j_570(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc6_:IconItemBag = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:IconItemBag = null;
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         var _loc5_:Boolean = false;
         for each(_loc6_ in this.bags)
         {
            if(_loc6_.haveIconItem)
            {
               if(_loc2_[_loc6_.haveIconItem.itemCode] != null)
               {
                  _loc8_ = int(_loc2_[_loc6_.haveIconItem.itemCode]);
                  _loc8_ = _loc8_ + _loc6_.haveIconItem.itemCount;
                  _loc2_[_loc6_.haveIconItem.itemCode] = _loc8_;
                  _loc4_ = int(obf_A_S_2214.getItemOffers()[_loc6_.haveIconItem.itemCode]);
                  _loc3_ += _loc8_ * _loc4_;
               }
               else
               {
                  _loc2_[_loc6_.haveIconItem.itemCode] = _loc6_.haveIconItem.itemCount;
                  _loc4_ = int(obf_A_S_2214.getItemOffers()[_loc6_.haveIconItem.itemCode]);
                  _loc3_ += _loc6_.haveIconItem.itemCount * _loc4_;
               }
               _loc5_ = true;
            }
         }
         for(_loc7_ in _loc2_)
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc7_,true) < _loc2_[_loc7_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
               for each(_loc9_ in this.bags)
               {
                  _loc9_.dropIconItem();
               }
               return;
            }
         }
         if(_loc5_ == false)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","pushItem"));
            return;
         }
         obf_A_S_2214.sendFavor(_loc2_);
         cmdFavor.enabled = false;
         this.checkofferLv(_loc3_);
      }
      
      private function showIcon(param1:int) : void
      {
         var _loc2_:int = 1;
         while(_loc2_ <= 5)
         {
            this["lv" + _loc2_].filters = [obf_9_V_1635.getGrayFilter()];
            _loc2_++;
         }
         if(param1 < 1)
         {
            return;
         }
         this.index = 0;
         clearInterval(this.interval);
         this.interval = setInterval(this.showEffect,300,param1);
      }
      
      private function showEffect(param1:int) : void
      {
         var lv:int = param1;
         ++this.index;
         if(this.index > lv)
         {
            clearInterval(this.interval);
            this.obf_0___S_295(obf_A_S_2214.getOfferValues()[lv - 1].tips);
            setTimeout(function():void
            {
               interval = setInterval(showBackEffect,200);
            },2500);
            return;
         }
         if(this.index == lv)
         {
            this.showShineEffect(lv);
         }
         this["lv" + this.index].filters = [];
      }
      
      private function showBackEffect() : void
      {
         this.removeShineEffect();
         --this.index;
         if(this.index < 1)
         {
            cmdFavor.enabled = true;
            clearInterval(this.interval);
            return;
         }
         this["lv" + this.index].filters = [obf_9_V_1635.getGrayFilter()];
      }
      
      private function showShineEffect(param1:int) : void
      {
         while(this["effectPoint" + param1].numChildren > 0)
         {
            this["point" + param1].removeChildAt(0);
         }
         obf_0_P_4381.obf_m_X_1194("shine" + param1 + "@favorEffect",this["effectPoint" + param1]);
      }
      
      private function removeShineEffect() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            while(this["effectPoint" + _loc1_].numChildren > 0)
            {
               this["effectPoint" + _loc1_].removeChildAt(0);
            }
            _loc1_++;
         }
      }
      
      private function checkofferLv(param1:int) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in obf_A_S_2214.getOfferValues())
         {
            if(_loc2_.min <= param1 && param1 <= _loc2_.max)
            {
               this.showIcon(obf_A_S_2214.getOfferValues().indexOf(_loc2_) + 1);
            }
            else if(param1 > obf_A_S_2214.getOfferValues()[obf_A_S_2214.getOfferValues().length - 1].max)
            {
               this.showIcon(obf_A_S_2214.getOfferValues().length);
            }
         }
      }
      
      private function checkFavorLv(param1:int) : int
      {
         var _loc2_:Object = null;
         if(!obf_A_S_2214.getFavorValues())
         {
            return -1;
         }
         if(param1 > 0)
         {
            for each(_loc2_ in obf_A_S_2214.getFavorValues())
            {
               if(param1 >= obf_A_S_2214.getFavorValues()[obf_A_S_2214.getFavorValues().length - 1].offerValue)
               {
                  return obf_A_S_2214.getFavorValues().length;
               }
               if(param1 < _loc2_.offerValue)
               {
                  return obf_A_S_2214.getFavorValues().indexOf(_loc2_) - 1;
               }
            }
         }
         return -1;
      }
      
      public function refrshFaverLv(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:int = this.checkFavorLv(param1);
         var _loc3_:int = 1;
         while(_loc3_ <= _loc2_ + 1)
         {
            _loc4_ = this.favorLv["lv" + _loc3_];
            if(_loc4_)
            {
               _loc4_.gotoAndStop("shine");
            }
            _loc3_++;
         }
         favorValue.text = param1 + "";
      }
      
      public function getOfferFavorValue() : int
      {
         return int(favorValue.text);
      }
      
      private function obf_0___S_295(param1:String) : void
      {
         this.obf_B_W_3329 += param1 + "\n";
         txtFavorRemark.htmlText = this.obf_B_W_3329;
         obf_H_w_3575.update();
      }
      
      private function obf_0_4_K_719() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
         txtFavorRemark.htmlText = "";
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
         DiversityManager.setTextField(txtFavorValue,"favorUI","txtFavorValue");
         DiversityManager.setTextField(num1,"favorUI","num1");
         DiversityManager.setTextField(num2,"favorUI","num2");
         DiversityManager.setTextField(num3,"favorUI","num3");
         cmdFavor.label = DiversityManager.getString("favorUI","cmdFavor");
         txtRemark.htmlText = obf_A_S_2214.getRemark();
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_0_4_K_719();
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
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         param1.dropIconItem();
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         if(Boolean(obf_A_S_2214.getStuffs()) && obf_A_S_2214.getStuffs().indexOf(param2.itemCode) < 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","dontItem"));
            return;
         }
         if(param1 == this.itemBag1)
         {
            param2.itemCount = 5;
            if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) < param2.itemCount)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
               return;
            }
            this.itemBag1.dropIconItem();
            this.itemBag1.pushIconItem(param2);
         }
         else if(param1 == this.itemBag2)
         {
            param2.itemCount = 10;
            if(Boolean(this.itemBag1.haveIconItem) && param2.itemCode == this.itemBag1.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) - this.itemBag1.haveIconItem.itemCount < param2.itemCount)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
                  return;
               }
            }
            else if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) < param2.itemCount)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
               return;
            }
            this.itemBag2.dropIconItem();
            this.itemBag2.pushIconItem(param2);
         }
         else if(param1 == this.itemBag3)
         {
            param2.itemCount = 30;
            if(Boolean(this.itemBag1.haveIconItem && this.itemBag2.haveIconItem) && Boolean(param2.itemCode == this.itemBag1.haveIconItem.itemCode) && param2.itemCode == this.itemBag2.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) - this.itemBag1.haveIconItem.itemCount - this.itemBag2.haveIconItem.itemCount < param2.itemCount)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
                  return;
               }
            }
            else if(Boolean(this.itemBag1.haveIconItem) && param2.itemCode == this.itemBag1.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) - this.itemBag1.haveIconItem.itemCount < param2.itemCount)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
                  return;
               }
            }
            else if(Boolean(this.itemBag2.haveIconItem) && param2.itemCode == this.itemBag2.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) - this.itemBag2.haveIconItem.itemCount < param2.itemCount)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
                  return;
               }
            }
            else if(GameContext.bagItemManager.getHaveItemCount(param2.itemCode,true) < param2.itemCount)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("favorUI","noItemNum"));
               return;
            }
            this.itemBag3.dropIconItem();
            this.itemBag3.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

