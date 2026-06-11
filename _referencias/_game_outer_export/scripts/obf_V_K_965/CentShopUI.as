package obf_V_K_965
{
   import obf_O_e_3875.obf_0_4_5_176;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.CentShopUIMC;
   
   public class CentShopUI extends CentShopUIMC implements IIconItemUI
   {
      
      private var bags:Array = new Array();
      
      public function CentShopUI()
      {
         super();
         this.initDiversity();
         this.onResize(null);
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.showCentShop(obf_0_4_5_176.christmasConfig.shop);
         this.addListener();
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         scrollItem.addEventListener(ScrollEvent.SCROLL,this.onScrollItem);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         scrollItem.removeEventListener(ScrollEvent.SCROLL,this.onScrollItem);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = this.width / 2 + 30;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onScrollItem(param1:ScrollEvent) : void
      {
         pointItem.scrollRect = new Rectangle(0,param1.position,scrollItem.x - pointItem.x,scrollItem.height);
      }
      
      public function showCentShop(param1:Array) : void
      {
         var _loc6_:IconItem = null;
         var _loc7_:obf_i_D_2711 = null;
         while(pointItem.numChildren > 0)
         {
            pointItem.removeChildAt(0);
         }
         if(param1.length == 0)
         {
            return;
         }
         pointItem.scrollRect = new Rectangle(0,0,scrollItem.x - pointItem.x,scrollItem.height);
         scrollItem.pageSize = scrollItem.height;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = IconItemManager.getIconItemByCode(param1[_loc5_].itemCode,"");
            if(_loc6_)
            {
               _loc7_ = new obf_i_D_2711(this);
               _loc7_.setPrice(param1[_loc5_].value);
               _loc7_.iconBag.pushIconItem(_loc6_);
               this.bags.push(_loc7_.iconBag);
               if(++_loc2_ > 1)
               {
                  _loc2_ = 0;
                  _loc3_ += _loc7_.height + 20;
               }
               _loc7_.x = (_loc7_.width + 30) * _loc2_;
               _loc7_.y = _loc3_;
               _loc4_ = _loc7_.y + _loc7_.height;
               pointItem.addChild(_loc7_);
            }
            _loc5_++;
         }
         if(_loc4_ > scrollItem.height)
         {
            scrollItem.maxScrollPosition = _loc4_ - scrollItem.height;
            scrollItem.visible = true;
         }
         else
         {
            scrollItem.maxScrollPosition = 0;
            scrollItem.visible = false;
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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
      
      public function initDiversity() : void
      {
         txtDeyTitle.mouseEnabled = false;
         txtDeyTitle.text = DiversityManager.getString("ChristmasUI","txtShopTitle");
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
         this.removeListener();
      }
   }
}

