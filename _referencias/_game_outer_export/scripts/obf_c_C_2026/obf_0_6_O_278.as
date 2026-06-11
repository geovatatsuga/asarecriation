package obf_c_C_2026
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.booth.BoothItemBuyInfo;
   import com.sunweb.game.rpg.booth.BoothItemSellInfo;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import playerUI.BoothSellViewUIMC;
   
   public class obf_0_6_O_278 extends BoothSellViewUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      public function obf_0_6_O_278()
      {
         super();
         this.initDiversity();
         this._bags = new Array();
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
      
      private function buyItem(param1:String, param2:String, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = param3 * param5;
         if(GameContext.localPlayer.fullInfo.gold < _loc6_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
            return;
         }
         var _loc7_:BoothItemBuyInfo = new BoothItemBuyInfo();
         _loc7_.itemCode = param1;
         _loc7_.itemId = param2;
         _loc7_.itemCount = param5;
         _loc7_.itemPrice = param3;
         _loc7_.itemIndex = param4;
         obf_c_o_n_t_i_n_u_e_24.sendBuyItem(obf_K_e_3075.boothViewUI.playerName,_loc7_);
      }
      
      public function setBoothContent(param1:Array, param2:String) : void
      {
         var _loc6_:BoothItemSellInfo = null;
         var _loc7_:Object = null;
         var _loc8_:IconItem = null;
         var _loc9_:obf_0_9_P_664 = null;
         this.clearAllSellItems();
         pointItems.scrollRect = new Rectangle(0,0,scrollItems.x - pointItems.x,scrollItems.height);
         obf_K_e_3075.boothViewUI.playerName = param2;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1[_loc5_];
            if(_loc6_.itemCount > 0)
            {
               _loc7_ = GameItemManager.getItemConfig(_loc6_.itemCode);
               if(_loc7_)
               {
                  _loc8_ = IconItemManager.getIconItemByCode(_loc6_.itemCode,_loc6_.itemId);
                  if(_loc8_)
                  {
                     _loc8_.itemCount = _loc6_.itemCount;
                     _loc9_ = new obf_0_9_P_664(this,_loc6_.itemIndex);
                     _loc8_.par = _loc9_;
                     _loc9_.iconBag.pushIconItem(_loc8_);
                     this._bags.push(_loc9_.iconBag);
                     _loc9_.txtItemName.htmlText = "<font color=\'#" + GameItemRank.getRankColor(_loc7_.rank).toString(16) + "\'>" + _loc7_.name + "</font>";
                     _loc9_.setGold(_loc6_.itemPrice);
                     _loc9_.x = _loc4_ % 2 * _loc9_.width;
                     _loc9_.y = _loc9_.height * int(_loc4_ / 2);
                     if(_loc4_ % 2 == 0)
                     {
                        _loc3_ += _loc9_.height;
                     }
                     _loc4_++;
                     pointItems.addChild(_loc9_);
                  }
               }
            }
            _loc5_++;
         }
         scrollItems.maxScrollPosition = 0;
         if(_loc3_ > scrollItems.height)
         {
            scrollItems.maxScrollPosition = _loc3_ - scrollItems.height;
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
               _loc1_.destroy();
            }
            pointItems.removeChildAt(0);
         }
         this._bags = new Array();
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(!param1 || !param1.haveIconItem)
         {
            return;
         }
         var _loc4_:obf_0_9_P_664 = param1.haveIconItem.par as obf_0_9_P_664;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:SplitBoxUI = new SplitBoxUI(this.buyItem,[param1.haveIconItem.itemCode,param1.haveIconItem.itemId,_loc4_.gold,param1.itemIndex],1,param1.haveIconItem.itemCount,SplitBoxUI.obf_Q_T_4344,_loc4_.gold);
         WindowManager.showWindow(_loc5_);
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
         var _loc1_:IconItemBag = null;
         this.removeListener();
         this.clearAllSellItems();
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
      }
   }
}

