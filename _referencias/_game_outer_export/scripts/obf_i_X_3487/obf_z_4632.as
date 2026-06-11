package obf_I_x_2551
{
   import obf_D_Y_975.obf_7_q_3477;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.pocketItemUIMC;
   
   public class obf_z_4632 extends pocketItemUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _lockItems:Array;
      
      private var _bags:Array;
      
      private var _page:int = 1;
      
      private var playerItems:Object;
      
      public function obf_z_4632()
      {
         var _loc2_:obf_c_q_4356 = null;
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this._lockItems = new Array();
         this._bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = new obf_c_q_4356(this,this["lockItem" + _loc1_],_loc1_);
            this._lockItems.push(_loc2_);
            this._bags.push(_loc2_.bag);
            _loc1_++;
         }
         this.addListener();
         this.cmdRefinery.visible = false;
      }
      
      public function get items() : Object
      {
         return this.playerItems;
      }
      
      public function setItems(param1:Object) : void
      {
         this.playerItems = param1;
         this.refreshItem();
         this.obf_x_j_3753();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"pocketItemUI","txtTitle");
         txtInfo.htmlText = "<a HREF=\'event:#\'>" + DiversityManager.getString("pocketSlotUI","txtInfo") + "</a>";
         DiversityManager.setTextField(txtAllAttr,"pocketItemUI","txtAllAttr");
         cmdPre.label = DiversityManager.getString("pocketItemUI","cmdPre");
         cmdNext.label = DiversityManager.getString("pocketItemUI","cmdNext");
         cmdRefinery.label = DiversityManager.getString("pocketItemUI","cmdRefinery");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPre.addEventListener(MouseEvent.CLICK,this.obf_H_a_807);
         cmdNext.addEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         cmdRefinery.addEventListener(MouseEvent.CLICK,this.obf_4_U_3086);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"Pocket_TxtInfo");
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPre.removeEventListener(MouseEvent.CLICK,this.obf_H_a_807);
         cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         cmdRefinery.removeEventListener(MouseEvent.CLICK,this.obf_4_U_3086);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
      }
      
      public function refreshItem() : void
      {
         var _loc3_:obf_c_q_4356 = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc3_ = this._lockItems[_loc1_];
            _loc3_.clearItem();
            _loc4_ = obf_7_q_3477.lockItems;
            _loc5_ = _loc4_[(this._page - 1) * 8 + _loc1_];
            if(_loc5_)
            {
               if(this.items)
               {
                  _loc6_ = int(this.items[_loc5_.itemCode]);
                  _loc3_.setItem(GameItemManager.getItemConfig(_loc5_.itemCode),_loc6_,this.isOpen(_loc5_));
               }
               else
               {
                  _loc3_.setItem(GameItemManager.getItemConfig(_loc5_.itemCode),0,this.isOpen(_loc5_));
               }
            }
            _loc1_++;
         }
         var _loc2_:int = (obf_7_q_3477.lockItems.length - 1) / 8 + 1;
         DiversityManager.setTextField(txtPage,"pocketItemUI","txtPage",[this._page + "",_loc2_ + ""]);
      }
      
      public function obf_x_j_3753() : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this["txtAttrName" + _loc1_].text = "";
            this["txtAttrValue" + _loc1_].text = "";
            _loc1_++;
         }
         var _loc2_:Object = new Object();
         for(_loc3_ in this.items)
         {
            _loc7_ = int(this.items[_loc3_]);
            if(_loc7_ > 0)
            {
               _loc8_ = obf_7_q_3477.getLockItemConfig(_loc3_);
               for(_loc9_ in _loc8_.attr)
               {
                  _loc10_ = int(_loc2_[_loc9_]);
                  if(!_loc10_)
                  {
                     _loc10_ = 0;
                  }
                  _loc11_ = int(_loc8_.attr[_loc9_]);
                  _loc10_ = _loc11_ * _loc7_ + _loc10_;
                  _loc2_[_loc9_] = _loc10_;
               }
            }
         }
         _loc4_ = new Array();
         for(_loc5_ in _loc2_)
         {
            _loc4_.push(int(_loc5_));
         }
         _loc4_.sort();
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            if(_loc6_ > _loc4_.length)
            {
               return;
            }
            this["txtAttrName" + _loc6_].text = RoleAttributesModifierEnum.getAttributesName(_loc4_[_loc6_]);
            this["txtAttrValue" + _loc6_].text = _loc2_[_loc4_[_loc6_] + ""];
            _loc6_++;
         }
      }
      
      public function isOpen(param1:Object) : Boolean
      {
         var _loc2_:int = obf_K_e_3075.pocketSlotUI.stoneLoopLevel;
         if(param1.needLv > _loc2_)
         {
            return false;
         }
         return true;
      }
      
      public function obf_H_a_807(param1:Event) : void
      {
         if(this._page <= 1)
         {
            return;
         }
         --this._page;
         this.refreshItem();
      }
      
      public function obf_j_l_1190(param1:Event) : void
      {
         var _loc2_:int = int(obf_7_q_3477.lockItems.length);
         if(this._page > (_loc2_ - 1) / 8)
         {
            return;
         }
         this._page += 1;
         this.refreshItem();
      }
      
      public function obf_4_U_3086(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = obf_7_q_3477.refineryNeedNum;
         for(_loc3_ in this.items)
         {
            if(this.items[_loc3_] >= _loc2_)
            {
               obf_7_q_3477.obf_i_z_4130();
               return;
            }
         }
         WindowManager.showMessageBox(DiversityManager.getString("pocketItemUI","noItem"));
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
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         if(!this.playerItems)
         {
            this.refreshItem();
         }
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
         this.removeListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
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

