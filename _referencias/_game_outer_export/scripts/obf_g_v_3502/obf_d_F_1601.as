package obf_g_v_3502
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.shop.obf_t_u_3691;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import playerUI.LandingHortationUIMC;
   
   public class obf_d_F_1601 extends LandingHortationUIMC implements IIconItemUI
   {
      
      private var dayBags:Array;
      
      private var runBags:Array;
      
      private var bags:Array;
      
      private var obf_0_0_U_242:Array;
      
      private const dayHortation:String = "$oneDayBonus";
      
      private const obf_0_1_D_683:String = "$dayBouns";
      
      public const obf_V_S_2931:String = "$dayBoon";
      
      private var isOpen:Boolean;
      
      public function obf_d_F_1601()
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:IconItemBag = null;
         var _loc9_:MovieClip = null;
         var _loc10_:IconItemBag = null;
         var _loc11_:IconItemBag = null;
         var _loc12_:IconItem = null;
         super();
         this.initDiversity();
         this.bags = new Array();
         this.dayBags = new Array();
         this.runBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc7_ = this["dayBag" + _loc1_];
            if(_loc7_)
            {
               _loc8_ = new IconItemBag(_loc7_,this,_loc1_);
               _loc8_.lockDrag = true;
               _loc8_.addValidType(GameItemType.ALL);
               this.dayBags.push(_loc8_);
               this.bags.push(_loc8_);
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc9_ = this["runBag" + _loc2_];
            if(_loc9_)
            {
               _loc10_ = new IconItemBag(_loc9_,this,_loc2_);
               _loc10_.lockDrag = true;
               _loc10_.addValidType(GameItemType.ALL);
               this.runBags.push(_loc10_);
               this.bags.push(_loc10_);
            }
            _loc2_++;
         }
         var _loc3_:Object = WorldConfig.getObjectSetting("oneDayBonusItemList");
         var _loc4_:Array = new Array();
         for(_loc5_ in _loc3_)
         {
            _loc4_.push({
               "itemCode":_loc5_,
               "itemCount":_loc3_[_loc5_]
            });
         }
         _loc4_.sortOn("itemCode");
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            if(_loc6_ >= this.dayBags.length)
            {
               break;
            }
            _loc11_ = this.dayBags[_loc6_];
            _loc12_ = IconItemManager.getIconItemByCode(_loc4_[_loc6_].itemCode,"");
            _loc12_.itemCount = _loc4_[_loc6_].itemCount;
            _loc11_.pushIconItem(_loc12_);
            _loc6_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         dayButton.addEventListener(MouseEvent.CLICK,this.onDayButton);
         runButton.addEventListener(MouseEvent.CLICK,this.onRunButton);
      }
      
      private function removeListener() : void
      {
         dayButton.removeEventListener(MouseEvent.CLICK,this.onDayButton);
         runButton.removeEventListener(MouseEvent.CLICK,this.onRunButton);
      }
      
      private function onDayButton(param1:MouseEvent) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.dayHortation);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DayBonusUI","alreadyDraw"));
            return;
         }
         obf_v_1_1352.sendDayHortation();
      }
      
      private function onRunButton(param1:MouseEvent) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_0_1_D_683);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DayBonusUI","alreadyDraw"));
            return;
         }
         obf_v_1_1352.sendRunHortation();
      }
      
      public function upData(param1:int, param2:String) : void
      {
         var _loc6_:obf_t_u_3691 = null;
         var _loc7_:String = null;
         this.obf_S_z_4502();
         GameContext.localPlayer.fullInfo.consecutiveLoginDays = param1;
         GameContext.localPlayer.fullInfo.boonItemCode = param2;
         txtDays.htmlText = DiversityManager.getString("DayBonusUI","txtDays",[param1]);
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_0_1_D_683);
         if(JSONUtil.getInt(_loc3_,["numOfDay"]) > 0)
         {
            DiversityManager.setTextField(txtRunBonus,"DayBonusUI","txtRunBonusT");
            this.showRunItemList(param1 + 1);
            runButton.enabled = false;
         }
         else
         {
            DiversityManager.setTextField(txtRunBonus,"DayBonusUI","txtRunBonus");
            this.showRunItemList(param1);
            runButton.enabled = true;
         }
         this.upDayData();
         this.obf_0_0_U_242 = new Array();
         DiversityManager.setTextField(txtRunBoonGold,"DayBonusUI","txtRunBoonGold",[this.getRebate(param1) * 10]);
         var _loc4_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:IconItem = IconItemManager.getIconItemByCode(param2,"");
         if(_loc5_)
         {
            _loc6_ = new obf_t_u_3691(this,true);
            _loc6_.iconBag.pushIconItem(_loc5_);
            this.obf_0_0_U_242.push(_loc6_.iconBag);
            _loc7_ = GameItemRank.getRankColor(_loc4_.rank).toString(16);
            _loc6_.setName("<FONT color=\'#" + _loc7_ + "\'>" + _loc4_.name + "</FONT>");
            if(_loc4_.moneyPrice > 0)
            {
               _loc6_.setPrice(0,JSONUtil.getInt(_loc4_,["moneyPrice"]),this.getRebateRound(JSONUtil.getInt(_loc4_,["moneyPrice"])));
            }
            else if(_loc4_.goldPrice > 0)
            {
               _loc6_.setPrice(1,JSONUtil.getInt(_loc4_,["goldPrice"]),this.getRebateRound(JSONUtil.getInt(_loc4_,["goldPrice"])));
            }
            else if(_loc4_.coinPrice > 0)
            {
               _loc6_.setPrice(2,JSONUtil.getInt(_loc4_,["coinPrice"]),this.getRebateRound(JSONUtil.getInt(_loc4_,["coinPrice"])));
            }
            iconItem.addChild(_loc6_);
         }
      }
      
      public function upDayData() : void
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.dayHortation);
         if(JSONUtil.getInt(_loc1_,["numOfDay"]) > 0)
         {
            dayButton.enabled = false;
         }
         else
         {
            dayButton.enabled = true;
         }
      }
      
      private function showRunItemList(param1:int) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:IconItemBag = null;
         var _loc9_:Object = null;
         var _loc10_:IconItem = null;
         if(param1 < 1)
         {
            param1 = 1;
         }
         var _loc2_:Array = WorldConfig.getObjectSetting("continuDayBonusItemList") as Array;
         if(!_loc2_)
         {
            return;
         }
         if(param1 > _loc2_.length)
         {
            param1 = int(_loc2_.length);
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return;
         }
         for each(_loc4_ in this.runBags)
         {
            _loc4_.dropIconItem();
         }
         _loc5_ = new Array();
         for(_loc6_ in _loc3_.itemCodeList)
         {
            _loc5_.push({
               "itemCode":_loc6_,
               "itemCount":_loc3_.itemCodeList[_loc6_]
            });
         }
         _loc5_.sortOn("itemCode");
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            if(_loc7_ >= this.runBags.length)
            {
               break;
            }
            _loc8_ = this.runBags[_loc7_];
            _loc9_ = GameItemManager.getItemConfig(_loc5_[_loc7_].itemCode);
            if(_loc9_)
            {
               _loc10_ = IconItemManager.getIconItemByCode(_loc5_[_loc7_].itemCode,"");
               _loc10_.itemCount = _loc5_[_loc7_].itemCount;
               _loc8_.pushIconItem(_loc10_);
            }
            _loc7_++;
         }
      }
      
      public function getRebate(param1:int) : Number
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         var _loc2_:Array = WorldConfig.getObjectSetting("continuDayBonusItemList") as Array;
         if(!_loc2_)
         {
            return 0;
         }
         if(param1 > _loc2_.length)
         {
            param1 = int(_loc2_.length);
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return 0;
         }
         return _loc3_.rebate;
      }
      
      public function getRebateRound(param1:Number) : Number
      {
         return Math.round(param1 * this.getRebate(GameContext.localPlayer.fullInfo.consecutiveLoginDays));
      }
      
      private function onBuyItem(param1:ShopBuyEvent) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_V_S_2931);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            return;
         }
         var _loc3_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.type == GameItemType.RIDE)
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
         WindowManager.showConfirmBox(DiversityManager.getString("DayBonusUI","isBuy"),this.sureDo);
      }
      
      private function sureDo(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_v_1_1352.sendBoon();
         }
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:obf_t_u_3691 = null;
         while(iconItem.numChildren > 0)
         {
            _loc2_ = iconItem.getChildAt(0) as obf_t_u_3691;
            if(_loc2_)
            {
               _loc2_.removeEventListener(ShopBuyEvent.SHOP_BUY,this.onBuyItem);
               _loc2_.destroy();
            }
            iconItem.removeChildAt(0);
         }
         for each(_loc1_ in this.runBags)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags.concat(this.obf_0_0_U_242);
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
         DiversityManager.setTextField(txtDayBonus,"DayBonusUI","txtDayBonus");
         DiversityManager.setTextField(txtRunBoon,"DayBonusUI","txtRunBoon");
         dayButton.label = DiversityManager.getString("DayBonusUI","cmdExp");
         runButton.label = DiversityManager.getString("DayBonusUI","cmdExp");
      }
      
      public function showUI() : void
      {
         var _loc1_:PeriodCounterItemInfo = null;
         this.visible = true;
         if(!this.isOpen)
         {
            _loc1_ = obf_Y_F_1424.getCounter(this.obf_0_1_D_683);
            if(JSONUtil.getInt(_loc1_,["numOfDay"]) > 0)
            {
               DiversityManager.setTextField(txtRunBonus,"DayBonusUI","txtRunBonusT");
               this.showRunItemList(GameContext.localPlayer.fullInfo.consecutiveLoginDays + 1);
               runButton.enabled = false;
            }
            else
            {
               DiversityManager.setTextField(txtRunBonus,"DayBonusUI","txtRunBonus");
               this.showRunItemList(GameContext.localPlayer.fullInfo.consecutiveLoginDays);
               runButton.enabled = true;
            }
            this.upDayData();
            this.isOpen = true;
         }
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
   }
}

