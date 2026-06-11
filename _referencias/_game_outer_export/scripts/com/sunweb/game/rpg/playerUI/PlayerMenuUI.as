package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.MenuBoxUIMC;
   
   public class PlayerMenuUI extends MenuBoxUIMC implements IWindow
   {
      
      private static var menus:Object = new Object();
      
      private var items:Object = new Object();
      
      private var itemList:Array = new Array();
      
      private var newItemRootPoint:Point = new Point();
      
      private var obf_0___c_399:uint;
      
      public function PlayerMenuUI(param1:String, param2:uint = 100)
      {
         super();
         this.obf_0___c_399 = param2;
         bgBox.width = param2;
         bgBox.height = rootPoint.y;
         this.newItemRootPoint.x = rootPoint.x;
         this.newItemRootPoint.y = rootPoint.y;
         this.addListener();
         if(menus[param1] is PlayerMenuUI)
         {
            closeMenuById(param1);
         }
         menus[param1] = this;
      }
      
      public static function closeMenuById(param1:String) : void
      {
         var _loc2_:PlayerMenuUI = menus[param1];
         if(_loc2_)
         {
            WindowManager.closeWindow(_loc2_);
            delete menus[param1];
         }
      }
      
      public static function closeAllMenu() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:PlayerMenuUI = null;
         for(_loc1_ in menus)
         {
            _loc2_ = menus[_loc1_];
            WindowManager.closeWindow(_loc2_);
            delete menus[_loc1_];
         }
      }
      
      public static function showMenu(param1:PlayerMenuUI, param2:int, param3:int) : void
      {
         param1.x = param2;
         param1.y = param3;
         if(param1.x < 5)
         {
            param1.x = 5;
         }
         if(param1.y < 5)
         {
            param1.y = 5;
         }
         if(param1.x > GameContext.gameStage.stageWidth - param1.width + 5)
         {
            param1.x -= param1.width;
         }
         if(param1.y > GameContext.gameStage.stageHeight - param1.height + 5)
         {
            param1.y -= param1.height;
         }
         WindowManager.showWindow(param1);
      }
      
      public function get obf_0_0_a_217() : int
      {
         return this.itemList.length;
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.clickMenu);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.clickMenu);
      }
      
      private function clickMenu(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:PlayerMenuItem = null;
         var _loc4_:Rectangle = null;
         for(_loc2_ in this.items)
         {
            _loc3_ = this.items[_loc2_];
            if(_loc3_.itemEnabled)
            {
               _loc4_ = _loc3_.getRect(this);
               if(_loc4_.contains(this.mouseX,this.mouseY))
               {
                  _loc3_.doAction();
                  break;
               }
            }
         }
         WindowManager.closeWindow(this);
      }
      
      public function addMenuItem(param1:PlayerMenuItem, param2:String) : void
      {
         param1.x = this.newItemRootPoint.x;
         param1.y = this.newItemRootPoint.y;
         param1.width = this.obf_0___c_399;
         bgBox.height = this.newItemRootPoint.y + rootPoint.y + param1.height;
         this.newItemRootPoint.y += param1.height;
         this.addChild(param1);
         this.items[param2] = param1;
         this.itemList.push(param1);
      }
      
      public function addMenuItemByObject(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:PlayerMenuItem = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.value;
            if(_loc3_.hasOwnProperty("label") && _loc3_.hasOwnProperty("fun") && _loc3_.hasOwnProperty("par"))
            {
               _loc4_ = new PlayerMenuItem(_loc3_.label,_loc3_.fun,_loc3_.par);
               this.addMenuItem(_loc4_,_loc2_.id);
            }
         }
      }
      
      public function clearMenuItem() : void
      {
         var _loc1_:* = undefined;
         bgBox.height = rootPoint.y;
         for(_loc1_ in this.items)
         {
            this.items[_loc1_].destroy();
            delete this.items[_loc1_];
         }
      }
      
      public function getMenuItem(param1:String) : PlayerMenuItem
      {
         if(this.items[param1] != null && this.items[param1] is PlayerMenuItem)
         {
            return this.items[param1];
         }
         return null;
      }
      
      public function getMenuItemByIndex(param1:int) : PlayerMenuItem
      {
         return JSONUtil.getObject(this.itemList,[param1]) as PlayerMenuItem;
      }
      
      public function destroy() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.items)
         {
            this.items[_loc1_].destroy();
         }
         this.items = null;
         this.removeListener();
      }
   }
}

