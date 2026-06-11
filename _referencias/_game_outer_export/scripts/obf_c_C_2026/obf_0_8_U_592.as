package obf_c_C_2026
{
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import playerUI.BoothBfmViewUIMC;
   
   public class obf_0_8_U_592 extends BoothBfmViewUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      private var time:TimeLimiter = new TimeLimiter(1000);
      
      public function obf_0_8_U_592()
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
      
      public function setBoothBfmContent(param1:Array) : void
      {
         var _loc5_:BoothItemPurchaseInfo = null;
         var _loc6_:Object = null;
         var _loc7_:IconItem = null;
         var _loc8_:obf_0_9_P_664 = null;
         this.clearAllBfmItems();
         pointItems.scrollRect = new Rectangle(0,0,scrollItems.x - pointItems.x,scrollItems.height);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.itemCount > 0)
            {
               _loc6_ = GameItemManager.getItemConfig(_loc5_.itemCode);
               if(_loc6_)
               {
                  _loc7_ = IconItemManager.getIconItemByCode(_loc5_.itemCode,_loc5_.itemId);
                  if(_loc7_)
                  {
                     _loc7_.itemCount = _loc5_.itemCount;
                     _loc8_ = new obf_0_9_P_664(this,_loc5_.itemIndex);
                     _loc7_.par = _loc8_;
                     _loc8_.iconBag.pushIconItem(_loc7_);
                     this._bags.push(_loc8_.iconBag);
                     _loc8_.txtItemName.htmlText = "<font color=\'#" + GameItemRank.getRankColor(_loc6_.rank).toString(16) + "\'>" + _loc6_.name + "</font>";
                     _loc8_.setGold(_loc5_.itemPrice);
                     _loc8_.x = _loc3_ % 2 * _loc8_.width;
                     _loc8_.y = _loc8_.height * int(_loc3_ / 2);
                     if(_loc3_ % 2 == 0)
                     {
                        _loc2_ += _loc8_.height;
                     }
                     _loc3_++;
                     pointItems.addChild(_loc8_);
                  }
               }
            }
            _loc4_++;
         }
         scrollItems.maxScrollPosition = 0;
         if(_loc2_ > scrollItems.height)
         {
            scrollItems.maxScrollPosition = _loc2_ - scrollItems.height;
         }
         this.refurbishItems();
      }
      
      private function refurbishItems() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            if(_loc1_)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc1_.haveIconItem.itemCode) <= 0)
               {
                  _loc1_.haveIconItem.addGrayMask();
               }
               else
               {
                  _loc1_.haveIconItem.removeGrayMask();
               }
            }
         }
      }
      
      private function onEnter(param1:Event) : void
      {
         if(this.time.checkTimeout())
         {
            this.refurbishItems();
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
         obf_K_e_3075.showBoothBfmWin(param1.haveIconItem.itemCode,param1.itemIndex,obf_K_e_3075.boothViewUI.playerName,1,param1.haveIconItem.itemCount,obf_s_h_3802.obf_Q_T_4344,_loc4_.gold);
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnter);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnter);
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         this.clearAllBfmItems();
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
      }
   }
}

