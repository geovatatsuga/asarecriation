package com.sunweb.game.rpg.playerUI.shop
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.PlayerMenuItem;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import playerUI.NewLeadsBox;
   
   public class obf_t_u_3691 extends NewLeadsBox
   {
      
      private var money:int;
      
      private var obf_o_i_4179:int;
      
      private var _iconBag:IconItemBag;
      
      public var fashionShow:Boolean = true;
      
      private var itemCount:int;
      
      private var obf_L_J_3119:int = 0;
      
      private var isBoon:Boolean = false;
      
      private var obf_O_g_4193:TimeLimiter = new TimeLimiter(500);
      
      private var obf_j_B_1080:int;
      
      public function obf_t_u_3691(param1:IIconItemUI, param2:Boolean = false)
      {
         super();
         this.initDiversity();
         this.isBoon = param2;
         var _loc3_:int = this.getChildIndex(iconBar);
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtBuy,"ShopBoxUI","txtBuy");
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         this._iconBag.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         this._iconBag.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function obf_C_N_3764(param1:MouseEvent) : void
      {
         var _loc3_:PeriodCounterItemInfo = null;
         var _loc4_:PlayerMenuUI = null;
         var _loc5_:Array = null;
         var _loc6_:Point = null;
         var _loc7_:PlayerMenuItem = null;
         param1.stopImmediatePropagation();
         if(!this._iconBag || !this._iconBag.haveIconItem || param1.ctrlKey)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this._iconBag.haveIconItem.itemCode);
         if(!_loc2_)
         {
            return;
         }
         if(this.isBoon)
         {
            _loc3_ = obf_Y_F_1424.getCounter(obf_K_e_3075.obf_S_w_2923.obf_V_S_2931);
            if(JSONUtil.getInt(_loc3_,["numOfDay"]) > 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("DayBonusUI","dayBuyOne"));
               return;
            }
            if(_loc2_.type == GameItemType.RIDE)
            {
               if(!obf_K_e_3075.rideBoxUI.haveEmptyBag(1))
               {
                  WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerRideBagFull"));
                  return;
               }
            }
            else if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
            {
               WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
               return;
            }
            if(_loc2_.moneyPrice > 0)
            {
               if(GameContext.localPlayer.fullInfo.money < obf_K_e_3075.obf_S_w_2923.getRebateRound(GameItemManager.getItemMoneyBuy(this._iconBag.haveIconItem.itemCode)))
               {
                  obf_K_e_3075.showShortOfMoney();
                  return;
               }
            }
            else if(_loc2_.goldPrice > 0)
            {
               if(GameContext.localPlayer.fullInfo.gold < obf_K_e_3075.obf_S_w_2923.getRebateRound(GameItemManager.getItemGoldBuy(this._iconBag.haveIconItem.itemCode)))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
                  return;
               }
            }
            else if(_loc2_.coinPrice > 0)
            {
               if(GameContext.localPlayer.fullInfo.coin < obf_K_e_3075.obf_S_w_2923.getRebateRound(GameItemManager.getItemCoinBuy(this._iconBag.haveIconItem.itemCode)))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreCoin"));
                  return;
               }
            }
            WindowManager.showConfirmBox(DiversityManager.getString("DayBonusUI","isBuy"),this.sureDo);
         }
         else
         {
            ShopManager.obf_8_q_3951 = 0;
            _loc4_ = new PlayerMenuUI("shopBuyMenu");
            if(JSONUtil.getInt(_loc2_,["goldPrice"]) > 0)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"goldBuy",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuGoldBuy"),
                     "fun":this.obf_0_8_N_104,
                     "par":[ShopManager.obf_v_5_3425,this._iconBag.haveIconItem.itemCode]
                  }
               }]);
            }
            if(JSONUtil.getInt(_loc2_,["moneyPrice"]) > 0)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"moneyBuy",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuMoneyBuy"),
                     "fun":this.obf_0_8_N_104,
                     "par":[ShopManager.obf_B_9_2165,this._iconBag.haveIconItem.itemCode]
                  }
               }]);
            }
            if(JSONUtil.getInt(_loc2_,["coinPrice"]) > 0)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"coinBuy",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuCoinBuy"),
                     "fun":this.obf_0_8_N_104,
                     "par":[ShopManager.obf_g_G_1313,this._iconBag.haveIconItem.itemCode]
                  }
               }]);
            }
            if(this._iconBag.haveIconItem is IconItemEquip && this.fashionShow)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"fashionView",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuView"),
                     "fun":this.fashionView,
                     "par":[]
                  }
               }]);
            }
            if(this._iconBag.haveIconItem is IconItemRide && this.fashionShow)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"rideView",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuView"),
                     "fun":this.rideView,
                     "par":[]
                  }
               }]);
            }
            if(JSONUtil.getInt(_loc2_,["moneyPrice"]) > 0 && !JSONUtil.getBoolean(_loc2_,["noGive"]))
            {
               _loc5_ = [].concat(FriendManager.getOnlineFriendNams(),FriendManager.getOfflineFriendNams());
               _loc4_.addMenuItemByObject([{
                  "id":"gift",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuGift"),
                     "fun":WindowManager.showModalWindow,
                     "par":[new InputBoxModule(DiversityManager.getString("ShopPrompt","giftPrompt"),_loc5_,this._iconBag.haveIconItem.itemCode),this.giftToPlayer]
                  }
               }]);
            }
            if(this.obf_o_i_4179 > 0)
            {
               _loc4_.addMenuItemByObject([{
                  "id":"payBuy",
                  "value":{
                     "label":DiversityManager.getString("ShopPrompt","menuPayBuy"),
                     "fun":this.obf_0_8_N_104,
                     "par":[ShopManager.obf_K_f_849,this._iconBag.haveIconItem.itemCode]
                  }
               }]);
            }
            if(_loc4_.obf_0_0_a_217 > 1)
            {
               _loc6_ = this.localToGlobal(new Point(this.mouseX,this.mouseY));
               _loc4_.x = _loc6_.x;
               _loc4_.y = _loc6_.y;
               WindowManager.showWindow(_loc4_);
            }
            else
            {
               _loc7_ = _loc4_.getMenuItemByIndex(0);
               if(_loc7_)
               {
                  _loc7_.doAction();
               }
            }
         }
      }
      
      private function fashionView() : void
      {
         if(!this._iconBag || !this._iconBag.haveIconItem || !(this._iconBag.haveIconItem is IconItemEquip))
         {
            return;
         }
         if(!obf_K_e_3075.fashionViewUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.fashionViewUI);
         }
         obf_K_e_3075.fashionViewUI.obf_T_E_3576((this._iconBag.haveIconItem as IconItemEquip).modelCode,EquipmentKind.getViewKindString((this._iconBag.haveIconItem as IconItemEquip).kind));
      }
      
      private function rideView() : void
      {
         if(!this._iconBag || !this._iconBag.haveIconItem || !(this._iconBag.haveIconItem is IconItemRide))
         {
            return;
         }
         if(!obf_K_e_3075.fashionViewUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.fashionViewUI);
         }
         obf_K_e_3075.fashionViewUI.setRide((this._iconBag.haveIconItem as IconItemRide).rideModelCode);
      }
      
      private function giftToPlayer(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            this.obf_0_8_N_104(ShopManager.obf_B_9_2165,param1.par,param1.content);
         }
      }
      
      private function obf_0_8_N_104(param1:int, param2:String, param3:String = "") : void
      {
         var _loc4_:ShopBuyEvent = new ShopBuyEvent(ShopBuyEvent.SHOP_BUY);
         _loc4_.itemCode = param2;
         _loc4_.buyType = param1;
         _loc4_.toPlayerId = param3;
         _loc4_.itemType = 1;
         _loc4_.leadPrice = this.money;
         _loc4_.itemCount = this.itemCount;
         if(this.itemCount <= 0)
         {
            return;
         }
         this.dispatchEvent(_loc4_);
      }
      
      private function sureDo(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_v_1_1352.sendBoon();
         }
      }
      
      public function setName(param1:String) : void
      {
         goodsRemark.htmlText = param1;
      }
      
      public function setItemCount(param1:int) : void
      {
         this.itemCount = param1;
         txtLeavings.text = DiversityManager.getString("ShopBoxUI","txtLeavings",[param1]);
         if(param1 >= 50)
         {
            txtLeavings.textColor = 65280;
         }
         else if(param1 >= 20)
         {
            txtLeavings.textColor = 14709529;
         }
         else
         {
            txtLeavings.textColor = 16711680;
         }
      }
      
      public function setPrice(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         if(param1 == 0)
         {
            _loc4_ = obf_a_f_2935.getMoneyDisplay(param2,16711680);
            _loc4_.scaleX = 1.1;
            _loc4_.scaleY = 1.1;
            _loc5_ = obf_a_f_2935.getMoneyDisplay(param3,65280);
         }
         else if(param1 == 1)
         {
            _loc4_ = obf_a_f_2935.getGoldDisplay(param2,16711680);
            _loc4_.scaleX = 1.1;
            _loc4_.scaleY = 1.1;
            _loc5_ = obf_a_f_2935.getGoldDisplay(param3,65280);
         }
         else if(param1 == 2)
         {
            _loc4_ = obf_a_f_2935.getCoinDisplay(param2,16711680);
            _loc4_.scaleX = 1.1;
            _loc4_.scaleY = 1.1;
            _loc5_ = obf_a_f_2935.getCoinDisplay(param3,65280);
         }
         this.money = param3;
         line.width = _loc4_.width;
         while(pricePoint.numChildren > 0)
         {
            pricePoint.removeChildAt(0);
         }
         pricePoint.addChild(_loc4_);
         while(priceNewPoint.numChildren > 0)
         {
            priceNewPoint.removeChildAt(0);
         }
         priceNewPoint.addChild(_loc5_);
      }
      
      private function enter_frame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!this.obf_O_g_4193.checkTimeout())
         {
            return;
         }
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(this.obf_L_J_3119 > 0)
         {
            _loc2_ = this.getDurationTimeInMS(this.obf_L_J_3119,this.obf_j_B_1080);
            if(_loc2_ <= 0)
            {
               _loc2_ = 0;
               this.obf_L_J_3119 = 0;
            }
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
      
      public function setNextRefreshTimes(param1:int) : void
      {
         this.obf_L_J_3119 = param1;
         this.obf_j_B_1080 = getTimer();
      }
      
      public function getDurationTimeInMS(param1:int, param2:int) : Number
      {
         return param1 * 1000 - (getTimer() - param2);
      }
   }
}

