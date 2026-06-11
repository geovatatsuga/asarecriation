package obf_0_3_8_668
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TreasuryMsgUI1MC;
   
   public class TreasuryMsgUI1 extends TreasuryMsgUI1MC implements IIconItemUI
   {
      
      private var _bag:IconItemBag;
      
      private var item:Object;
      
      private var attr:Object;
      
      public function TreasuryMsgUI1()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = obf_K_e_3075.obf_0___I_542.x;
         this.y = obf_K_e_3075.obf_0___I_542.y;
         this._bag = new IconItemBag(needItem,this,0);
         this._bag.addValidType(GameItemType.ALL);
         this._bag.isLocked = false;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtMsgTitle,"TreasuryMsgUI","txtMsgTitle");
         cmdOk.label = DiversityManager.getString("TreasuryMsgUI","cmdOk");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOk.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOk.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      public function setShowContent(param1:Object = null, param2:Object = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:IconItem = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         this._bag.dropIconItem();
         this.item = param1;
         this.attr = param2;
         var _loc11_:int = 0;
         var _loc12_:* = param1;
         for(_loc3_ in _loc12_)
         {
            _loc7_ = IconItemManager.getIconItemByCode(_loc3_,null);
            _loc8_ = int(param1[_loc3_]);
            this._bag.pushIconItem(_loc7_);
            itemName.text = GameItemManager.getItemName(_loc3_) + "x" + _loc8_;
         }
         _loc4_ = new Array();
         for(_loc5_ in param2)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort();
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc9_ = _loc4_[_loc6_];
            _loc10_ = int(param2[_loc9_]);
            this["attrName" + _loc6_].text = RoleAttributesModifierEnum.getAttributesName(int(_loc9_));
            this["attrValue" + _loc6_].text = "+" + _loc10_;
            _loc6_++;
         }
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
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
         this._bag.destroy();
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         return [this._bag];
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

