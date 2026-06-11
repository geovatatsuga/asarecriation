package com.sunweb.game.rpg.playerUI
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.DepotBagUIMC;
   
   public class DepotTwoBagUI extends DepotBagUIMC implements IWindow, IIconItemUI
   {
      
      private var bags:Array;
      
      private var _npcId:String;
      
      private var _funcMenuIndex:Array;
      
      private var pageButtons:Array;
      
      private var bagPageSize:int = 100;
      
      private var bagsPage:Array;
      
      private var bagsBox:Array;
      
      private var bagsTemp:Array;
      
      private var timeInv:TimeLimiter;
      
      private var bagSortTimeInv:TimeLimiter;
      
      public function DepotTwoBagUI()
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         this.bags = new Array();
         this.bagsPage = new Array();
         this.bagsBox = new Array();
         this.bagsTemp = new Array();
         this.timeInv = new TimeLimiter(300);
         super();
         this.initDiversity();
         this.x = 230;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         this.pageButtons = [this.cmdBagPage1,this.cmdBagPage2,this.cmdBagPage3];
         var _loc1_:int = 1;
         while(_loc1_ <= this.pageButtons.length)
         {
            _loc2_ = new Array();
            (this["bagPage" + _loc1_] as MovieClip).doubleClickEnabled = true;
            this.bagsBox.push(this["bagPage" + _loc1_] as MovieClip);
            _loc3_ = 0;
            while(_loc3_ < this.bagPageSize)
            {
               _loc4_ = this["bagPage" + _loc1_]["bag" + _loc3_];
               if(_loc4_ != null)
               {
                  if(_loc1_ >= 3 && _loc3_ > 49)
                  {
                     _loc4_.visible = false;
                  }
                  else
                  {
                     _loc5_ = new IconItemBag(_loc4_,this,(_loc1_ - 1) * this.bagPageSize + _loc3_);
                     _loc5_.isLocked = true;
                     _loc5_.addValidType(GameItemType.EQUIPMENT);
                     _loc2_.push(_loc5_);
                     this.bags.push(_loc5_);
                  }
               }
               _loc3_++;
            }
            this.bagsPage.push(_loc2_);
            _loc1_++;
         }
         this.setBagsPage(1);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSort.addEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         this.closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSort.removeEventListener(MouseEvent.CLICK,this.obf_a_z_1623);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
      }
      
      public function showDepotBag(param1:String, param2:Array) : void
      {
         this.x = 230;
         this.y = GameContext.gameStage.stageHeight / 2;
         this._npcId = param1;
         this._funcMenuIndex = param2;
         obf_K_e_3075.showUI(this);
         obf_K_e_3075.playerBagUI.x = this.x + 430;
         obf_K_e_3075.playerBagUI.y = this.y - 10;
         obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.timeInv.checkTimeout() && !obf_b_p_3604.checkNpcDistance(this._npcId,false))
         {
            obf_K_e_3075.closeUI(this);
         }
         if(IconItemManager.draging)
         {
            _loc2_ = 0;
            while(_loc2_ < this.pageButtons.length)
            {
               _loc3_ = this.pageButtons[_loc2_];
               if(Boolean(_loc3_) && _loc3_.getBounds(_loc3_).contains(_loc3_.mouseX,_loc3_.mouseY))
               {
                  this.setBagsPage(_loc2_ + 1);
                  break;
               }
               _loc2_++;
            }
         }
         if(Boolean(this.bagSortTimeInv) && this.bagSortTimeInv.checkTimeout())
         {
            cmdSort.enabled = true;
            this.bagSortTimeInv = null;
         }
      }
      
      private function onClose(param1:Event) : void
      {
         this._npcId = "";
         this._funcMenuIndex = null;
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_a_z_1623(param1:MouseEvent) : void
      {
         GameContext.bagItemManager.sendSortBag(PlayerBagIndex.obf_6_c_1642);
         cmdSort.enabled = false;
         this.bagSortTimeInv = new TimeLimiter(WorldConfig.obf_K_L_4278);
      }
      
      public function confirmDepotSort(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendSortBag(PlayerBagIndex.obf_6_c_1642);
            cmdSort.enabled = false;
            this.bagSortTimeInv = new TimeLimiter(WorldConfig.obf_K_L_4278);
         }
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         this.setBagsPage(this.pageButtons.indexOf(param1.currentTarget) + 1);
      }
      
      public function setBagsPage(param1:int) : void
      {
         var bagBox:MovieClip = null;
         var page:int = param1;
         page = Math.max(1,Math.min(this.pageButtons.length,page));
         var i:int = 0;
         while(i < this.pageButtons.length)
         {
            (this.pageButtons[i] as MovieClip).gotoAndStop(i + 1 == page ? 2 : 1);
            i++;
         }
         for each(bagBox in this.bagsBox)
         {
            try
            {
               this.removeChild(bagBox);
            }
            catch(e:Error)
            {
            }
         }
         this.addChild(this.bagsBox[page - 1]);
         this.bagsTemp = this.bagsPage[page - 1];
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onDragDown(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:SplitBoxUI = null;
         if(param1.isLocked)
         {
            ButtonToItemManager.useBTIById("addDepotTwoBag");
         }
         if(!param1 || !param1.haveIconItem)
         {
            return;
         }
         if(param2 && param1.haveIconItem.itemCount > 1)
         {
            _loc4_ = new SplitBoxUI(IconItemManager.startDrag,[param1],1,param1.haveIconItem.itemCount);
            WindowManager.showWindow(_loc4_);
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 == param3)
         {
            return;
         }
         if(param1.isLocked || !param3.haveIconItem)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param3.haveIconItem.itemCode);
         if(!_loc4_ || !JSONUtil.getBoolean(_loc4_,["canDepot"],true) || _loc4_.type != GameItemType.EQUIPMENT)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","contDepot"));
            return;
         }
         if(param3.parentIconUI == this)
         {
            if(GameContext.bagItemManager != null)
            {
               if(param2.itemCount < param3.haveIconItem.itemCount)
               {
                  GameContext.bagItemManager.sendSplitItem(PlayerBagIndex.obf_6_c_1642,param3.itemIndex,param1.itemIndex,param2.itemCount);
               }
               else
               {
                  GameContext.bagItemManager.sendItemMove(param3.itemIndex,param1.itemIndex,PlayerBagIndex.obf_6_c_1642);
               }
            }
         }
         else
         {
            if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
            {
               param2.destroy();
               return;
            }
            GameContext.bagItemManager.sendItemMoveCrossBag(PlayerBagIndex.PLAYER_MAIN_BAG,param3.itemIndex,PlayerBagIndex.obf_6_c_1642,param1.itemIndex,this._npcId,this._funcMenuIndex);
         }
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
         DiversityManager.setTextField(txtDeyTitle,"DepotUI","txtTwoTitle");
         cmdSort.label = DiversityManager.getString("MainBag","cmdSort");
         DiversityManager.setTextField(cmdBagPage1.txtLabel,"MainBag","cmdPage1",null,true);
         DiversityManager.setTextField(cmdBagPage2.txtLabel,"MainBag","cmdPage2",null,true);
         DiversityManager.setTextField(cmdBagPage3.txtLabel,"MainBag","cmdPage3",null,true);
      }
      
      public function get npcId() : String
      {
         return this._npcId;
      }
      
      public function get npcMenuIndex() : Array
      {
         return this._funcMenuIndex;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(obf_K_e_3075.playerBagUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
         }
      }
      
      public function closeUI() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
            if(this.contains(_loc1_))
            {
               this.removeChild(_loc1_);
            }
         }
         this.bags = null;
         this.bagsTemp = null;
         this.removeListener();
      }
   }
}

