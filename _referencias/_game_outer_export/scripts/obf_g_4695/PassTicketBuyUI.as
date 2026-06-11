package obf_g_4695
{
   import obf_9_H_3298.PassTicketManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PassTicketBuyUIMC;
   import playerUI.RMBIcon;
   
   public class PassTicketBuyUI extends PassTicketBuyUIMC implements IIconItemUI
   {
      
      public var middMoney:int;
      
      public var isMiddBuy:Boolean;
      
      public var highMoney:int;
      
      public var isHighBuy:Boolean;
      
      public var middConfig:Object;
      
      public var highConfig:Object;
      
      public var middItem:IconItemBag;
      
      public var highItem:IconItemBag;
      
      public function PassTicketBuyUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.middItem = new IconItemBag(this.iconMidd,this,0);
         this.middItem.lockDrag = true;
         this.middItem.addValidType(GameItemType.ALL);
         this.highItem = new IconItemBag(this.iconHigh,this,0);
         this.highItem.lockDrag = true;
         this.highItem.addValidType(GameItemType.ALL);
         this.addListener();
         this.middItem.visible = false;
         this.highItem.visible = false;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"passTicketBuyUI","txtTitle");
         cmdBuyMidd.label = DiversityManager.getString("passTicketBuyUI","cmdBuyMidd");
         cmdBuyHigh.label = DiversityManager.getString("passTicketBuyUI","cmdBuyHigh");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdBuyMidd.addEventListener(MouseEvent.CLICK,this.onCmdBuyMidd);
         cmdBuyHigh.addEventListener(MouseEvent.CLICK,this.obf_q_F_3199);
      }
      
      public function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdBuyMidd.removeEventListener(MouseEvent.CLICK,this.onCmdBuyMidd);
         cmdBuyHigh.removeEventListener(MouseEvent.CLICK,this.obf_q_F_3199);
      }
      
      public function refresh() : void
      {
         var _loc2_:String = null;
         var _loc3_:IconItem = null;
         var _loc4_:IconItem = null;
         var _loc5_:DisplayObject = null;
         txtMiddMoney.htmlText = this.middMoney + "";
         var _loc1_:int = this.highMoney;
         if(this.isMiddBuy && !this.isHighBuy)
         {
            _loc1_ -= this.middMoney;
         }
         txtHighMoney.htmlText = _loc1_ + "";
         this.middItem.dropIconItem();
         this.highItem.dropIconItem();
         if(this.middConfig)
         {
            for(_loc2_ in this.middConfig)
            {
               _loc3_ = IconItemManager.getIconItemByCode(_loc2_,"");
               _loc3_.itemCount = this.middConfig[_loc2_];
               this.middItem.pushIconItem(_loc3_);
            }
         }
         if(this.highConfig)
         {
            for(_loc2_ in this.highConfig)
            {
               _loc4_ = IconItemManager.getIconItemByCode(_loc2_,"");
               _loc4_.itemCount = this.highConfig[_loc2_];
               this.highItem.pushIconItem(_loc4_);
            }
         }
         if(this.isMiddBuy)
         {
            cmdBuyMidd.visible = false;
         }
         else
         {
            cmdBuyMidd.visible = true;
         }
         if(this.isHighBuy)
         {
            cmdBuyMidd.visible = false;
            cmdBuyHigh.visible = false;
         }
         else
         {
            cmdBuyHigh.visible = true;
         }
         if(obf_j_3_4375.numChildren <= 0)
         {
            _loc5_ = new RMBIcon();
            _loc5_.y = 5;
            obf_j_3_4375.addChild(_loc5_);
         }
         if(obf_8_2_3423.numChildren <= 0)
         {
            _loc5_ = new RMBIcon();
            _loc5_.y = 5;
            obf_8_2_3423.addChild(_loc5_);
         }
      }
      
      public function onCmdBuyMidd(param1:Event) : void
      {
         var _loc2_:String = null;
         if(this.middConfig)
         {
            for(_loc2_ in this.middConfig)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < this.middConfig[_loc2_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("passTicketBuyUI","noItem"));
                  return;
               }
            }
         }
         if(this.middMoney > 0)
         {
            if(GameContext.localPlayer.fullInfo.money < this.middMoney)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("passTicketBuyUI","noMoney"));
               return;
            }
         }
         PassTicketManager.sendPassTicketBuyRequest(1);
         obf_K_e_3075.closeUI(this);
      }
      
      public function obf_q_F_3199(param1:Event) : void
      {
         var _loc3_:String = null;
         if(this.highConfig)
         {
            for(_loc3_ in this.highConfig)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < this.highConfig[_loc3_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("passTicketBuyUI","noItem"));
                  return;
               }
            }
         }
         var _loc2_:int = this.highMoney;
         if(this.isMiddBuy && !this.isHighBuy)
         {
            _loc2_ -= this.middMoney;
         }
         else
         {
            txtHighMoney.htmlText = _loc2_ + "";
         }
         if(_loc2_ > 0)
         {
            if(GameContext.localPlayer.fullInfo.money < _loc2_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("passTicketBuyUI","noMoney"));
               return;
            }
         }
         PassTicketManager.sendPassTicketBuyRequest(2);
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
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
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         return [this.middItem,this.highItem];
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
   }
}

