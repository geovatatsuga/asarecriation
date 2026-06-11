package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ItemShowBoxUIMC;
   
   public dynamic class ItemShowBoxUI extends ItemShowBoxUIMC
   {
      
      private var _haveItem:Boolean;
      
      private var _bag:IconItemBag;
      
      private var _iconItem:IconItem;
      
      private var _selected:Boolean;
      
      public var selectable:Boolean;
      
      public function ItemShowBoxUI(param1:String, param2:int, param3:String = "")
      {
         super();
         this.gotoAndStop(1);
         this._iconItem = IconItemManager.getIconItemByCode(param1,param3);
         if(this._iconItem)
         {
            this._iconItem.itemCount = param2;
            txtItemName.textColor = GameItemRank.getRankColor(this._iconItem.iconItemRank);
            txtItemName.text = this._iconItem.itemName + " x" + param2;
            this._haveItem = true;
         }
      }
      
      public function get haveItem() : Boolean
      {
         return this._haveItem;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.gotoAndStop(param1 ? 3 : 2);
         this._selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function get itemId() : String
      {
         if(this._iconItem)
         {
            return this._iconItem.itemId;
         }
         return "";
      }
      
      public function get itemCode() : String
      {
         if(this._iconItem)
         {
            return this._iconItem.itemCode;
         }
         return "";
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:Event) : void
      {
         if(this.selectable)
         {
            this.selected = !this._selected;
         }
      }
      
      public function dockParentUI(param1:IIconItemUI, param2:Array) : void
      {
         if(this._iconItem)
         {
            this._bag = new IconItemBag(bag,param1,0);
            this._bag.addValidType(GameItemType.ALL);
            this._bag.lockDrag = true;
            this._bag.pushIconItem(this._iconItem);
            param2.push(this._bag);
         }
      }
      
      public function destroy() : void
      {
         if(this._bag)
         {
            if(this._bag.haveIconItem != this._iconItem)
            {
               this._iconItem.destroy();
            }
            this._bag.destroy();
         }
      }
   }
}

