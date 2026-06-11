package obf_c_C_2026
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.BoothBfmUIMC;
   
   public class obf_0___4_699 extends BoothBfmUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      private var time:TimeLimiter = new TimeLimiter(1000);
      
      public function obf_0___4_699()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this._bags = new Array();
         scrollItems.pageSize = scrollItems.height;
         this.addListener();
      }
      
      private function addListener() : void
      {
         scrollItems.addEventListener(ScrollEvent.SCROLL,this.onScrollItem);
         cmdBfmBuy.addEventListener(MouseEvent.CLICK,this.obf_U_o_4332);
      }
      
      private function removeListener() : void
      {
         scrollItems.removeEventListener(ScrollEvent.SCROLL,this.onScrollItem);
         cmdBfmBuy.removeEventListener(MouseEvent.CLICK,this.obf_U_o_4332);
      }
      
      private function onScrollItem(param1:Event) : void
      {
         pointItems.scrollRect = new Rectangle(0,scrollItems.scrollPosition,scrollItems.x - pointItems.x,scrollItems.height);
      }
      
      private function obf_U_o_4332(param1:MouseEvent) : void
      {
         if(GameContext.localPlayer.isBooth)
         {
            return;
         }
         obf_K_e_3075.showUI(obf_K_e_3075.boothItemUI);
         param1.stopPropagation();
      }
      
      public function addBfmItem(param1:int, param2:String, param3:String, param4:int) : void
      {
         var _loc5_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:IconItem = IconItemManager.getIconItemByCode(param2,param3);
         if(!_loc6_)
         {
            return;
         }
         _loc6_.itemCount = param4;
         var _loc7_:obf_0_9_P_664 = new obf_0_9_P_664(this);
         _loc6_.par = _loc7_;
         _loc7_.iconBag.pushIconItem(_loc6_);
         this._bags.push(_loc7_.iconBag);
         if(!GameContext.localPlayer.isBooth)
         {
            _loc7_.cmdClose.visible = true;
         }
         _loc7_.addEventListener(obf_0_9_P_664.obf_0_7_f_116,this.onBoothClose);
         if(param1 < 1)
         {
            param1 = 1;
         }
         _loc7_.txtItemName.htmlText = "<font color=\'#" + GameItemRank.getRankColor(_loc5_.rank).toString(16) + "\'>" + _loc5_.name + "</font>";
         _loc7_.setGold(param1);
         pointItems.addChild(_loc7_);
         this.obf_e_4_776();
      }
      
      private function onBoothClose(param1:Event) : void
      {
         this.removeBfmItem(param1.target as obf_0_9_P_664);
      }
      
      private function removeBfmItem(param1:obf_0_9_P_664) : void
      {
         if(Boolean(param1) && pointItems.contains(param1))
         {
            this._bags.splice(this._bags.indexOf(param1.iconBag),1);
            param1.removeEventListener(obf_0_9_P_664.obf_0_7_f_116,this.onBoothClose);
            pointItems.removeChild(param1);
            param1.destroy();
            this.obf_e_4_776();
         }
      }
      
      public function bfmAmend(param1:obf_0_9_P_664, param2:Number, param3:int) : void
      {
         var _loc5_:obf_0_9_P_664 = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < pointItems.numChildren)
         {
            _loc5_ = pointItems.getChildAt(_loc4_) as obf_0_9_P_664;
            if(_loc5_)
            {
               if(param1 == _loc5_)
               {
                  _loc5_.iconBag.haveIconItem.itemCount = param3;
                  if(param2 < 1)
                  {
                     param2 = 1;
                  }
                  _loc5_.setGold(param2);
                  return;
               }
            }
            _loc4_++;
         }
      }
      
      private function obf_e_4_776() : void
      {
         var _loc3_:obf_0_9_P_664 = null;
         pointItems.scrollRect = new Rectangle(0,0,scrollItems.x - pointItems.x,scrollItems.height);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < pointItems.numChildren)
         {
            _loc3_ = pointItems.getChildAt(_loc2_) as obf_0_9_P_664;
            if(_loc3_)
            {
               _loc3_.x = _loc2_ % 2 * _loc3_.width;
               _loc3_.y = _loc3_.height * int(_loc2_ / 2);
               if(_loc2_ % 2 == 0)
               {
                  _loc1_ += _loc3_.height;
               }
            }
            _loc2_++;
         }
         scrollItems.maxScrollPosition = 0;
         if(_loc1_ > scrollItems.height)
         {
            scrollItems.maxScrollPosition = _loc1_ - scrollItems.height;
         }
      }
      
      public function setBfmItems(param1:Array) : void
      {
         var _loc2_:BoothItemPurchaseInfo = null;
         this.clearAllBfmItems();
         for each(_loc2_ in param1)
         {
            this.addBfmItem(_loc2_.itemPrice,_loc2_.itemCode,_loc2_.itemId,_loc2_.itemCount);
         }
      }
      
      public function clearAllBfmItems() : void
      {
         var _loc1_:obf_0_9_P_664 = null;
         while(pointItems.numChildren > 0)
         {
            _loc1_ = pointItems.getChildAt(0) as obf_0_9_P_664;
            if(_loc1_)
            {
               _loc1_.removeEventListener(obf_0_9_P_664.obf_0_7_f_116,this.onBoothClose);
               _loc1_.destroy();
            }
            pointItems.removeChildAt(0);
         }
         this._bags = new Array();
      }
      
      public function obf_0_7_Q_154() : void
      {
         while(allMony.numChildren > 0)
         {
            allMony.removeChildAt(0);
         }
         var _loc1_:DisplayObject = obf_a_f_2935.getGoldDisplay(GameContext.localPlayer.fullInfo.gold);
         _loc1_.x = -(_loc1_.width / 2);
         allMony.addChild(_loc1_);
      }
      
      public function showGold(param1:int) : void
      {
         while(allayMony.numChildren > 0)
         {
            allayMony.removeChildAt(0);
         }
         var _loc2_:DisplayObject = obf_a_f_2935.getGoldDisplay(param1);
         _loc2_.x = -(_loc2_.width / 2);
         allayMony.addChild(_loc2_);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.time.checkTimeout())
         {
            this.showGold(this.allBfmGold);
         }
      }
      
      public function get allBfmGold() : Number
      {
         var _loc3_:obf_0_9_P_664 = null;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < pointItems.numChildren)
         {
            _loc3_ = pointItems.getChildAt(_loc2_) as obf_0_9_P_664;
            _loc1_ += _loc3_.gold * _loc3_.iconBag.haveIconItem.itemCount;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function setBoothAllay(param1:Boolean) : void
      {
         if(param1)
         {
            DiversityManager.setTextField(txtAllayMony,"BoothUI","txtAllayMony1");
         }
         else
         {
            DiversityManager.setTextField(txtAllayMony,"BoothUI","txtAllayMony");
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(GameContext.localPlayer.isBooth)
         {
            return;
         }
         if(!param1 || !param1.haveIconItem)
         {
            return;
         }
         var _loc4_:obf_0_9_P_664 = param1.haveIconItem.par as obf_0_9_P_664;
         if(!_loc4_)
         {
            return;
         }
         obf_K_e_3075.showUI(obf_K_e_3075.boothItemUI);
         obf_K_e_3075.boothItemUI.setAmendItem(_loc4_,_loc4_.gold);
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(GameContext.localPlayer.isBooth)
         {
            return;
         }
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(!GameItemManager.itemCanTrade(param2.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_CantSellItem"));
            return;
         }
         if(GameItemManager.isEquip(param2.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","promptSellError_CantSellIEqu"));
            return;
         }
         var _loc5_:int = WorldConfig.getValue("booth","freeItemNum");
         if(GameContext.localPlayer.fullInfo.vipLevel > 0)
         {
            _loc5_ += WorldConfig.getValue("booth","vipItemNum");
         }
         if(pointItems.numChildren >= _loc5_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_CantBfmMoreItem",[_loc5_]));
            return;
         }
         obf_K_e_3075.showUI(obf_K_e_3075.boothItemUI);
         obf_K_e_3075.boothItemUI.setItem(param2.itemCode,param2.itemId);
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(GameContext.localPlayer.isBooth)
         {
            return;
         }
         if(param1.haveIconItem)
         {
            this.removeBfmItem(param1.haveIconItem.par);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return 0;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtAllMony,"BoothUI","txtAllMony");
         DiversityManager.setTextField(txtAllayMony,"BoothUI","txtAllayMony");
         cmdBfmBuy.label = DiversityManager.getString("BoothUI","cmdBfmBuy");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

