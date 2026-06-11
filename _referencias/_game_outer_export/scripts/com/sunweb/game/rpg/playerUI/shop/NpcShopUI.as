package com.sunweb.game.rpg.playerUI.shop
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.NpcShopUIMC;
   
   public class NpcShopUI extends NpcShopUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array = new Array();
      
      private var _npcId:String;
      
      private var _menuIndex:Array;
      
      private var obf_m_T_4529:TableButton;
      
      private var obf_n_K_2599:String;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      public function NpcShopUI()
      {
         super();
         this.initDiversity();
         this.x = this.width / 2 + 30;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtDeyTitle.mouseEnabled = false;
         txtDeyTitle.text = DiversityManager.getString("NpcShopUI","txtTitle");
         cmdSell.label = DiversityManager.getString("NpcShopUI","cmdSell");
         cmdRepair.label = DiversityManager.getString("NpcShopUI","cmdRepair");
         cmdRepairAll.label = DiversityManager.getString("NpcShopUI","cmdRepairAll");
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
         return "NpcShopUI";
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
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSell.addEventListener(MouseEvent.CLICK,this.onClickSell);
         cmdRepair.addEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
         cmdRepairAll.addEventListener(MouseEvent.CLICK,this.obf_Q_3790);
         scrollItem.addEventListener(ScrollEvent.SCROLL,this.onScrollItem);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSell.removeEventListener(MouseEvent.CLICK,this.onClickSell);
         cmdRepair.removeEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
         cmdRepairAll.removeEventListener(MouseEvent.CLICK,this.obf_Q_3790);
         scrollItem.removeEventListener(ScrollEvent.SCROLL,this.onScrollItem);
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
      
      public function get npcId() : String
      {
         return this._npcId;
      }
      
      public function get fullMenuIndex() : Array
      {
         return this._menuIndex;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.visible || !this.timeInv.checkTimeout())
         {
            return;
         }
         if(!obf_b_p_3604.checkNpcDistance(this._npcId,false))
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function onScrollItem(param1:ScrollEvent) : void
      {
         pointItem.scrollRect = new Rectangle(0,param1.position,scrollItem.x - pointItem.x,scrollItem.height);
      }
      
      private function onClickSell(param1:Event) : void
      {
         obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_m_J_4374;
      }
      
      private function obf_Y_S_3731(param1:Event) : void
      {
         obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_2_N_1475;
      }
      
      private function obf_Q_3790(param1:Event) : void
      {
         obf_K_e_3075.equipRepairUI.showEquipRepair("","");
      }
      
      public function showNpcShop(param1:String, param2:Array, param3:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:TableButton = null;
         if(!param2 || param2.length <= 0)
         {
            return;
         }
         this._npcId = param1;
         this._menuIndex = param3;
         while(pointPage.numChildren > 0)
         {
            pointPage.removeChildAt(0);
         }
         for each(_loc4_ in param2)
         {
            _loc5_ = new TableButton();
            _loc5_.name = _loc4_;
            _loc5_.width = 60;
            _loc5_.txtLabel.text = JSONUtil.getStr(ShopManager.getShopConfigByKind(_loc4_),["label"]);
            _loc5_.x = pointPage.width;
            _loc5_.gotoAndStop(1);
            pointPage.addChild(_loc5_);
            _loc5_.addEventListener(MouseEvent.CLICK,this.obf_u_y_2763);
         }
         if(param2.length > 0)
         {
            this.showGoods(param2[0]);
         }
         this.x = this.width / 2 + 30;
         this.y = GameContext.gameStage.stageHeight / 2;
         obf_K_e_3075.showUI(this);
         obf_K_e_3075.playerBagUI.x = this.x + 450;
         obf_K_e_3075.playerBagUI.y = this.y;
         obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
      }
      
      private function obf_u_y_2763(param1:Event) : void
      {
         if(param1.currentTarget is TableButton)
         {
            this.showGoods(param1.currentTarget.name);
         }
      }
      
      private function showGoods(param1:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:IconItem = null;
         var _loc9_:GoodsBoxUI = null;
         if(this.obf_n_K_2599 == param1)
         {
            return;
         }
         this.obf_S_z_4502();
         var _loc2_:TableButton = pointPage.getChildByName(param1) as TableButton;
         if(!_loc2_)
         {
            return;
         }
         if(this.obf_m_T_4529)
         {
            this.obf_m_T_4529.gotoAndStop(1);
         }
         _loc2_.gotoAndStop(2);
         this.obf_m_T_4529 = _loc2_;
         this.obf_n_K_2599 = param1;
         var _loc3_:Object = ShopManager.getShopConfigByKind(param1);
         if(!_loc3_)
         {
            return;
         }
         pointItem.scrollRect = new Rectangle(0,0,scrollItem.x - pointItem.x,scrollItem.height);
         scrollItem.pageSize = scrollItem.height;
         var _loc4_:int = 0;
         var _loc5_:int = -1;
         for each(_loc6_ in _loc3_.items)
         {
            _loc7_ = GameItemManager.getItemConfig(_loc6_);
            if(_loc7_)
            {
               if(Boolean(_loc7_.activityForBuy) && _loc7_.activityForBuy.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc7_.activityForBuy))
                  {
                     continue;
                  }
               }
               _loc8_ = IconItemManager.getIconItemByCode(_loc6_,"");
               _loc9_ = new GoodsBoxUI(this);
               _loc9_.fashionShow = false;
               _loc9_.addEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc9_.iconBag.pushIconItem(_loc8_);
               this.bags.push(_loc9_.iconBag);
               _loc9_.setRemark(_loc7_.name);
               if(_loc7_.goldPrice > 0)
               {
                  _loc9_.setGold(_loc7_.goldPrice);
               }
               if(_loc7_.moneyPrice > 0)
               {
                  _loc9_.setMoney(_loc7_.moneyPrice);
               }
               if(_loc7_.coinPrice > 0)
               {
                  _loc9_.setCoin(_loc7_.coinPrice);
               }
               _loc5_++;
               _loc9_.x = _loc5_ % 2 * _loc9_.width;
               _loc9_.y = int(_loc5_ / 2) * _loc9_.height;
               _loc4_ = _loc9_.y + _loc9_.height;
               pointItem.addChild(_loc9_);
            }
         }
         if(_loc4_ > scrollItem.height)
         {
            scrollItem.maxScrollPosition = _loc4_ - scrollItem.height;
            scrollItem.visible = true;
         }
         else
         {
            scrollItem.maxScrollPosition = 0;
            scrollItem.visible = false;
         }
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:GoodsBoxUI = null;
         while(pointItem.numChildren > 0)
         {
            _loc1_ = pointItem.getChildAt(0) as GoodsBoxUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc1_.destroy();
            }
            pointItem.removeChildAt(0);
         }
         this.bags = new Array();
      }
      
      private function obf_n_7_4419() : void
      {
         var cmdTable:TableButton = null;
         this.obf_n_K_2599 = "";
         this.obf_m_T_4529 = null;
         while(pointPage.numChildren > 0)
         {
            cmdTable = pointPage.getChildAt(0) as TableButton;
            if(cmdTable)
            {
               try
               {
                  cmdTable.removeEventListener(MouseEvent.CLICK,this.obf_u_y_2763);
               }
               catch(e:Error)
               {
               }
            }
            pointPage.removeChildAt(0);
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
         var _loc5_:SplitBoxUI = new SplitBoxUI(ShopManager.sendShopByItem,[param1.itemCode,param1.buyType,this._npcId,this._menuIndex],1,int(_loc2_.stackSize) || 1,_loc3_,_loc4_);
         WindowManager.showWindow(_loc5_);
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         if(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_m_J_4374)
         {
            obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
         }
         this._npcId = "";
         this._menuIndex = null;
         this.obf_S_z_4502();
         this.obf_n_7_4419();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function destroy() : void
      {
         this.obf_S_z_4502();
         this.obf_n_7_4419();
         this.removeListener();
         try
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         catch(e:Error)
         {
         }
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

