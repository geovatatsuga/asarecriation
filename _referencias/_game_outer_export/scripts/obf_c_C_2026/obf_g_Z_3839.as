package obf_c_C_2026
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.booth.BoothItemSellInfo;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.module.obf_o_9_2147;
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import playerUI.BoothSellUIMC;
   
   public class obf_g_Z_3839 extends BoothSellUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      public function obf_g_Z_3839()
      {
         super();
         this._bags = new Array();
         this.initDiversity();
         this.visible = false;
         scrollItems.pageSize = scrollItems.height;
         this.addListener();
      }
      
      private function addListener() : void
      {
         scrollItems.addEventListener(ScrollEvent.SCROLL,this.onScrollItem);
      }
      
      private function removeListener() : void
      {
         scrollItems.removeEventListener(ScrollEvent.SCROLL,this.onScrollItem);
      }
      
      private function onScrollItem(param1:Event) : void
      {
         pointItems.scrollRect = new Rectangle(0,scrollItems.scrollPosition,scrollItems.x - pointItems.x,scrollItems.height);
      }
      
      private function addSellItem(param1:int, param2:String, param3:String, param4:int) : void
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
         this.refreshGoodsList();
      }
      
      private function onBoothClose(param1:Event) : void
      {
         this.removeSellItem(param1.target as obf_0_9_P_664);
      }
      
      private function removeSellItem(param1:obf_0_9_P_664) : void
      {
         if(Boolean(param1) && pointItems.contains(param1))
         {
            this._bags.splice(this._bags.indexOf(param1.iconBag),1);
            param1.removeEventListener(obf_0_9_P_664.obf_0_7_f_116,this.onBoothClose);
            pointItems.removeChild(param1);
            param1.destroy();
            this.refreshGoodsList();
         }
      }
      
      private function getBoothItemBox(param1:String, param2:String) : obf_0_9_P_664
      {
         var _loc4_:obf_0_9_P_664 = null;
         var _loc3_:int = 0;
         while(_loc3_ < pointItems.numChildren)
         {
            _loc4_ = pointItems.getChildAt(_loc3_) as obf_0_9_P_664;
            if(_loc4_)
            {
               if(Boolean(_loc4_.iconBag.haveIconItem) && Boolean(_loc4_.iconBag.haveIconItem.itemCode == param1) && _loc4_.iconBag.haveIconItem.itemId == param2)
               {
                  return _loc4_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      private function refreshGoodsList() : void
      {
         var _loc3_:obf_0_9_P_664 = null;
         pointItems.scrollRect = new Rectangle(0,0,scrollItems.x - pointItems.x,scrollItems.height - 5);
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
      
      public function setSellItems(param1:Array) : void
      {
         var _loc2_:BoothItemSellInfo = null;
         this.clearAllSellItems();
         for each(_loc2_ in param1)
         {
            this.addSellItem(_loc2_.itemPrice,_loc2_.itemCode,_loc2_.itemId,_loc2_.itemCount);
         }
      }
      
      public function clearAllSellItems() : void
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
      
      private function confirmItemCount(param1:String, param2:String, param3:int) : void
      {
         WindowManager.showWindow(new obf_o_9_2147(this.addSellItem,[param1,param2,param3],DiversityManager.getString("BoothUI","prompt_InputPrice")));
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc7_:SplitBoxUI = null;
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
         var _loc5_:int = WorldConfig.getValue("booth","freeItemNum");
         if(GameContext.localPlayer.fullInfo.vipLevel > 0)
         {
            _loc5_ += WorldConfig.getValue("booth","vipItemNum");
         }
         if(pointItems.numChildren >= _loc5_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_CantSellMoreItem",[_loc5_]));
            return;
         }
         var _loc6_:GameItemFullInfo = GameItemInfoManager.getItemInfo(param2.itemId);
         if(!obf_L_l_4100.isEmpty(param2.itemId) && !_loc6_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","getItemInfo"));
            GameContext.bagItemManager.sendViewItem(param2.itemId);
            return;
         }
         if(!obf_L_l_4100.isEmpty(param2.itemId) && Boolean(this.getBoothItemBox(param2.itemCode,param2.itemId)))
         {
            return;
         }
         if(Boolean(_loc6_) && Boolean(!_loc6_.isEmpty) && !JSONUtil.getBoolean(_loc6_,["canTrade"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_CantSellItem"));
            return;
         }
         if(param2.itemCount <= 1)
         {
            this.confirmItemCount(param2.itemCode,param2.itemId,1);
         }
         else
         {
            _loc7_ = new SplitBoxUI(this.confirmItemCount,[param2.itemCode,param2.itemId],1,param2.itemCount);
            WindowManager.showWindow(_loc7_);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(GameContext.localPlayer.isBooth)
         {
            return;
         }
         if(param1.haveIconItem)
         {
            this.removeSellItem(param1.haveIconItem.par);
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
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearAllSellItems();
      }
   }
}

