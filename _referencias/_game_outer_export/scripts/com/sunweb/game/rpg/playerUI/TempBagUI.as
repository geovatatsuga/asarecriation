package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TempBagUIMC;
   
   public class TempBagUI extends TempBagUIMC implements IWindow, IIconItemUI
   {
      
      private var bags:Array;
      
      private var autoGetAllItems:Boolean;
      
      private var autoGetAllTimeInv:TimeLimiter;
      
      public function TempBagUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.bags = new Array();
         this.autoGetAllTimeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.x = 230;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         var _loc1_:int = 0;
         while(_loc1_ < 100)
         {
            _loc2_ = this["bag" + _loc1_];
            if(_loc2_ != null)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.isLocked = true;
               _loc3_.addValidType(GameItemType.ALL);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TempBagUI","txtTitle");
         DiversityManager.setTextField(txtDeyPrompt,"TempBagUI","txtPrompt");
         cmdGetAll.label = DiversityManager.getString("TempBagUI","cmdGetAll");
      }
      
      private function addListener() : void
      {
         this.bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdGetAll.addEventListener(MouseEvent.CLICK,this.obf_P_u_1934);
      }
      
      private function removeListener() : void
      {
         this.bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdGetAll.removeEventListener(MouseEvent.CLICK,this.obf_P_u_1934);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onDragDown(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_P_u_1934(param1:Event) : void
      {
         this.autoGetAllItems = true;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.bags)
         {
            if(!_loc3_.isLocked)
            {
               if(_loc3_.haveIconItem == null)
               {
                  if(++_loc2_ >= param1)
                  {
                     return true;
                  }
               }
            }
         }
         return _loc2_ >= param1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:IconItemBag = null;
         if(this.autoGetAllTimeInv.checkTimeout() && this.autoGetAllItems)
         {
            this.autoGetAllItems = false;
            for each(_loc2_ in this.bags)
            {
               if(_loc2_.haveIconItem)
               {
                  this.autoGetAllItems = true;
                  this.getItemToPlayerBag(_loc2_);
                  break;
               }
            }
         }
      }
      
      public function getItemToPlayerBag(param1:IconItemBag) : void
      {
         var _loc6_:IconItemBag = null;
         if(!param1 || !param1.haveIconItem)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.haveIconItem.itemCode);
         var _loc3_:Array = obf_K_e_3075.playerBagUI.getAllBags();
         var _loc4_:int = PlayerBagIndex.PLAYER_MAIN_BAG;
         if(GameItemType.contrastType(_loc2_.type,GameItemType.PET))
         {
            _loc4_ = PlayerBagIndex.PLAYER_PET_BAG;
            _loc3_ = obf_K_e_3075.petBoxUI.getIconItemBags();
         }
         else if(GameItemType.contrastType(_loc2_.type,GameItemType.RIDE))
         {
            _loc4_ = PlayerBagIndex.PLAYER_RIDE_BAG;
            _loc3_ = obf_K_e_3075.rideBoxUI.getIconItemBags();
         }
         else if(GameItemType.contrastType(_loc2_.type,GameItemType.obf_N_v_4048))
         {
            _loc4_ = PlayerBagIndex.obf_5_R_2566;
            _loc3_ = obf_K_e_3075.genieBoxUI.getIconItemBags();
         }
         else if(GameItemType.contrastType(_loc2_.type,GameItemType.obf_y_n_2092))
         {
            _loc4_ = PlayerBagIndex.obf_w_y_3760;
            _loc3_ = obf_K_e_3075.playerDevilUI.getIconItemBags();
         }
         var _loc5_:int = -1;
         for each(_loc6_ in _loc3_)
         {
            if(!_loc6_.isLocked && !_loc6_.haveIconItem)
            {
               _loc5_ = _loc6_.itemIndex;
               break;
            }
         }
         if(_loc5_ < 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","nomoreEmptyBag"));
            this.autoGetAllItems = false;
            return;
         }
         GameContext.bagItemManager.sendItemMoveCrossBag(PlayerBagIndex.obf_S_A_4615,param1.itemIndex,_loc4_,_loc5_,"",[]);
      }
      
      public function obf_2_o_2324() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this.bags)
         {
            if(_loc2_.haveIconItem)
            {
               _loc1_ = true;
               break;
            }
         }
         obf_K_e_3075.playerBagUI.tempBagButtonPrompt.visible = _loc1_;
         obf_K_e_3075.drgTreasureUI.tempBagButtonPrompt.visible = _loc1_;
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
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
            if(this.contains(_loc1_))
            {
               this.removeChild(_loc1_);
            }
         }
         this.bags = null;
         this.removeListener();
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
         this.getItemToPlayerBag(param1);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param3 == obf_K_e_3075.playerBagUI)
         {
            this.getItemToPlayerBag(param1);
         }
      }
   }
}

