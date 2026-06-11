package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IconItemManager
   {
      
      private static var _uiSprite:Sprite;
      
      public static var mouseDown:Boolean;
      
      private static var mouseDownPoint:Point;
      
      private static var obf_z_0_1937:IconItemBag;
      
      private static var mouseMoveInv:TimeLimiter;
      
      private static var showTip:Boolean;
      
      private static var showTipPoint:Point;
      
      private static var isDraging:Boolean;
      
      private static var fromIconItemBag:IconItemBag;
      
      private static var dragingIconItem:IconItem;
      
      private static var showTipInv:TimeLimiter = new TimeLimiter(100);
      
      public function IconItemManager()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         if(_uiSprite)
         {
            removeListener();
         }
         _uiSprite = param1;
         _uiSprite.doubleClickEnabled = true;
         if(_uiSprite.stage)
         {
            addListener(null);
         }
         else
         {
            _uiSprite.addEventListener(Event.ADDED_TO_STAGE,addListener);
         }
      }
      
      private static function addListener(param1:Event) : void
      {
         if(!_uiSprite)
         {
            return;
         }
         _uiSprite.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
         _uiSprite.parent.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
         _uiSprite.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         _uiSprite.addEventListener(MouseEvent.CLICK,onMouseClick);
         _uiSprite.addEventListener(MouseEvent.DOUBLE_CLICK,onMouseDbClick);
      }
      
      private static function removeListener() : void
      {
         if(!_uiSprite)
         {
            return;
         }
         _uiSprite.removeEventListener(Event.ADDED_TO_STAGE,addListener);
         _uiSprite.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
         _uiSprite.parent.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
         _uiSprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
         _uiSprite.removeEventListener(MouseEvent.CLICK,onMouseClick);
         _uiSprite.removeEventListener(MouseEvent.DOUBLE_CLICK,onMouseDbClick);
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Point = null;
         if(Boolean(mouseDown) && Boolean(mouseMoveInv) && mouseMoveInv.checkTimeout())
         {
            mouseMoveInv = null;
            if(Boolean(obf_z_0_1937) && !obf_z_0_1937.lockDrag)
            {
               startDrag(obf_z_0_1937);
            }
         }
         if(showTipInv.checkTimeout())
         {
            _loc2_ = new Point(_uiSprite.mouseX,_uiSprite.mouseY);
            if(Boolean(!showTip) && Boolean(showTipPoint) && showTipPoint.equals(_loc2_))
            {
               showTip = showMouseTip();
            }
            else if(Boolean(showTipPoint) && Point.distance(showTipPoint,_loc2_) > 10)
            {
               GameTipManager.closeTip("Items");
               GameTipManager.closeTip("equipSuit");
               GameTipManager.closeTip("equipContrast");
               GameTipManager.closeTip("wingSpirit");
               showTip = false;
            }
            showTipPoint = _loc2_;
         }
      }
      
      public static function get uiSprite() : Sprite
      {
         return _uiSprite;
      }
      
      public static function get draging() : Boolean
      {
         return isDraging;
      }
      
      public static function showMouseTip() : Boolean
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:IIconItemUI = obf_K_e_3075.getUIModuleUnderPoint(_uiSprite.mouseX,_uiSprite.mouseY) as IIconItemUI;
         if(_loc1_)
         {
            _loc2_ = getIconItemBagUnderPointFormBags(_loc1_.getIconItemBags(),_uiSprite.mouseX,_uiSprite.mouseY);
            if(_loc2_)
            {
               _loc2_.showIconItemTip();
               return true;
            }
         }
         return false;
      }
      
      private static function onMouseDown(param1:MouseEvent) : void
      {
         mouseDown = true;
         mouseDownPoint = new Point(_uiSprite.mouseX,_uiSprite.mouseY);
         var _loc2_:IIconItemUI = obf_K_e_3075.getUIModuleUnderPoint(_uiSprite.mouseX,_uiSprite.mouseY) as IIconItemUI;
         if(_loc2_)
         {
            obf_z_0_1937 = getIconItemBagUnderPointFormBags(_loc2_.getIconItemBags(),_uiSprite.mouseX,_uiSprite.mouseY);
         }
         mouseMoveInv = new TimeLimiter(200);
      }
      
      private static function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IIconItemUI = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:IIconItemUI = null;
         mouseDown = false;
         obf_z_0_1937 = null;
         mouseMoveInv = null;
         if(isDraging && Boolean(dragingIconItem))
         {
            _loc2_ = param1.stageX;
            _loc3_ = param1.stageY;
            dragingIconItem.stopDrag();
            if(Boolean(dragingIconItem) && _uiSprite.contains(dragingIconItem))
            {
               _uiSprite.removeChild(dragingIconItem);
            }
            _loc4_ = obf_K_e_3075.getUIModuleUnderPoint(_loc2_,_loc3_) as IIconItemUI;
            if(_loc4_)
            {
               _loc5_ = getIconItemBagUnderPointFormBags(_loc4_.getIconItemBags(),_loc2_,_loc3_);
               if(_loc5_ != fromIconItemBag)
               {
                  _loc6_ = _loc4_;
                  if(Boolean(_loc5_) && Boolean(_loc5_.parentIconUI))
                  {
                     _loc6_ = _loc5_.parentIconUI;
                  }
                  _loc6_.onDragInIconItem(_loc5_,dragingIconItem.clone(),fromIconItemBag);
               }
            }
            if(fromIconItemBag != null)
            {
               fromIconItemBag.parentIconUI.onDragOutIconItem(fromIconItemBag,_loc5_,_loc4_);
            }
            dragingIconItem.destroy();
         }
         isDraging = false;
         fromIconItemBag = null;
         dragingIconItem = null;
      }
      
      private static function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:IIconItemUI = null;
         var _loc3_:Array = null;
         var _loc4_:IconItemBag = null;
         if(!isDraging)
         {
            _loc2_ = obf_K_e_3075.getUIModuleUnderPoint(_uiSprite.mouseX,_uiSprite.mouseY) as IIconItemUI;
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = _loc2_.getIconItemBags();
            _loc4_ = getIconItemBagUnderPointFormBags(_loc3_,_uiSprite.mouseX,_uiSprite.mouseY);
            if(_loc4_)
            {
               _loc4_.parentIconUI.clickIconItemBag(_loc4_,param1.shiftKey,param1.ctrlKey);
            }
         }
      }
      
      private static function onMouseDbClick(param1:MouseEvent) : void
      {
         var _loc2_:IIconItemUI = null;
         var _loc3_:Array = null;
         var _loc4_:IconItemBag = null;
         if(!isDraging)
         {
            _loc2_ = obf_K_e_3075.getUIModuleUnderPoint(_uiSprite.mouseX,_uiSprite.mouseY) as IIconItemUI;
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = _loc2_.getIconItemBags();
            _loc4_ = getIconItemBagUnderPointFormBags(_loc3_,_uiSprite.mouseX,_uiSprite.mouseY);
            if(_loc4_)
            {
               _loc4_.parentIconUI.dbclickIconItemBag(_loc4_);
            }
         }
      }
      
      public static function getIconItemBagUnderPointFormBags(param1:Array, param2:int, param3:int) : IconItemBag
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:Point = null;
         var _loc6_:Rectangle = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:Point = null;
         var _loc9_:Rectangle = null;
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               _loc5_ = _loc4_.localToGlobal(new Point());
               _loc6_ = new Rectangle(_loc5_.x,_loc5_.y,32,32);
               if(_loc6_.contains(param2,param3))
               {
                  _loc7_ = _loc4_.parent;
                  while(_loc7_)
                  {
                     if(_loc7_ == GameContext.gameStage)
                     {
                        return _loc4_;
                     }
                     if(Boolean(_loc7_) && Boolean(_loc7_.scrollRect))
                     {
                        _loc8_ = _loc7_.localToGlobal(new Point(_loc7_.scrollRect.x,_loc7_.scrollRect.y));
                        _loc9_ = new Rectangle(_loc8_.x,_loc8_.y,_loc7_.scrollRect.width,_loc7_.scrollRect.height);
                        if(_loc9_.intersects(_loc6_))
                        {
                           return _loc4_;
                        }
                        break;
                     }
                     _loc7_ = _loc7_.parent;
                  }
               }
            }
         }
         return null;
      }
      
      public static function startDrag(param1:IconItemBag, param2:int = 0) : void
      {
         if(!param1 || !param1.haveIconItem || param1.isLocked)
         {
            return;
         }
         if(dragingIconItem != null && _uiSprite.contains(dragingIconItem))
         {
            _uiSprite.removeChild(dragingIconItem);
            dragingIconItem.destroy();
         }
         isDraging = true;
         fromIconItemBag = param1;
         dragingIconItem = param1.haveIconItem.clone();
         if(param2 <= 0 || param2 > param1.haveIconItem.itemCount)
         {
            param2 = param1.haveIconItem.itemCount;
         }
         dragingIconItem.itemCount = param2;
         dragingIconItem.x = _uiSprite.stage.mouseX - 16;
         dragingIconItem.y = _uiSprite.stage.mouseY - 16;
         _uiSprite.addChild(dragingIconItem);
         dragingIconItem.startDrag();
         fromIconItemBag = param1;
      }
      
      public static function getIconItemByCode(param1:String, param2:String) : IconItem
      {
         var _loc3_:IconItem = null;
         var _loc4_:Object = GameItemManager.getItemConfig(param1);
         if(_loc4_)
         {
            if(_loc4_.type == GameItemType.EXPENDABLE)
            {
               if(_loc4_.subtype == GameItemSubtype.EXPENDABLE_FARM_SEED)
               {
                  _loc3_ = IconItemFarm.getNewIconItem(param1,param2,IconItemFarm.FARM_SEED);
               }
               else if(_loc4_.subtype == GameItemSubtype.EXPENDABLE_FARM_BUILDING)
               {
                  _loc3_ = IconItemFarm.getNewIconItem(param1,param2,IconItemFarm.FARM_BUILDING);
               }
               else
               {
                  _loc3_ = IconItemExpendable.getNewIconItem(param1,param2);
               }
            }
            else if(_loc4_.type == GameItemType.COLLECTION)
            {
               _loc3_ = IconItemCollection.getNewIconItem(param1,param2);
            }
            else if(_loc4_.type == GameItemType.EQUIPMENT)
            {
               _loc3_ = IconItemEquip.getNewIconItem(param1,param2);
            }
            else if(_loc4_.type == GameItemType.RIDE)
            {
               _loc3_ = IconItemRide.getNewIconItem(param1,param2);
            }
            else if(_loc4_.type == GameItemType.PET)
            {
               _loc3_ = obf_U_N_1827.getNewIconItem(param1,param2);
            }
            else if(_loc4_.type == GameItemType.obf_N_v_4048)
            {
               _loc3_ = obf_l_3_3784.getNewIconItem(param1,param2);
            }
            else if(_loc4_.type == GameItemType.obf_y_n_2092)
            {
               _loc3_ = obf_n_m_2273.getNewIconItem(param1,param2);
            }
         }
         return _loc3_;
      }
      
      public static function destroy() : void
      {
         removeListener();
         _uiSprite = null;
         mouseDownPoint = null;
         obf_z_0_1937 = null;
         dragingIconItem = null;
         fromIconItemBag = null;
      }
   }
}

