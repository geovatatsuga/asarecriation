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
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.LeadItemList;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import playerUI.NewShopBoxMC;
   import playerUI.ShopTabButton;
   import playerUI.ShopTabButtonL;
   import playerUI.ShopTabButtonR;
   
   public class NewShopBoxUI extends NewShopBoxMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var obf_E_l_1739:Array;
      
      private var obf_N_t_3283:int;
      
      private var pageSize:int = 12;
      
      private var obf_r_l_2445:String;
      
      private var obf_Y_n_3766:Array;
      
      private var obf_0_8_649:Array;
      
      private var obf_L_J_3119:int = 0;
      
      private var obf_O_g_4193:TimeLimiter;
      
      private var obf_j_B_1080:int;
      
      private var resLoaded:Boolean;
      
      private var _noviceSprite:Sprite;
      
      public function NewShopBoxUI()
      {
         var _loc5_:MovieClip = null;
         this.bags = new Array();
         this.obf_E_l_1739 = new Array();
         this.obf_0_8_649 = [];
         this.obf_O_g_4193 = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 - 130;
         this.y = GameContext.gameStage.stageHeight / 2 - 70;
         this.visible = false;
         var _loc1_:Array = ShopManager.getStoreKinds();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc2_ == 0)
            {
               _loc5_ = new ShopTabButtonL();
            }
            else
            {
               _loc5_ = new ShopTabButton();
            }
            _loc5_.name = _loc1_[_loc2_];
            _loc5_.txtLabel.text = _loc1_[_loc2_];
            _loc5_.x = tableBox.width;
            _loc5_.scaleX = 1.12;
            _loc5_.gotoAndStop(1);
            tableBox.addChild(_loc5_);
            this.obf_E_l_1739.push(_loc5_);
            _loc2_++;
         }
         var _loc3_:ShopTabButton = new ShopTabButton();
         _loc3_.name = ShopManager.obf_R_c_3073;
         DiversityManager.setTextField(_loc3_.txtLabel,"ShopBoxUI","payType",null,true);
         _loc3_.x = tableBox.width;
         _loc3_.scaleX = 1.12;
         _loc3_.gotoAndStop(1);
         tableBox.addChild(_loc3_);
         this.obf_E_l_1739.push(_loc3_);
         var _loc4_:ShopTabButtonR = new ShopTabButtonR();
         _loc4_.name = ShopManager.obf_a_s_2956;
         DiversityManager.setTextField(_loc4_.txtLabel,"ShopBoxUI","costpayType",null,true);
         _loc4_.x = tableBox.width;
         _loc4_.txtLabel.height = 39;
         _loc4_.txtLabel.y = 3;
         _loc4_.gotoAndStop(1);
         tableBox.addChild(_loc4_);
         this.obf_E_l_1739.push(_loc4_);
         this.obf_d_6_3571();
         this.addListener();
         if(Boolean(this.obf_E_l_1739) && this.obf_E_l_1739.length > 0)
         {
            this.obf_E_l_1739[0].gotoAndStop(2);
         }
         this.showShop(ShopManager.getStoreItemListByKind(_loc1_[0]));
         obf_H_w_3575.pageSize = obf_H_w_3575.height;
      }
      
      public function get selectedType() : String
      {
         return this.obf_r_l_2445;
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_0_3_2_688);
         }
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         GameContext.gameStage.addEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_0_3_2_688);
         }
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         GameContext.gameStage.removeEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
      }
      
      private function obf_3_S_1490(param1:ScrollEvent) : void
      {
         itemPoint.scrollRect = new Rectangle(0,param1.position,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height - 5);
      }
      
      private function resetTabelButton() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.obf_E_l_1739)
         {
            _loc1_.gotoAndStop(1);
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
         var _loc1_:String = null;
         var _loc2_:Object = null;
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
         else if(this.obf_r_l_2445 == ShopManager.obf_a_s_2956)
         {
            DiversityManager.setTextField(txtDeyPay,"ShopBoxUI","txtCostPay",null,true);
            txtPay.text = this.getCostPointValue() + "";
            _loc1_ = WorldConfig.getValue("consPointShop","activityCode");
            _loc2_ = obf_J_F_3431.getActConfig(_loc1_);
            if(_loc2_)
            {
               txtPayDatePrompt.text = JSONUtil.getStr(_loc2_,["dateLimit"]);
            }
         }
      }
      
      private function obf_0_3_2_688(param1:MouseEvent) : void
      {
         this.obf_r_l_2445 = param1.currentTarget.name;
         this.resetTabelButton();
         param1.currentTarget.gotoAndStop(2);
         this.showShop(ShopManager.getStoreItemListByKind(param1.currentTarget.name),1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073,this.obf_r_l_2445 == ShopManager.obf_a_s_2956);
         this.obf_d_6_3571();
      }
      
      private function obf_k_X_2379(param1:MouseEvent) : void
      {
         if(param1.currentTarget == cmdPrvPage)
         {
            this.showShop(this.obf_Y_n_3766,this.obf_N_t_3283 - 1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073,this.obf_r_l_2445 == ShopManager.obf_a_s_2956);
         }
         else if(param1.currentTarget == cmdNextPage)
         {
            this.showShop(this.obf_Y_n_3766,this.obf_N_t_3283 + 1,this.obf_r_l_2445 == ShopManager.obf_R_c_3073,this.obf_r_l_2445 == ShopManager.obf_a_s_2956);
         }
      }
      
      private function onClickResult(param1:MouseEvent) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      public function showShop(param1:Array, param2:int = 1, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc15_:IconItem = null;
         var _loc16_:NewGoodsBoxUI = null;
         var _loc17_:String = null;
         this.obf_S_z_4502();
         this.obf_Y_n_3766 = param1;
         var _loc5_:int = param1.length / this.pageSize;
         if(param1.length % this.pageSize > 0)
         {
            _loc5_++;
         }
         if(_loc5_ < 1)
         {
            _loc5_ = 1;
         }
         if(param2 * this.pageSize > param1.length)
         {
            param2 = _loc5_;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         this.obf_N_t_3283 = param2;
         param1 = param1.slice((this.obf_N_t_3283 - 1) * this.pageSize,this.obf_N_t_3283 * this.pageSize);
         DiversityManager.setTextField(txtPage,"ShopBoxUI","prompt_CurrentPage",[this.obf_N_t_3283,_loc5_],true);
         this.bags = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         for each(_loc8_ in param1)
         {
            _loc14_ = GameItemManager.getItemConfig(_loc8_);
            if(_loc14_)
            {
               _loc6_.push(_loc14_);
            }
         }
         _loc9_ = -1;
         _loc10_ = 0;
         _loc11_ = 0;
         _loc12_ = -1;
         for each(_loc13_ in _loc6_)
         {
            if(_loc13_)
            {
               if(Boolean(_loc13_.activityForBuy) && _loc13_.activityForBuy.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc13_.activityForBuy))
                  {
                     continue;
                  }
               }
               _loc12_ = int(_loc13_.subtype);
               _loc15_ = IconItemManager.getIconItemByCode(_loc13_.code,"");
               if(_loc15_)
               {
                  _loc16_ = new NewGoodsBoxUI(this);
                  _loc16_.addEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
                  _loc16_.iconBag.pushIconItem(_loc15_);
                  this.bags.push(_loc16_.iconBag);
                  _loc17_ = GameItemRank.getRankColor(_loc13_.rank).toString(16);
                  _loc16_.setRemark("<FONT color=\'#" + _loc17_ + "\'>" + _loc13_.name + "</FONT>");
                  if(_loc13_.moneyPrice > 0)
                  {
                     _loc16_.setMoney(_loc13_.moneyPrice);
                  }
                  if(_loc13_.goldPrice > 0)
                  {
                     _loc16_.setGold(_loc13_.goldPrice);
                  }
                  if(_loc13_.coinPrice > 0)
                  {
                     _loc16_.setCoin(_loc13_.coinPrice);
                  }
                  if(param3)
                  {
                     _loc16_.setPay(ShopManager.getItemPayCost(_loc13_.code));
                  }
                  if(param4)
                  {
                     _loc16_.setCostPay(ShopManager.getItemCostPayPrice(_loc13_.code));
                  }
                  if(++_loc9_ > 2)
                  {
                     _loc9_ = 0;
                     _loc10_ += _loc16_.height + 7;
                  }
                  _loc16_.x = (_loc16_.width + 15) * _loc9_;
                  _loc16_.y = _loc10_;
                  _loc11_ = _loc16_.y + _loc16_.height;
                  goodsContent.addChild(_loc16_);
               }
            }
         }
      }
      
      public function showLeadShop(param1:Array, param2:int) : void
      {
         var _loc4_:LeadItemList = null;
         var _loc5_:Object = null;
         var _loc6_:IconItem = null;
         var _loc7_:obf_t_u_3691 = null;
         var _loc8_:String = null;
         this.obf_S_u_3322();
         var _loc3_:int = 0;
         this.obf_0_8_649 = new Array();
         itemPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height - 5);
         for each(_loc4_ in param1)
         {
            _loc5_ = GameItemManager.getItemConfig(_loc4_.itemCode);
            if(_loc5_)
            {
               if(Boolean(_loc5_.activityForBuy) && _loc5_.activityForBuy.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc5_.activityForBuy))
                  {
                     continue;
                  }
               }
               _loc6_ = IconItemManager.getIconItemByCode(_loc5_.code,"");
               if(_loc6_)
               {
                  _loc7_ = new obf_t_u_3691(this);
                  _loc7_.addEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
                  _loc7_.iconBag.pushIconItem(_loc6_);
                  this.obf_0_8_649.push(_loc7_.iconBag);
                  _loc8_ = GameItemRank.getRankColor(_loc5_.rank).toString(16);
                  _loc7_.setName("<FONT color=\'#" + _loc8_ + "\'>" + _loc5_.name + "</FONT>");
                  if(_loc4_.itemPrice > 0)
                  {
                     _loc7_.setPrice(0,JSONUtil.getInt(_loc5_,["moneyPrice"]),_loc4_.itemPrice);
                  }
                  else if(_loc4_.itemWorth > 0)
                  {
                     _loc7_.setPrice(1,JSONUtil.getInt(_loc5_,["goldPrice"]),_loc4_.itemWorth);
                  }
                  else
                  {
                     if(_loc4_.itemGift <= 0)
                     {
                        continue;
                     }
                     _loc7_.setPrice(2,JSONUtil.getInt(_loc5_,["coinPrice"]),_loc4_.itemGift);
                  }
                  _loc7_.setItemCount(_loc4_.itemCount);
                  _loc7_.y = _loc3_;
                  itemPoint.addChild(_loc7_);
                  _loc3_ += _loc7_.height + 10;
               }
            }
         }
         if(_loc3_ <= obf_H_w_3575.height)
         {
            obf_H_w_3575.visible = false;
         }
         else
         {
            obf_H_w_3575.visible = true;
            obf_H_w_3575.maxScrollPosition = _loc3_ - obf_H_w_3575.height;
         }
         this.setNextRefreshTimes(param2);
      }
      
      private function obf_0_2_B_370(param1:Event) : void
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
            leavingsTime.htmlText = obf_l_y_733.getTimeStringHHMMSS(_loc2_);
            if(_loc2_ >= 3600 * 1000)
            {
               leavingsTime.textColor = 65280;
            }
            else if(_loc2_ >= 20 * 60 * 1000)
            {
               leavingsTime.textColor = 14709529;
            }
            else
            {
               leavingsTime.textColor = 16711680;
            }
         }
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
      
      private function onBuyItem(param1:ShopBuyEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:SplitBoxUI = null;
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
            if(param1.itemType == 1)
            {
               _loc4_ = param1.leadPrice;
            }
            else
            {
               _loc4_ = JSONUtil.getInt(_loc2_,["goldPrice"]);
            }
         }
         else if(param1.buyType == ShopManager.obf_B_9_2165)
         {
            _loc3_ = SplitBoxUI.obf_x_x_1366;
            if(param1.itemType == 1)
            {
               _loc4_ = param1.leadPrice;
            }
            else
            {
               _loc4_ = JSONUtil.getInt(_loc2_,["moneyPrice"]);
            }
         }
         else if(param1.buyType == ShopManager.obf_g_G_1313)
         {
            _loc3_ = SplitBoxUI.obf_Y_z_2955;
            if(param1.itemType == 1)
            {
               _loc4_ = param1.leadPrice;
            }
            else
            {
               _loc4_ = JSONUtil.getInt(_loc2_,["coinPrice"]);
            }
         }
         else if(param1.buyType == ShopManager.obf_K_f_849)
         {
            _loc4_ = ShopManager.getItemPayCost(param1.itemCode);
         }
         else if(param1.buyType == ShopManager.obf_t_m_4319)
         {
            _loc4_ = ShopManager.getItemCostPayPrice(param1.itemCode);
         }
         if(param1.itemType == 1)
         {
            _loc5_ = new SplitBoxUI(ShopManager.sendStoreLeadBuyItem,[param1.itemCode,param1.buyType,param1.toPlayerId],1,param1.itemCount || 1,_loc3_,_loc4_);
         }
         else if(this.obf_r_l_2445 == ShopManager.obf_a_s_2956)
         {
            _loc5_ = new SplitBoxUI(ShopManager.sendCostPointBuyItem,[param1.itemCode,_loc4_],1,int(_loc2_.stackSize) || 1,"",_loc4_);
         }
         else
         {
            _loc5_ = new SplitBoxUI(ShopManager.sendStoreBuyItem,[param1.itemCode,param1.buyType,param1.toPlayerId],1,int(_loc2_.stackSize) || 1,_loc3_,_loc4_);
         }
         WindowManager.showWindow(_loc5_);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getCostPointValue() : int
      {
         var _loc1_:String = WorldConfig.getValue("consPointShop","consVar");
         return GameContext.localPlayer.dynamicVars.getIntVar(_loc1_);
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:NewGoodsBoxUI = null;
         while(goodsContent.numChildren > 0)
         {
            _loc1_ = goodsContent.getChildAt(0) as NewGoodsBoxUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc1_.destroy();
            }
            goodsContent.removeChildAt(0);
         }
      }
      
      private function obf_S_u_3322() : void
      {
         var _loc1_:obf_t_u_3691 = null;
         while(itemPoint.numChildren > 0)
         {
            _loc1_ = itemPoint.getChildAt(0) as obf_t_u_3691;
            if(_loc1_)
            {
               _loc1_.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc1_.destroy();
            }
            itemPoint.removeChildAt(0);
         }
         obf_H_w_3575.maxScrollPosition = 0;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags.concat(this.obf_0_8_649);
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
         DiversityManager.setTextField(txtUpPage,"ShopBoxUI","cmdPrvPage");
         DiversityManager.setTextField(txtDownPage,"ShopBoxUI","cmdNextPage");
         DiversityManager.setTextField(txtConfiscate,"ShopBoxUI","txtResult");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_0_K_4070.showWelcome("iss");
         if(!this.resLoaded)
         {
            ShopManager.sendLeadItemInfo();
         }
         this.resLoaded = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_S_z_4502();
         this.obf_S_u_3322();
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
   }
}

