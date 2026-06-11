package com.sunweb.game.rpg.playerUI.renew
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.RenewListUIMC;
   
   public class RenewListUI extends RenewListUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var selectedItem:ItemShowBoxUI;
      
      public function RenewListUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         scrollItem.pageSize = scrollItem.height;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RenewListUI","txtTitle");
         cmdResult.label = DiversityManager.getString("RenewListUI","cmdResult");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
         scrollItem.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
         scrollItem.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
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
      
      private function onClickResult(param1:Event) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      private function obf_3_S_1490(param1:Event) : void
      {
         itemPoint.scrollRect = new Rectangle(0,scrollItem.scrollPosition,scrollItem.x - itemPoint.x,scrollItem.height);
      }
      
      public function refreshItemList() : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:Object = null;
         var _loc5_:ItemShowBoxUI = null;
         this.clearItem();
         this.bags = new Array();
         var _loc1_:Array = new Array();
         if(obf_K_e_3075.playerFullInfoUI)
         {
            _loc1_ = _loc1_.concat(obf_K_e_3075.playerFullInfoUI.equipBags);
         }
         if(obf_K_e_3075.rideBoxUI)
         {
            _loc1_ = _loc1_.concat(obf_K_e_3075.rideBoxUI.rideBags);
         }
         if(obf_K_e_3075.playerBagUI)
         {
            _loc1_ = _loc1_.concat(obf_K_e_3075.playerBagUI.getIconItemBags());
         }
         var _loc2_:int = 0;
         for each(_loc3_ in _loc1_)
         {
            if(!(_loc3_.isLocked || !_loc3_.haveIconItem))
            {
               if(!obf_L_l_4100.isEmpty(_loc3_.haveIconItem.itemId))
               {
                  _loc4_ = GameItemManager.getItemConfig(_loc3_.haveIconItem.itemCode);
                  if(!(!_loc4_ || !JSONUtil.getBoolean(_loc4_,["canRenew"])))
                  {
                     _loc5_ = new ItemShowBoxUI(_loc3_.haveIconItem.itemCode,1,_loc3_.haveIconItem.itemId);
                     _loc5_.selectable = true;
                     _loc5_.dockParentUI(this,this.bags);
                     _loc5_.addEventListener(MouseEvent.CLICK,this.onSelectItem);
                     _loc5_.y = _loc2_;
                     _loc2_ += _loc5_.height;
                     itemPoint.addChild(_loc5_);
                  }
               }
            }
         }
         itemPoint.scrollRect = new Rectangle(0,0,scrollItem.x - itemPoint.x,scrollItem.height);
         scrollItem.visible = false;
         if(_loc2_ > scrollItem.height)
         {
            scrollItem.maxScrollPosition = _loc2_ - scrollItem.height;
            scrollItem.visible = true;
         }
      }
      
      private function onSelectItem(param1:Event) : void
      {
         var _loc2_:ItemShowBoxUI = param1.currentTarget as ItemShowBoxUI;
         if(_loc2_)
         {
            if(this.selectedItem)
            {
               this.selectedItem.selected = false;
            }
            this.selectedItem = _loc2_;
            this.selectedItem.selected = true;
            if(obf_K_e_3075.obf_t_q_3040)
            {
               obf_K_e_3075.obf_t_q_3040.showRenewPlan(this.selectedItem.itemCode,this.selectedItem.itemId);
               obf_K_e_3075.obf_t_q_3040.x = this.x + this.width / 2 + obf_K_e_3075.obf_t_q_3040.width / 2;
            }
         }
      }
      
      private function clearItem() : void
      {
         var thisItemShow:ItemShowBoxUI = null;
         this.selectedItem = null;
         while(itemPoint.numChildren > 0)
         {
            thisItemShow = itemPoint.getChildAt(0) as ItemShowBoxUI;
            if(thisItemShow)
            {
               try
               {
                  thisItemShow.removeEventListener(MouseEvent.CLICK,this.onSelectItem);
               }
               catch(e:Error)
               {
               }
               thisItemShow.destroy();
            }
            itemPoint.removeChildAt(0);
         }
         this.bags = null;
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
         this.visible = true;
         this.refreshItemList();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clearItem();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function destroy() : void
      {
         this.clearItem();
         this.removeListener();
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

