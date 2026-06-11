package com.sunweb.game.rpg.iconItem
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import playerUI.IconItemBagTips;
   
   public class IconItemBag extends Sprite
   {
      
      private var _isLocked:Boolean;
      
      public var showInfoTip:Boolean;
      
      public var lockDrag:Boolean;
      
      private var _troughMC:MovieClip;
      
      private var _validType:int;
      
      private var _invalidType:int;
      
      private var _id:String;
      
      public var haveIconItem:IconItem;
      
      private var _keyTip:TextField;
      
      private var _parentIconUI:IIconItemUI;
      
      private var _itemIndex:int;
      
      private var obf_F_V_4405:IconItemBagTips;
      
      public function IconItemBag(param1:MovieClip, param2:IIconItemUI, param3:int, param4:String = "")
      {
         super();
         this._id = param4;
         this._parentIconUI = param2;
         this._itemIndex = param3;
         param1.doubleClickEnabled = true;
         this.doubleClickEnabled = true;
         this._troughMC = param1;
         this.x = this._troughMC.x;
         this.y = this._troughMC.y;
         this._troughMC.x = 0;
         this._troughMC.y = 0;
         if(this._troughMC.parent != null)
         {
            this._troughMC.parent.addChild(this);
         }
         this.addChild(this._troughMC);
         this.name = this._troughMC.name;
         this.isLocked = false;
         this._keyTip = this._troughMC.keyTip;
         if(this._keyTip != null)
         {
            this._keyTip.mouseEnabled = false;
            this._keyTip.cacheAsBitmap = true;
            this.addChild(this._keyTip);
         }
      }
      
      public function get parentIconUI() : IIconItemUI
      {
         return this._parentIconUI;
      }
      
      public function set itemIndex(param1:int) : void
      {
         this._itemIndex = param1;
      }
      
      public function get itemIndex() : int
      {
         return this._itemIndex;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get bagMC() : DisplayObject
      {
         return this._troughMC;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         this._isLocked = param1;
         if(!param1)
         {
            this._troughMC.gotoAndStop("enable");
         }
         else
         {
            this._troughMC.gotoAndStop("disable");
         }
      }
      
      public function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function setKeyTipInfo(param1:String) : void
      {
         if(this._keyTip)
         {
            this._keyTip.text = param1 ? param1 : "";
         }
      }
      
      public function setTips(param1:IconItemBagTips) : void
      {
         this.obf_F_V_4405 = param1;
         this.obf_F_V_4405.mouseEnabled = false;
         this.addChild(this.obf_F_V_4405);
      }
      
      public function obf_o_g_3238() : void
      {
         if(!this.obf_F_V_4405)
         {
            return;
         }
         if(this.contains(this.obf_F_V_4405))
         {
            this.removeChild(this.obf_F_V_4405);
            this.obf_F_V_4405 = null;
         }
      }
      
      public function useIconItem(param1:* = null) : void
      {
         if(this.haveIconItem)
         {
            this.haveIconItem.useIcon(param1);
         }
      }
      
      public function showIconItemTip() : void
      {
         if(this.haveIconItem)
         {
            this.haveIconItem.showTipInfo(this);
         }
      }
      
      private function checkType(param1:int) : Boolean
      {
         if((this._validType & param1) != 0)
         {
            return true;
         }
         if((this._invalidType & param1) != 0)
         {
            return false;
         }
         return false;
      }
      
      public function pushIconItem(param1:IconItem) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(this.haveIconItem)
         {
            return false;
         }
         if(!this.checkType(param1.itemType))
         {
            return false;
         }
         this.haveIconItem = param1;
         this.haveIconItem.x = 0;
         this.haveIconItem.y = 0;
         this.addChildAt(this.haveIconItem,1);
         return true;
      }
      
      public function dropIconItem() : void
      {
         if(Boolean(this.haveIconItem) && this.contains(this.haveIconItem))
         {
            this.haveIconItem.destroy();
         }
         this.haveIconItem = null;
      }
      
      public function destroy() : void
      {
         this.obf_o_g_3238();
         this.isLocked = false;
         this.delListener();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this._troughMC = null;
         if(this.haveIconItem != null)
         {
            this.haveIconItem.destroy();
         }
         this.haveIconItem = null;
      }
      
      private function addListener() : void
      {
         this._troughMC.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._troughMC.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function delListener() : void
      {
         this._troughMC.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._troughMC.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(this.isLocked)
         {
            return;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(this.isLocked)
         {
            return;
         }
      }
      
      public function addValidType(param1:int) : void
      {
         this._validType |= param1;
      }
      
      public function delValidType(param1:int) : void
      {
         this._validType &= ~param1;
      }
      
      public function addInvalidType(param1:int) : void
      {
         this._invalidType |= param1;
      }
      
      public function delInvalidType(param1:int) : void
      {
         this._invalidType &= ~param1;
      }
   }
}

