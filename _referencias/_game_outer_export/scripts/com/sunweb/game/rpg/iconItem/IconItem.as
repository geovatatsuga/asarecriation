package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class IconItem extends Sprite
   {
      
      public var itemType:int;
      
      public var icon:DisplayObject;
      
      private var _iconMask:DisplayObject;
      
      public var iconItemRank:int;
      
      private var _qualityMask:DisplayObject;
      
      private var _count:int;
      
      private var _countText:TextField;
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemName:String;
      
      public var par:*;
      
      private var shape:Shape;
      
      public function IconItem(param1:DisplayObject)
      {
         super();
         this.doubleClickEnabled = true;
         this.icon = param1;
         this._count = 1;
         if(this.icon)
         {
            this.addChild(this.icon);
         }
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc3_:int = 180;
         var _loc4_:GameTipUI = new GameTipUI("Items");
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(_loc5_)
         {
            GameItemManager.obf_4_G_4299(_loc5_.name,_loc5_.rank,_loc4_,_loc3_);
            GameItemManager.obf_o_l_1634(_loc5_,_loc4_,_loc3_);
            _loc4_.addTipInfo(_loc5_.remark,_loc3_,_loc4_.maxRow + 2);
            GameItemManager.obf_J_l_4537(_loc5_,_loc4_,_loc3_);
            GameItemManager.setItemTipValidTime(param1,param2,_loc4_,_loc3_);
         }
         GameTipManager.showTip(_loc4_);
      }
      
      public function set iconMask(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this._iconMask) && this.contains(this._iconMask))
         {
            this.removeChild(this._iconMask);
         }
         this._iconMask = param1;
         this.addChild(this._iconMask);
      }
      
      public function addIconMask(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(param1) && this.contains(param1))
         {
            this.removeChild(param1);
         }
         this.addChild(param1);
      }
      
      public function addGrayMask() : void
      {
         if(Boolean(this.shape) && this.contains(this.shape))
         {
            this.removeChild(this.shape);
         }
         this.shape = new Shape();
         this.shape.graphics.beginFill(12632261,0.6);
         this.shape.graphics.drawRect(0,0,32,32);
         this.shape.graphics.endFill();
         this.addChild(this.shape);
      }
      
      public function removeGrayMask() : void
      {
         if(Boolean(this.shape) && this.contains(this.shape))
         {
            this.removeChild(this.shape);
            this.shape = null;
         }
      }
      
      public function set itemCount(param1:int) : void
      {
         this._count = param1;
         if(this._countText == null)
         {
            this._countText = new TextField();
            this._countText.autoSize = TextFieldAutoSize.RIGHT;
            this._countText.textColor = 16777215;
            this._countText.y = 16;
            this._countText.x = 0;
            this._countText.width = 32;
            this._countText.mouseEnabled = false;
            this._countText.filters = [new DropShadowFilter(1,45,0,1,0,0)];
         }
         if(param1 < 1)
         {
            this._countText.textColor = 16711680;
         }
         else
         {
            this._countText.textColor = 16777215;
         }
         this.addChild(this._countText);
         this._countText.text = param1 + "";
      }
      
      public function get itemCount() : int
      {
         return this._count;
      }
      
      public function set countTextVisible(param1:Boolean) : void
      {
         this._countText.visible = param1;
      }
      
      public function get countTextVisible() : Boolean
      {
         return this._countText.visible;
      }
      
      public function set countTextColor(param1:int) : void
      {
         this._countText.textColor = param1;
      }
      
      public function get countTextColor() : int
      {
         return this._countText.textColor;
      }
      
      public function set rankMask(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this._qualityMask) && this.contains(this._qualityMask))
         {
            this.removeChild(this._qualityMask);
         }
         this._qualityMask = param1;
         if(this._qualityMask is InteractiveObject)
         {
            (this._qualityMask as InteractiveObject).mouseEnabled = false;
         }
         this.addChild(this._qualityMask);
      }
      
      public function addType(param1:int) : void
      {
         this.itemType |= param1;
      }
      
      public function destroy() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.icon = null;
         this.par = null;
         this.itemType = 0;
      }
      
      public function useIcon(param1:* = null) : Boolean
      {
         return false;
      }
      
      public function showTipInfo(param1:IconItemBag) : void
      {
         GameItemManager.showItemTipInfo(this.itemCode,this.itemId);
      }
      
      public function clone() : IconItem
      {
         return null;
      }
   }
}

