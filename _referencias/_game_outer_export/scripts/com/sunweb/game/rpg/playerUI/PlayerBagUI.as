package com.sunweb.game.rpg.playerUI
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
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_9_7_2639;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.shop.obf_R_W_839;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.MainBagUIMC;
   
   public class PlayerBagUI extends MainBagUIMC implements IWindow, IIconItemUI, obf_0_d_4341
   {
      
      public var bags:Array;
      
      public var allBags:Array;
      
      public var typeBags:Array;
      
      private var pageButtons:Array;
      
      private var bagsPage:Array;
      
      private var bagsBox:Array;
      
      private var bagPageSize:int = 36;
      
      private var bagTypeCmd:Array;
      
      private var showBagType:int;
      
      private var obf_M_i_3600:int;
      
      private var showBagSubTypes:Array;
      
      private var obf_B_V_3441:Array;
      
      private var _noviceSprite:Sprite;
      
      private var frameTime:TimeLimiter;
      
      private var bagTypeTimeInv:TimeLimiter;
      
      private var bagSortTimeInv:TimeLimiter;
      
      private var obf_B_c_821:Array;
      
      public var obf_A_X_3117:Boolean;
      
      public function PlayerBagUI()
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         var _loc10_:TableButton = null;
         var _loc11_:MovieClip = null;
         var _loc12_:IconItemBag = null;
         this.bags = new Array();
         this.allBags = new Array();
         this.bagsPage = new Array();
         this.bagsBox = new Array();
         this.frameTime = new TimeLimiter(100);
         this.bagTypeTimeInv = new TimeLimiter(2000);
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         titleBox.mouseEnabled = false;
         cmdStall.visible = VersionConfig.enableBooth;
         cmdArtifact.visible = !WorldConfig.getValue("functionSwitch","artifact");
         cmdAlmirah.visible = WorldConfig.getValue("functionSwitch","showAlmirah");
         this.x = GameContext.gameStage.stageWidth / 2 + 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         cmdDecompose.enabled = !WorldConfig.getValue("functionSwitch","itemDecompose");
         cmdLettering.enabled = !WorldConfig.getValue("functionSwitch","itemLettering");
         cmdSoulWeapon.visible = !WorldConfig.getValue("functionSwitch","soulWeapon");
         cmdLOT.visible = WorldConfig.getValue("functionSwitch","showLegend");
         tempBagButtonPrompt.mouseEnabled = false;
         tempBagButtonPrompt.visible = false;
         this.pageButtons = [this.cmdBagPage1,this.cmdBagPage2,this.cmdBagPage3,this.cmdBagPage4,this.cmdBagPage5,this.cmdBagPage6,this.cmdBagPage7];
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            (this.pageButtons[_loc1_] as MovieClip).visible = false;
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ <= GameContext.bagItemManager.getPlayerBagsNum / 36)
         {
            (this.pageButtons[_loc2_ - 1] as MovieClip).visible = true;
            _loc6_ = new Array();
            (this["bagPage" + _loc2_] as MovieClip).doubleClickEnabled = true;
            this.bagsBox.push(this["bagPage" + _loc2_]);
            _loc7_ = 0;
            while(_loc7_ < this.bagPageSize)
            {
               _loc8_ = this["bagPage" + _loc2_]["bag" + _loc7_];
               if(_loc8_ != null)
               {
                  _loc9_ = new IconItemBag(_loc8_,this,(_loc2_ - 1) * this.bagPageSize + _loc7_);
                  _loc9_.isLocked = true;
                  _loc9_.addValidType(GameItemType.EQUIPMENT | GameItemType.COLLECTION | GameItemType.EXPENDABLE);
                  _loc6_.push(_loc9_);
                  this.allBags.push(_loc9_);
               }
               _loc7_++;
            }
            this.bagsPage.push(_loc6_);
            _loc2_++;
         }
         this.bagTypeCmd = new Array();
         var _loc3_:Array = WorldConfig.getValue("mainBagType") as Array;
         for each(_loc4_ in _loc3_)
         {
            _loc10_ = new TableButton();
            _loc10_.itemType = _loc4_.itemType;
            _loc10_.invType = _loc4_.invType;
            _loc10_.subType = _loc4_.subType;
            _loc10_.invSubType = _loc4_.invSubType;
            _loc10_.txtLabel.text = _loc4_.label;
            _loc10_.x = pointTypeCmd.width;
            _loc10_.width = 40;
            pointTypeCmd.addChild(_loc10_);
            this.bagTypeCmd.push(_loc10_);
         }
         this.typeBags = new Array();
         _loc5_ = 0;
         while(_loc5_ < this.bagPageSize)
         {
            _loc11_ = this.bagPageType["bag" + _loc5_];
            if(_loc11_)
            {
               _loc12_ = new IconItemBag(_loc11_,this,_loc5_);
               _loc12_.addValidType(GameItemType.ALL);
               this.typeBags.push(_loc12_);
            }
            _loc5_++;
         }
         this.setShowBagType(0);
         this.setBagsPage(1);
         this.showHotShop();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"MainBag","txtTitle");
         DiversityManager.setTextField(txtDeyShopTitle,"MainBag","txtShopTitle");
         DiversityManager.setTextField(txtDeyGold,"MainBag","txtGold");
         DiversityManager.setTextField(txtDeyMoney,"MainBag","txtMoney");
         DiversityManager.setTextField(txtDeyCoin,"MainBag","txtCoin");
         cmdArtifact.label = DiversityManager.getString("MainBag","cmdArtifact");
         cmdStrengthen.label = DiversityManager.getString("MainBag","cmdRefine");
         cmdEmbed.label = DiversityManager.getString("MainBag","cmdEmbed");
         cmdAssemble.label = DiversityManager.getString("MainBag","cmdAssemble");
         cmdDecompose.label = DiversityManager.getString("MainBag","cmdDecompose");
         cmdRenew.label = DiversityManager.getString("MainBag","cmdRenew");
         cmdSplit.label = DiversityManager.getString("MainBag","cmdSplit");
         cmdResult.label = DiversityManager.getString("ShopBoxUI","txtResult");
         cmdStall.label = DiversityManager.getString("MainBag","cmdBooth");
         cmdTempBag.label = DiversityManager.getString("MainBag","cmdTempBag");
         cmdLettering.label = DiversityManager.getString("MainBag","cmdLettering");
         cmdSort.label = DiversityManager.getString("MainBag","cmdSort");
         cmdSoulWeapon.label = DiversityManager.getString("MainBag","cmdSoulWeapon");
         cmdLOT.label = DiversityManager.getString("MainBag","cmdLOT");
         cmdAlmirah.label = DiversityManager.getString("MainBag","cmdAlmirah");
         DiversityManager.setTextField(cmdBagPage1.txtLabel,"MainBag","cmdPage1",null,true);
         DiversityManager.setTextField(cmdBagPage2.txtLabel,"MainBag","cmdPage2",null,true);
         DiversityManager.setTextField(cmdBagPage3.txtLabel,"MainBag","cmdPage3",null,true);
         DiversityManager.setTextField(cmdBagPage4.txtLabel,"MainBag","cmdPage4",null,true);
         DiversityManager.setTextField(cmdBagPage5.txtLabel,"MainBag","cmdPage5",null,true);
         DiversityManager.setTextField(cmdBagPage6.txtLabel,"MainBag","cmdPage6",null,true);
         DiversityManager.setTextField(cmdBagPage7.txtLabel,"MainBag","cmdPage7",null,true);
      }
      
      public function getAllBags() : Array
      {
         return this.allBags;
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
         return "MainBagUI";
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
         var _loc1_:MovieClip = null;
         var _loc2_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdArtifact.addEventListener(MouseEvent.CLICK,this.obf_v_X_2090);
         cmdSoulWeapon.addEventListener(MouseEvent.CLICK,this.obf_A_p_2625);
         cmdSplit.addEventListener(MouseEvent.CLICK,this.onClickSplit);
         cmdRenew.addEventListener(MouseEvent.CLICK,this.obf_e_I_1952);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdEmbed.addEventListener(MouseEvent.CLICK,this.obf_a_U_2261);
         cmdStrengthen.addEventListener(MouseEvent.CLICK,this.obf_O_D_752);
         cmdAssemble.addEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         cmdStall.addEventListener(MouseEvent.CLICK,this.obf_k_3_1803);
         cmdDecompose.addEventListener(MouseEvent.CLICK,this.obf_0_2_j_352);
         cmdLettering.addEventListener(MouseEvent.CLICK,this.onClickLettering);
         cmdTempBag.addEventListener(MouseEvent.CLICK,this.obf_J_u_3467);
         cmdSort.addEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         obf_0_9_3_562.addEventListener(ScrollEvent.SCROLL,this.obf_m_4700);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
         for each(_loc2_ in this.bagTypeCmd)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.obf_t_0_3364);
         }
         cmdLOT.addEventListener(MouseEvent.CLICK,this.obf_0_1_T_371);
         cmdAlmirah.addEventListener(MouseEvent.CLICK,this.onClickWardrobe);
         obf_K_e_3075.addUIMouseToolTip(cmdSoulWeapon,"MainBag_Soul");
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdArtifact.removeEventListener(MouseEvent.CLICK,this.obf_v_X_2090);
         cmdSoulWeapon.removeEventListener(MouseEvent.CLICK,this.obf_A_p_2625);
         cmdSplit.removeEventListener(MouseEvent.CLICK,this.onClickSplit);
         cmdRenew.removeEventListener(MouseEvent.CLICK,this.obf_e_I_1952);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdEmbed.removeEventListener(MouseEvent.CLICK,this.obf_a_U_2261);
         cmdStrengthen.removeEventListener(MouseEvent.CLICK,this.obf_O_D_752);
         cmdAssemble.removeEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         cmdStall.removeEventListener(MouseEvent.CLICK,this.obf_k_3_1803);
         cmdDecompose.removeEventListener(MouseEvent.CLICK,this.obf_0_2_j_352);
         cmdLettering.removeEventListener(MouseEvent.CLICK,this.onClickLettering);
         cmdTempBag.removeEventListener(MouseEvent.CLICK,this.obf_J_u_3467);
         cmdSort.removeEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         obf_0_9_3_562.removeEventListener(ScrollEvent.SCROLL,this.obf_m_4700);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
         for each(_loc2_ in this.bagTypeCmd)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.obf_t_0_3364);
         }
         cmdLOT.removeEventListener(MouseEvent.CLICK,this.obf_0_1_T_371);
         cmdAlmirah.addEventListener(MouseEvent.CLICK,this.onClickWardrobe);
         obf_K_e_3075.removeUIMouseToolTip(cmdSoulWeapon);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(Boolean(this.bagSortTimeInv) && this.bagSortTimeInv.checkTimeout())
         {
            cmdSort.enabled = true;
            this.bagSortTimeInv = null;
         }
         if(IconItemManager.draging)
         {
            _loc2_ = 0;
            while(_loc2_ < this.pageButtons.length)
            {
               _loc3_ = this.pageButtons[_loc2_];
               if(Boolean(_loc3_) && _loc3_.getBounds(_loc3_).contains(_loc3_.mouseX,_loc3_.mouseY))
               {
                  this.setBagsPage(_loc2_ + 1);
                  break;
               }
               _loc2_++;
            }
         }
         if(this.obf_A_X_3117 && this.showBagType > 0 && this.bagTypeTimeInv.checkTimeout())
         {
            this.setShowBagType(this.showBagType,this.obf_M_i_3600,this.showBagSubTypes,this.obf_B_V_3441);
            this.obf_A_X_3117 = false;
         }
      }
      
      private function showHotShop() : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:IconItem = null;
         var _loc6_:obf_R_W_839 = null;
         this.obf_T_3066();
         this.obf_B_c_821 = new Array();
         pointShop.scrollRect = new Rectangle(0,0,obf_0_9_3_562.x - pointShop.x,obf_0_9_3_562.height);
         obf_0_9_3_562.pageSize = obf_0_9_3_562.height;
         var _loc1_:Array = ShopManager.getStoreHotItemList();
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = GameItemManager.getItemConfig(_loc3_);
            if(_loc4_)
            {
               if(Boolean(_loc4_.activityForBuy) && _loc4_.activityForBuy.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc4_.activityForBuy))
                  {
                     continue;
                  }
               }
               _loc5_ = IconItemManager.getIconItemByCode(_loc3_,"");
               if(_loc5_)
               {
                  _loc6_ = new obf_R_W_839(this);
                  _loc6_.addEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
                  _loc6_.iconItemBag.pushIconItem(_loc5_);
                  this.obf_B_c_821.push(_loc6_.iconItemBag);
                  if(_loc4_.moneyPrice > 0)
                  {
                     _loc6_.setMoney(_loc4_.moneyPrice);
                  }
                  _loc6_.y = _loc2_ + 2;
                  _loc2_ += _loc6_.height;
                  pointShop.addChild(_loc6_);
               }
            }
         }
         if(_loc2_ > obf_0_9_3_562.height)
         {
            obf_0_9_3_562.maxScrollPosition = _loc2_ - obf_0_9_3_562.height;
            obf_0_9_3_562.visible = true;
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
         var _loc5_:SplitBoxUI = new SplitBoxUI(ShopManager.sendStoreBuyItem,[param1.itemCode,param1.buyType,param1.toPlayerId],1,int(_loc2_.stackSize) || 1,_loc3_,_loc4_);
         WindowManager.showWindow(_loc5_);
      }
      
      private function obf_T_3066() : void
      {
         var iconBag:IconItemBag = null;
         for each(iconBag in this.obf_B_c_821)
         {
            if(iconBag)
            {
               if(iconBag.parent == pointShop)
               {
                  pointShop.removeChild(iconBag);
               }
               try
               {
                  iconBag.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               }
               catch(e:Error)
               {
               }
               iconBag.destroy();
            }
         }
      }
      
      public function obf_S_L_1164() : void
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
         var _loc1_:Array = obf_a_f_2935.getGoldRank(GameContext.localPlayer.fullInfo.gold);
         txtDiamond.text = _loc1_[0] + "";
         txtGold.text = _loc1_[1] + "";
         txtSilver.text = _loc1_[2] + "";
         txtCopper.text = _loc1_[3] + "";
         if(obf_K_e_3075.boothBfmUI)
         {
            obf_K_e_3075.boothBfmUI.obf_0_7_Q_154();
         }
         if(obf_K_e_3075.depictBoxUI)
         {
            obf_K_e_3075.depictBoxUI.obf_0_7_Q_154();
         }
         if(obf_K_e_3075.obf_b_M_1918)
         {
            obf_K_e_3075.obf_b_M_1918.setMoney();
         }
         if(obf_K_e_3075.taxisBoxUI)
         {
            obf_K_e_3075.taxisBoxUI.setMoney();
         }
      }
      
      public function setShowBagType(param1:int, param2:int = 0, param3:Array = null, param4:Array = null) : void
      {
         var _loc5_:TableButton = null;
         var _loc6_:IconItemBag = null;
         var _loc8_:IconItemBag = null;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:IconItemBag = null;
         var _loc12_:IconItemBag = null;
         var _loc13_:IconItem = null;
         this.showBagType = param1;
         this.obf_M_i_3600 = param2;
         this.showBagSubTypes = param3;
         this.obf_B_V_3441 = param4;
         for each(_loc5_ in this.bagTypeCmd)
         {
            _loc5_.gotoAndStop(_loc5_.itemType == this.showBagType ? 2 : 1);
         }
         for each(_loc6_ in this.typeBags)
         {
            _loc6_.dropIconItem();
         }
         if(param1 == 0)
         {
            if(this.contains(bagPageType))
            {
               this.removeChild(bagPageType);
            }
            return;
         }
         var _loc7_:Array = new Array();
         for each(_loc8_ in this.allBags)
         {
            if(!(!_loc8_ || !_loc8_.haveIconItem))
            {
               _loc10_ = GameItemManager.getItemConfig(_loc8_.haveIconItem.itemCode);
               if(_loc10_)
               {
                  if(GameItemType.contrastType(_loc10_.type,this.showBagType))
                  {
                     if(!GameItemType.contrastType(_loc10_.type,this.obf_M_i_3600))
                     {
                        if(!(Boolean(this.showBagSubTypes) && Boolean(this.showBagSubTypes.length > 0) && this.showBagSubTypes.indexOf(_loc10_.subtype) <= -1))
                        {
                           if(!(Boolean(this.obf_B_V_3441) && Boolean(this.obf_B_V_3441.length > 0) && this.obf_B_V_3441.indexOf(_loc10_.subtype) > -1))
                           {
                              _loc7_.push(_loc8_);
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc9_ = 0;
         while(_loc9_ < this.typeBags.length && _loc9_ < _loc7_.length)
         {
            _loc11_ = this.typeBags[_loc9_];
            _loc12_ = _loc7_[_loc9_];
            _loc13_ = _loc12_.haveIconItem.clone();
            _loc11_.itemIndex = _loc12_.itemIndex;
            _loc13_.itemCount = _loc12_.haveIconItem.itemCount;
            _loc11_.pushIconItem(_loc13_);
            _loc9_++;
         }
         this.addChild(bagPageType);
      }
      
      public function setBagsPage(param1:int) : void
      {
         var i:int;
         var bagBox:MovieClip = null;
         var page:int = param1;
         this.setShowBagType(0);
         page = Math.max(1,Math.min(this.pageButtons.length,page));
         i = 0;
         while(i < this.pageButtons.length)
         {
            (this.pageButtons[i] as MovieClip).gotoAndStop(i + 1 == page ? 2 : 1);
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
         this.bags = this.bagsPage[page - 1];
         if(Boolean(this._noviceSprite) && this.contains(this._noviceSprite))
         {
            this.setChildIndex(this._noviceSprite,this.numChildren - 1);
         }
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         this.setBagsPage(this.pageButtons.indexOf(param1.currentTarget) + 1);
      }
      
      private function obf_t_0_3364(param1:Event) : void
      {
         this.setShowBagType(param1.currentTarget.itemType,JSONUtil.getInt(param1.currentTarget,["invType"]),JSONUtil.getObject(param1.currentTarget,["subType"]) as Array,JSONUtil.getObject(param1.currentTarget,["invSubType"]) as Array);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onDrag(param1:Event) : void
      {
         if(param1.currentTarget == bgBox)
         {
            this.startDrag();
            IconItemManager.mouseDown = false;
         }
      }
      
      private function onMouseUp(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_v_X_2090(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.artifactBoxUI);
      }
      
      private function obf_A_p_2625(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.soulWeaponBoxUI);
      }
      
      private function onClickSplit(param1:Event) : void
      {
         if(obf_K_e_3075.obf_c_D_2721 != obf_K_e_3075.obf_o_7_2612)
         {
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_o_7_2612;
         }
         else if(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_o_7_2612)
         {
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
         }
      }
      
      private function obf_e_I_1952(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_8_r_4095);
      }
      
      private function onClickResult(param1:Event) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      private function obf_a_U_2261(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_5_i_2480);
      }
      
      private function obf_O_D_752(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.refineBoxUI);
      }
      
      private function obf_W_j_2205(param1:Event) : void
      {
         obf_K_e_3075.assembleBoxUI.show("","",null,WorldConfig.getObjectSetting("bagAssembleTypeList") as Array);
      }
      
      private function obf_k_3_1803(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.boothUI);
      }
      
      private function obf_0_2_j_352(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_4_S_4444);
      }
      
      private function onClickLettering(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.equipmentLetteringUI);
      }
      
      private function obf_J_u_3467(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.tempBagUI);
      }
      
      private function obf_0_1_T_371(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.legendUI);
      }
      
      private function onClickWardrobe(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_0___Z_558);
      }
      
      private function obf_a_z_1623(param1:Event) : void
      {
         GameContext.bagItemManager.sendSortBag(PlayerBagIndex.PLAYER_MAIN_BAG);
         cmdSort.enabled = false;
         this.bagSortTimeInv = new TimeLimiter(WorldConfig.obf_K_L_4278);
      }
      
      private function obf_m_4700(param1:Event) : void
      {
         pointShop.scrollRect = new Rectangle(0,obf_0_9_3_562.scrollPosition,obf_0_9_3_562.x - pointShop.x,obf_0_9_3_562.height);
      }
      
      public function get mouseOn() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.visible)
         {
            _loc1_ = bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
            if(!_loc1_)
            {
               return obf_t_O_1071.getBounds(obf_t_O_1071).contains(obf_t_O_1071.mouseX,obf_t_O_1071.mouseY);
            }
            return true;
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_9_7_2639.obf_L_s_2876(this);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         obf_q_6_3634.obf_e_J_1876("openUI@fs9",1);
      }
      
      public function closeUI() : void
      {
         if(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_m_J_4374 || obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_o_7_2612 || obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_J_o_4558)
         {
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
         }
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         obf_q_6_3634.obf_e_J_1876("openUI@fs9",1);
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:IconItemBag = null;
         for each(_loc1_ in this.allBags)
         {
            _loc1_.destroy();
            if(this.contains(_loc1_))
            {
               this.removeChild(_loc1_);
            }
         }
         for each(_loc2_ in this.typeBags)
         {
            _loc2_.destroy();
         }
         this.removeListener();
         this.obf_T_3066();
         this.obf_B_c_821 = null;
         this.bags = null;
         this.allBags = null;
      }
      
      public function getIconItemBags() : Array
      {
         if(this.showBagType > 0)
         {
            return this.typeBags.concat(this.obf_B_c_821);
         }
         return this.bags.concat(this.obf_B_c_821);
      }
      
      public function getIconItemBag(param1:int) : IconItemBag
      {
         if(param1 < 0 || param1 >= this.allBags.length)
         {
            return null;
         }
         return this.allBags[param1];
      }
      
      public function useItemByCode(param1:String, param2:* = null) : Boolean
      {
         var _loc3_:IconItemBag = this.getIconItemBagByCode(param1);
         if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
         {
            return _loc3_.haveIconItem.useIcon(param2);
         }
         return false;
      }
      
      public function useItemById(param1:String, param2:* = null) : Boolean
      {
         var _loc3_:IconItemBag = this.getIconItemBagByID(param1);
         if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
         {
            return _loc3_.haveIconItem.useIcon(param2);
         }
         return false;
      }
      
      public function useItemByName(param1:String, param2:* = null) : Boolean
      {
         var _loc3_:IconItemBag = this.getIconItemBagByItemName(param1);
         if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
         {
            return _loc3_.haveIconItem.useIcon(param2);
         }
         return false;
      }
      
      public function getIconItemBagByCode(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.allBags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getIconItemBagByID(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.allBags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getIconItemBagByItemName(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.allBags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getItemCount(param1:String) : int
      {
         var _loc5_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:Array = this.allBags.concat();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            if(Boolean(_loc5_.haveIconItem) && _loc5_.haveIconItem.itemCode == param1)
            {
               _loc2_ += _loc5_.haveIconItem.itemCount;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get equipBags() : Array
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.allBags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemType == GameItemType.EQUIPMENT)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getEqualItemCount(param1:String) : int
      {
         var _loc6_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:Array = this.allBags.concat(obf_K_e_3075.rideBoxUI.rideBags);
         if(!GameItemManager.getItemConfig(param1))
         {
            obf_x_0_1295.obf_r_w_3556("config item " + param1 + " is null!");
         }
         var _loc4_:String = JSONUtil.getStr(GameItemManager.getItemConfig(param1),["equalItem"]);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(Boolean(_loc6_.haveIconItem) && (_loc6_.haveIconItem.itemCode == param1 || _loc6_.haveIconItem.itemCode == _loc4_))
            {
               _loc2_ += _loc6_.haveIconItem.itemCount;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.allBags)
         {
            if(!_loc3_.isLocked)
            {
               if(_loc3_.haveIconItem == null)
               {
                  if(++_loc2_ >= param1)
                  {
                     return true;
                  }
               }
            }
         }
         return _loc2_ >= param1;
      }
      
      public function hasAnyItem(param1:Array) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.allBags.length)
         {
            _loc3_ = this.allBags[_loc2_];
            if(Boolean(_loc3_.haveIconItem) && param1.indexOf(_loc3_.haveIconItem.itemCode) > -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:SplitBoxUI = null;
         var _loc5_:Object = null;
         if(!param1 || !param1.haveIconItem)
         {
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
            return;
         }
         if(param3)
         {
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,param1.haveIconItem.itemName,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
         if(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_s_r_1801 && param2 || obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_o_7_2612 && param1.haveIconItem.itemCount > 1)
         {
            _loc4_ = new SplitBoxUI(IconItemManager.startDrag,[param1],1,param1.haveIconItem.itemCount);
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
            WindowManager.showWindow(_loc4_);
         }
         if(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_m_J_4374 && Boolean(param1.haveIconItem))
         {
            _loc5_ = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
            if(_loc5_)
            {
               if(!_loc5_.canRecycle)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","cantSell"));
               }
               else if(param1.haveIconItem.iconItemRank == GameItemRank.NOMAL)
               {
                  ShopManager.sendSellItem(PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,obf_K_e_3075.npcShopUI.npcId,obf_K_e_3075.npcShopUI.fullMenuIndex);
               }
               else
               {
                  WindowManager.showConfirmBox(DiversityManager.getString("ItemPrompt","confirmSell"),this.confirmSell,[PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,obf_K_e_3075.npcShopUI.npcId,obf_K_e_3075.npcShopUI.fullMenuIndex]);
               }
            }
         }
         if(Boolean(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_2_N_1475) && Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT)
         {
            obf_K_e_3075.equipRepairUI.showEquipRepair(param1.haveIconItem.itemCode,param1.haveIconItem.itemId);
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
         }
      }
      
      private function confirmSell(param1:Object) : void
      {
         if(param1.confirm)
         {
            ShopManager.sendSellItem.apply(null,param1.par);
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(obf_K_e_3075.playerBoxUI.visible && obf_K_e_3075.obf_J_K_2135.visible && GameItemType.contrastType(GameItemType.EQUIPMENT,param1.haveIconItem.itemType))
         {
            obf_K_e_3075.obf_J_K_2135.useIcon(param1.haveIconItem,param1);
            return;
         }
         if(Boolean(param1.haveIconItem) && !param1.isLocked)
         {
            param1.useIconItem();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || param1 == param3)
         {
            return;
         }
         if(Boolean(this.typeBags) && this.typeBags.indexOf(param1) > -1)
         {
            return;
         }
         if(Boolean(this.obf_B_c_821) && this.obf_B_c_821.indexOf(param1) > -1)
         {
            return;
         }
         if(param1.isLocked || !param3.haveIconItem)
         {
            return;
         }
         if(param3.parentIconUI == this)
         {
            if(GameContext.bagItemManager != null)
            {
               if(param2.itemCount < param3.haveIconItem.itemCount)
               {
                  GameContext.bagItemManager.sendSplitItem(PlayerBagIndex.PLAYER_MAIN_BAG,param3.itemIndex,param1.itemIndex,param2.itemCount);
               }
               else
               {
                  GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.PLAYER_MAIN_BAG);
               }
            }
         }
         else if(param3.parentIconUI == obf_K_e_3075.depotBagUI)
         {
            GameContext.bagItemManager.sendItemMoveCrossBag(PlayerBagIndex.PLAYER_DEPOT,param3.itemIndex,PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,obf_K_e_3075.depotBagUI.npcId,obf_K_e_3075.depotBagUI.npcMenuIndex);
         }
         else if(param3.parentIconUI == obf_K_e_3075.depotTwoBagUI)
         {
            GameContext.bagItemManager.sendItemMoveCrossBag(PlayerBagIndex.obf_6_c_1642,param3.itemIndex,PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,obf_K_e_3075.depotTwoBagUI.npcId,obf_K_e_3075.depotTwoBagUI.npcMenuIndex);
         }
         else
         {
            if(param3.parentIconUI != obf_K_e_3075.depotThreeBagUI)
            {
               param2.destroy();
               return;
            }
            GameContext.bagItemManager.sendItemMoveCrossBag(PlayerBagIndex.obf_G_r_1422,param3.itemIndex,PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,obf_K_e_3075.depotThreeBagUI.npcId,obf_K_e_3075.depotThreeBagUI.npcMenuIndex);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         var _loc4_:Object = null;
         if(param3 == null && Boolean(param1.haveIconItem))
         {
            _loc4_ = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
            if(_loc4_.dropMode == 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","cantDrop"));
            }
            else if(_loc4_.dropMode == 1)
            {
               GameContext.bagItemManager.sendDropItem(PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY));
            }
            else if(_loc4_.dropMode == 2)
            {
               WindowManager.showConfirmBox(DiversityManager.getString("ItemPrompt","confirmDrop"),this.confirmDragItem,[PlayerBagIndex.PLAYER_MAIN_BAG,param1.itemIndex,new MapPoint(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)]);
            }
         }
      }
      
      public function confirmDragItem(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendDropItem.apply(null,param1.par);
         }
      }
   }
}

