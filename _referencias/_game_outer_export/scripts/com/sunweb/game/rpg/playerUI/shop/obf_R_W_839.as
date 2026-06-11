package com.sunweb.game.rpg.playerUI.shop
{
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.shop.ShopBuyEvent;
   import com.sunweb.game.rpg.shop.ShopManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.SmallGoodsBoxUIMC;
   
   public class obf_R_W_839 extends SmallGoodsBoxUIMC
   {
      
      private var _iconBag:IconItemBag;
      
      public function obf_R_W_839(param1:IIconItemUI)
      {
         super();
         this._iconBag = new IconItemBag(iconBag,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function get iconItemBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function addListener() : void
      {
         this._iconBag.addEventListener(MouseEvent.CLICK,this.obf_M_7_4171);
      }
      
      private function removeListener() : void
      {
         this._iconBag.removeEventListener(MouseEvent.CLICK,this.obf_M_7_4171);
      }
      
      private function obf_M_7_4171(param1:Event) : void
      {
         if(!this._iconBag.haveIconItem)
         {
            return;
         }
         this.obf_0_8_N_104(ShopManager.obf_B_9_2165,this._iconBag.haveIconItem.itemCode);
      }
      
      public function setMoney(param1:int) : void
      {
         var _loc2_:DisplayObject = obf_a_f_2935.getMoneyDisplay(param1);
         _loc2_.x = -(_loc2_.width / 2);
         while(costPoint.numChildren > 0)
         {
            costPoint.removeChildAt(0);
         }
         costPoint.addChild(_loc2_);
      }
      
      private function obf_0_8_N_104(param1:int, param2:String, param3:String = "") : void
      {
         var _loc4_:ShopBuyEvent = new ShopBuyEvent(ShopBuyEvent.SHOP_BUY);
         _loc4_.itemCode = param2;
         _loc4_.buyType = param1;
         _loc4_.toPlayerId = param3;
         this.dispatchEvent(_loc4_);
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

