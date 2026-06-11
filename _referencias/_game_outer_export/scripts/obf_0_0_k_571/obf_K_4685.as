package obf_0_0_k_571
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AdhocBoxMC;
   
   public class obf_K_4685 extends AdhocBoxMC
   {
      
      public static const obf_v_u_1705:String = "AdhocBox_EVENT";
      
      public var _iconBag:IconItemBag;
      
      private var _itemConfig:Object;
      
      public function obf_K_4685(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         txtBuy.mouseEnabled = false;
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function get itemConfig() : Object
      {
         return this._itemConfig;
      }
      
      public function set itemConfig(param1:Object) : void
      {
         this._itemConfig = param1;
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:Event) : void
      {
         dispatchEvent(new Event(obf_v_u_1705));
      }
      
      public function setMoney(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getMoneyDisplay(param1);
         while(pricePoint.numChildren > 0)
         {
            pricePoint.removeChildAt(0);
         }
         pricePoint.addChild(_loc2_);
      }
      
      public function setNowMoney(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getMoneyDisplay(param1);
         while(priceNewPoint.numChildren > 0)
         {
            priceNewPoint.removeChildAt(0);
         }
         priceNewPoint.addChild(_loc2_);
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtBuy,"ShopBoxUI","txtBuy");
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
   }
}

