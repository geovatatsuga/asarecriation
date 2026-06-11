package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.OfflineBonusUIMC;
   
   public class OfflineBonusUI extends OfflineBonusUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      private var moneyCost:int;
      
      public function OfflineBonusUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this._bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this["bag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this._bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
         this.obf_b_a_4279();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"OfflineBonusUI","txtTitle");
         DiversityManager.setTextField(txtDeyExp,"OfflineBonusUI","txtExp");
         DiversityManager.setTextField(txtDeyItems,"OfflineBonusUI","txtItems");
         DiversityManager.setTextField(txtDeyPrompt1,"OfflineBonusUI","txtPrompt1");
         txtExp.mouseEnabled = false;
         cmdOK.label = DiversityManager.getString("OfflineBonusUI","cmdOK");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.addEventListener(MouseEvent.CLICK,this.obf_K_8_981);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.obf_K_8_981);
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
      
      private function obf_K_8_981(param1:Event) : void
      {
         if(this.moneyCost > 0 && GameContext.localPlayer.fullInfo.money < this.moneyCost)
         {
            obf_K_e_3075.showShortOfMoney();
            return;
         }
      }
      
      public function obf_b_a_4279() : void
      {
         var _loc1_:IconItemBag = null;
         txtExp.text = "";
         txtDeyPrompt2.text = "";
         this.moneyCost = 0;
         for each(_loc1_ in this._bags)
         {
            _loc1_.dropIconItem();
         }
         cmdOK.enabled = false;
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
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
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

