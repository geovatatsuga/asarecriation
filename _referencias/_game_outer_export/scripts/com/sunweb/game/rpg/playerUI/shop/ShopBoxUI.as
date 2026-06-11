package com.sunweb.game.rpg.playerUI.shop
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.module.obf_0_K_4070;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.ShopBoxUIMC;
   
   public class ShopBoxUI extends ShopBoxUIMC implements IIconItemUI, IPlayerUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var obf_E_l_1739:Array;
      
      private var obf_N_t_3283:int;
      
      private var pageSize:int = 12;
      
      private var obf_r_l_2445:String;
      
      private var obf_Y_n_3766:Array;
      
      private var _noviceSprite:Sprite;
      
      public function ShopBoxUI()
      {
         var _loc2_:String = null;
         var _loc3_:TableButton = null;
         var _loc4_:TableButton = null;
         this.bags = new Array();
         this.obf_E_l_1739 = new Array();
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         var _loc1_:Array = ShopManager.getStoreKinds();
         for each(_loc2_ in _loc1_)
         {
            _loc4_ = new TableButton();
            _loc4_.name = _loc2_;
            _loc4_.txtLabel.text = _loc2_;
            _loc4_.x = tableBox.width;
            _loc4_.gotoAndStop(1);
            tableBox.addChild(_loc4_);
            this.obf_E_l_1739.push(_loc4_);
         }
         _loc3_ = new TableButton();
         _loc3_.name = ShopManager.obf_R_c_3073;
         DiversityManager.setTextField(_loc3_.txtLabel,"ShopBoxUI","payType",null,true);
         _loc3_.x = tableBox.width;
         _loc3_.gotoAndStop(1);
         tableBox.addChild(_loc3_);
         this.obf_E_l_1739.push(_loc3_);
         this.obf_d_6_3571();
         this.addListener();
         if(Boolean(this.obf_E_l_1739) && this.obf_E_l_1739.length > 0)
         {
            (this.obf_E_l_1739[0] as TableButton).gotoAndStop(2);
         }
         this.showShop(ShopManager.getStoreItemListByKind(_loc1_[0]));
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyMainTitle,"ShopBoxUI","txtMainTitle");
         cmdResult.label = DiversityManager.getString("ShopBoxUI","txtResult");
         cmdPrvPage.label = DiversityManager.getString("ShopBoxUI","cmdPrvPage");
         cmdNextPage.label = DiversityManager.getString("ShopBoxUI","cmdNextPage");
      }
      
      public function get selectedType() : String
      {
         return this.obf_r_l_2445;
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "ShopUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:IconItemBag = null;
         for each(_loc3_ in this.bags)
         {
            if(Boolean(_loc3_.haveIconItem) && _loc3_.haveIconItem.itemCode == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         if(!_loc2_)
         {
            return null;
         }
         return this.globalToLocal(_loc2_.localToGlobal(new Point(16,16)));
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.bags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_0_3_2_688);
         }
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_0_3_2_688);
         }
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
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
      
      private function resetTabelButton() : void
      {
         var _loc1_:TableButton = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.gotoAndStop(1);
         }
      }
      
      private function obf_0_3_2_688(param1:Event) : void
      {
         this.obf_r_l_2445 = param1.currentTarget.name;
         this.resetTabelButton();
         param1.currentTarget.gotoAndStop(2);
         this.showShop(ShopManager.getStoreItemListByKind(param1.currentTarget.name),1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073);
         this.obf_d_6_3571();
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         if(param1.currentTarget == cmdPrvPage)
         {
            this.showShop(this.obf_Y_n_3766,this.obf_N_t_3283 - 1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073);
         }
         else if(param1.currentTarget == cmdNextPage)
         {
            this.showShop(this.obf_Y_n_3766,this.obf_N_t_3283 + 1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073);
         }
      }
      
      public function obf_8_4_3745() : void
      {
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
         while(coinPoint.numChildren > 0)
         {
            coinPoint.removeChildAt(0);
         }
         moneyPoint.addChild(obf_a_f_2935.getMoneyDisplay(GameContext.localPlayer.fullInfo.money));
         coinPoint.addChild(obf_a_f_2935.getCoinDisplay(GameContext.localPlayer.fullInfo.coin));
      }
      
      public function obf_d_6_3571() : void
      {
         txtDeyPay.text = "";
         txtPay.text = "";
         txtPayDatePrompt.text = "";
         if(this.obf_r_l_2445 == ShopManager.obf_R_c_3073)
         {
            DiversityManager.setTextField(txtDeyPay,"ShopBoxUI","txtPay",null,true);
            txtPay.text = GameContext.localPlayer.fullInfo.payMarks + "";
            if(ShopManager.obf_3_A_2009)
            {
               DiversityManager.setTextField(txtPayDatePrompt,"ShopBoxUI","txtPayDatePrompt",[ShopManager.obf_3_A_2009],true);
            }
         }
      }
      
      private function onBuyItem(param1:ShopBuyEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
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
         if(param1.buyType == ShopManager.obf_v_5_3425)
         {
            _loc3_ = SplitBoxUI.obf_Q_T_4344;
            _loc4_ = JSONUtil.getInt(_loc2_,["goldPrice"]);
         }
         else if(param1.buyType == ShopManager.obf_B_9_2165)
         {
            _loc3_ = SplitBoxUI.obf_x_x_1366;
            _loc4_ = JSONUtil.getInt(_loc2_,["moneyPrice"]);
         }
         else if(param1.buyType == ShopManager.obf_g_G_1313)
         {
            _loc3_ = SplitBoxUI.obf_Y_z_2955;
            _loc4_ = JSONUtil.getInt(_loc2_,["coinPrice"]);
         }
         else if(param1.buyType == ShopManager.obf_K_f_849)
         {
            _loc4_ = ShopManager.getItemPayCost(param1.itemCode);
         }
         var _loc5_:SplitBoxUI = new SplitBoxUI(ShopManager.sendStoreBuyItem,[param1.itemCode,param1.buyType,param1.toPlayerId],1,int(_loc2_.stackSize) || 1,_loc3_,_loc4_);
         WindowManager.showWindow(_loc5_);
      }
      
      private function onClickResult(param1:Event) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      public function showShop(param1:Array, param2:int = 1, param3:Boolean = false) : void
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:Object = null;
         var _loc14_:IconItem = null;
         var _loc15_:GoodsBoxUI = null;
         this.obf_S_z_4502();
         this.obf_Y_n_3766 = param1;
         var _loc4_:int = param1.length / this.pageSize;
         if(param1.length % this.pageSize > 0)
         {
            _loc4_++;
         }
         if(_loc4_ < 1)
         {
            _loc4_ = 1;
         }
         if(param2 * this.pageSize > param1.length)
         {
            param2 = _loc4_;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         this.obf_N_t_3283 = param2;
         param1 = param1.slice((this.obf_N_t_3283 - 1) * this.pageSize,this.obf_N_t_3283 * this.pageSize);
         DiversityManager.setTextField(txtPage,"ShopBoxUI","prompt_CurrentPage",[this.obf_N_t_3283,_loc4_],true);
         this.bags = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         for each(_loc7_ in param1)
         {
            _loc13_ = GameItemManager.getItemConfig(_loc7_);
            if(_loc13_)
            {
               _loc5_.push(_loc13_);
            }
         }
         _loc8_ = -1;
         _loc9_ = 0;
         _loc10_ = 0;
         _loc11_ = -1;
         for each(_loc12_ in _loc5_)
         {
            if(_loc12_)
            {
               if(Boolean(_loc12_.activityForBuy) && _loc12_.activityForBuy.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc12_.activityForBuy))
                  {
                     continue;
                  }
               }
               _loc11_ = int(_loc12_.subtype);
               _loc14_ = IconItemManager.getIconItemByCode(_loc12_.code,"");
               if(_loc14_)
               {
                  _loc15_ = new GoodsBoxUI(this);
                  _loc15_.addEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
                  _loc15_.iconBag.pushIconItem(_loc14_);
                  this.bags.push(_loc15_.iconBag);
                  _loc15_.setRemark(_loc12_.name);
                  if(_loc12_.goldPrice > 0)
                  {
                     _loc15_.setGold(_loc12_.goldPrice);
                  }
                  if(_loc12_.moneyPrice > 0)
                  {
                     _loc15_.setMoney(_loc12_.moneyPrice);
                  }
                  if(_loc12_.coinPrice > 0)
                  {
                     _loc15_.setCoin(_loc12_.coinPrice);
                  }
                  if(param3)
                  {
                     _loc15_.setPay(ShopManager.getItemPayCost(_loc12_.code));
                  }
                  if(++_loc8_ > 2)
                  {
                     _loc8_ = 0;
                     _loc9_ += _loc15_.height + 7;
                  }
                  _loc15_.x = (_loc15_.width + 10) * _loc8_;
                  _loc15_.y = _loc9_;
                  _loc10_ = _loc15_.y + _loc15_.height;
                  goodsContent.addChild(_loc15_);
               }
            }
         }
      }
      
      private function obf_J_d_2965(param1:ScrollEvent) : void
      {
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:GoodsBoxUI = null;
         while(goodsContent.numChildren > 0)
         {
            _loc1_ = goodsContent.getChildAt(0) as GoodsBoxUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc1_.destroy();
            }
            goodsContent.removeChildAt(0);
         }
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
         obf_0_K_4070.showWelcome("iss");
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_S_z_4502();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(Boolean(param1.haveIconItem) && param3)
         {
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,param1.haveIconItem.itemName,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
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

