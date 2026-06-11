package com.sunweb.game.rpg.playerUI.shop
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.PlayerMenuItem;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import playerUI.GoodsBoxUIMC;
   
   public class GoodsBoxUI extends GoodsBoxUIMC
   {
      
      private var obf_o_i_4179:int;
      
      private var _iconBag:IconItemBag;
      
      public var fashionShow:Boolean = true;
      
      public function GoodsBoxUI(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
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
      
      private function obf_C_N_3764(param1:MouseEvent) : void
      {
         var _loc4_:Point = null;
         var _loc5_:PlayerMenuItem = null;
         if(!this._iconBag || !this._iconBag.haveIconItem || param1.ctrlKey)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this._iconBag.haveIconItem.itemCode);
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("shopBuyMenu",150);
         if(JSONUtil.getInt(_loc2_,["goldPrice"]) > 0)
         {
            _loc3_.addMenuItemByObject([{
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
            _loc3_.addMenuItemByObject([{
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
            _loc3_.addMenuItemByObject([{
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
            _loc3_.addMenuItemByObject([{
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
            _loc3_.addMenuItemByObject([{
               "id":"rideView",
               "value":{
                  "label":DiversityManager.getString("ShopPrompt","menuView"),
                  "fun":this.rideView,
                  "par":[]
               }
            }]);
         }
         if(this.obf_o_i_4179 > 0)
         {
            _loc3_.addMenuItemByObject([{
               "id":"payBuy",
               "value":{
                  "label":DiversityManager.getString("ShopPrompt","menuPayBuy"),
                  "fun":this.obf_0_8_N_104,
                  "par":[ShopManager.obf_K_f_849,this._iconBag.haveIconItem.itemCode]
               }
            }]);
         }
         if(_loc3_.obf_0_0_a_217 > 1)
         {
            _loc4_ = this.localToGlobal(new Point(this.mouseX,this.mouseY));
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
            WindowManager.showWindow(_loc3_);
         }
         else
         {
            _loc5_ = _loc3_.getMenuItemByIndex(0);
            if(_loc5_)
            {
               _loc5_.doAction();
            }
         }
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
         this.dispatchEvent(_loc4_);
      }
      
      public function setRemark(param1:String) : void
      {
         goodsRemark.text = param1;
      }
      
      public function setGold(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getGoldDisplay(param1);
         _loc2_.x = -_loc2_.width;
         while(goldPoint.numChildren > 0)
         {
            goldPoint.removeChildAt(0);
         }
         goldPoint.addChild(_loc2_);
      }
      
      public function setPay(param1:int) : void
      {
         this.obf_o_i_4179 = param1;
         var _loc2_:TextField = obf_9_V_1635.getNewTextField();
         DiversityManager.setTextField(_loc2_,"ShopBoxUI","txtPayPrice",[param1],true);
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
         while(goldPoint.numChildren > 0)
         {
            goldPoint.removeChildAt(0);
         }
         while(coinPoint.numChildren > 0)
         {
            coinPoint.removeChildAt(0);
         }
         moneyPoint.addChild(_loc2_);
      }
      
      public function setMoney(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getMoneyDisplay(param1);
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
         moneyPoint.addChild(_loc2_);
      }
      
      public function setCoin(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getCoinDisplay(param1);
         while(coinPoint.numChildren > 0)
         {
            coinPoint.removeChildAt(0);
         }
         coinPoint.addChild(_loc2_);
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
   }
}

