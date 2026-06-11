package com.sunweb.game.rpg.playerUI
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemMotion;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MagicMotionUIMC;
   
   public class MagicMotionUI extends MagicMotionUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var _bags:Array;
      
      public function MagicMotionUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:IconItemBag = null;
         this._bags = new Array();
         super();
         this.initDiversity();
         var _loc1_:int = 0;
         while(_loc1_ <= 41)
         {
            _loc3_ = this["bag" + _loc1_];
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.addValidType(GameItemType.MOTION);
               this._bags.push(_loc4_);
            }
            _loc1_++;
         }
         this.visible = false;
         this.x = 320 + this.width / 2;
         this.y = GameContext.gameStage.stageHeight - this.height / 2 - 40;
         var _loc2_:Array = com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("imo")) as Array;
         if(_loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc6_ = _loc2_[_loc5_];
               if(_loc5_ < this._bags.length)
               {
                  _loc7_ = this._bags[_loc5_];
                  _loc7_.pushIconItem(IconItemMotion.getNewIconItem(_loc6_.code));
               }
               _loc5_++;
            }
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"MagicMotionUI","txtTitle");
         DiversityManager.setTextField(txtDeyPrompt,"MagicMotionUI","txtPrompt");
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
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
         this.visible = false;
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
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
         this._bags = null;
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(param1.haveIconItem)
         {
            param1.useIconItem();
            obf_K_e_3075.closeUI(this);
         }
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

