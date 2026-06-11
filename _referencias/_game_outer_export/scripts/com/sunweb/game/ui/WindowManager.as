package com.sunweb.game.ui
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.module.ConfirmBoxModule;
   import com.sunweb.game.rpg.module.InfoBox;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.module.MessageBoxModule;
   import com.sunweb.game.rpg.module.ProgressBoxModule;
   import com.sunweb.game.rpg.module.obf_A_J_934;
   import com.sunweb.game.rpg.playerUI.dragon.obf_j_f_929;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   
   public class WindowManager
   {
      
      private static var _windowSprite:Sprite;
      
      private static var _root:DisplayObjectContainer = null;
      
      private static var _normalWindows:Array = new Array();
      
      private static var _floatWindows:Array = new Array();
      
      private static var _modalWindows:Array = new Array();
      
      public function WindowManager()
      {
         super();
      }
      
      public static function initialize(param1:DisplayObjectContainer) : void
      {
         if(param1 == null)
         {
            throw new Error("WindowManager initialize failed!");
         }
         _root = param1;
         _windowSprite = new Sprite();
         _root.addChild(_windowSprite);
      }
      
      public static function get root() : DisplayObjectContainer
      {
         return _root;
      }
      
      public static function destroyWindow() : void
      {
         var _loc1_:IWindow = null;
         var _loc2_:Object = null;
         for each(_loc1_ in _normalWindows)
         {
            _loc1_.destroy();
            _windowSprite.removeChild(_loc1_ as DisplayObject);
         }
         _normalWindows = new Array();
         for each(_loc2_ in _modalWindows)
         {
            _root.removeChild(_loc2_.win);
            _loc2_.fun = null;
            _root.removeChild(_loc2_.sprite);
         }
         _modalWindows = new Array();
      }
      
      public static function showWindow(param1:IWindow) : void
      {
         if(!param1)
         {
            return;
         }
         _windowSprite.addChild(param1 as DisplayObject);
         _normalWindows.push(param1);
      }
      
      public static function showModalWindow(param1:IModalWindow, param2:Function = null, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:Rectangle = null;
         if(!param1)
         {
            throw new Error("ShowModalWindow can\'t be null!");
         }
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(16777215,0);
         _loc5_.graphics.drawRect(0,0,_root.stage.width,_root.stage.height);
         _loc5_.graphics.endFill();
         addBreakEvent();
         _root.addChild(_loc5_);
         var _loc6_:Object = new Object();
         _loc6_.win = param1;
         _loc6_.fun = param2;
         _loc6_.sprite = _loc5_;
         _modalWindows.push(_loc6_);
         if(param3)
         {
            _loc7_ = param1 as DisplayObject;
            _loc8_ = _loc7_.getRect(_loc7_);
            _loc7_.x = _root.stage.stageWidth / 2 - _loc8_.width / 2 - _loc8_.x;
            _loc7_.y = _root.stage.stageHeight / 2 - _loc8_.height / 2 - _loc8_.y;
         }
         else if(param4)
         {
            _loc7_ = param1 as DisplayObject;
            _loc7_.x = _root.stage.stageWidth / 2;
            _loc7_.y = _root.stage.stageHeight / 2;
         }
         _root.addChild(param1 as DisplayObject);
      }
      
      private static function addBreakEvent() : void
      {
         _root.addEventListener(KeyboardEvent.KEY_DOWN,breakModalEvent,true);
         _root.addEventListener(KeyboardEvent.KEY_UP,breakModalEvent,true);
         _root.addEventListener(TextEvent.TEXT_INPUT,breakModalEvent,true);
         _root.addEventListener(FocusEvent.FOCUS_IN,breakModalEvent,true);
         _root.addEventListener(FocusEvent.FOCUS_OUT,breakModalEvent,true);
         _root.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,breakModalEvent,true);
         _root.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,breakModalEvent,true);
         _root.addEventListener(MouseEvent.CLICK,breakModalEvent,true);
         _root.addEventListener(MouseEvent.DOUBLE_CLICK,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_DOWN,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_UP,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_OVER,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_OUT,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_MOVE,breakModalEvent,true);
         _root.addEventListener(MouseEvent.MOUSE_WHEEL,breakModalEvent,true);
         _root.addEventListener(MouseEvent.ROLL_OUT,breakModalEvent,true);
         _root.addEventListener(MouseEvent.ROLL_OVER,breakModalEvent,true);
      }
      
      private static function removeBreakEvent() : void
      {
         _root.removeEventListener(KeyboardEvent.KEY_DOWN,breakModalEvent,true);
         _root.removeEventListener(KeyboardEvent.KEY_UP,breakModalEvent,true);
         _root.removeEventListener(TextEvent.TEXT_INPUT,breakModalEvent,true);
         _root.removeEventListener(FocusEvent.FOCUS_IN,breakModalEvent,true);
         _root.removeEventListener(FocusEvent.FOCUS_OUT,breakModalEvent,true);
         _root.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,breakModalEvent,true);
         _root.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.CLICK,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.DOUBLE_CLICK,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_DOWN,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_UP,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_OVER,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_OUT,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_MOVE,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.MOUSE_WHEEL,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.ROLL_OUT,breakModalEvent,true);
         _root.removeEventListener(MouseEvent.ROLL_OVER,breakModalEvent,true);
      }
      
      private static function breakModalEvent(param1:Event) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         if(_modalWindows.length > 0)
         {
            _loc2_ = _modalWindows[_modalWindows.length - 1].win;
            if(_loc2_.contains(param1.target as DisplayObject))
            {
               return;
            }
         }
         param1.preventDefault();
      }
      
      public static function showFloatingWindow(param1:IFloatingWindow) : void
      {
      }
      
      public static function replaceWindow() : void
      {
      }
      
      public static function closeWindow(param1:IWindow) : void
      {
         var idx:int;
         var mObj:Object = null;
         var thisWinIndex:int = 0;
         var win:IWindow = param1;
         if(!win)
         {
            return;
         }
         idx = _normalWindows.indexOf(win);
         if(idx > -1)
         {
            win.destroy();
            if(_windowSprite.contains(win as DisplayObject))
            {
               _windowSprite.removeChild(win as DisplayObject);
            }
            _normalWindows.splice(idx,1);
         }
         if(_modalWindows.length > 0)
         {
            mObj = _modalWindows[_modalWindows.length - 1];
            thisWinIndex = _modalWindows.length - 1;
            if(mObj.win == win)
            {
               _root.removeChild(win as DisplayObject);
               _root.removeChild(mObj.sprite);
               if(mObj.fun)
               {
                  try
                  {
                     mObj.fun(mObj.win.returnValue);
                  }
                  catch(e:Error)
                  {
                     trace(e);
                  }
               }
               IModalWindow(win).destroy();
               _modalWindows.splice(thisWinIndex,1);
               if(_modalWindows.length == 0)
               {
                  removeBreakEvent();
               }
            }
         }
         if(_root.stage.focus == null || _root.stage.focus.root == null)
         {
            _root.stage.focus = _root.stage;
         }
      }
      
      public static function closeAllModalWindow() : void
      {
         var i:int;
         var mObj:Object = null;
         if(!_modalWindows || _modalWindows.length <= 0)
         {
            return;
         }
         i = _modalWindows.length - 1;
         while(i >= 0)
         {
            mObj = _modalWindows[i];
            _root.removeChild(mObj.win as DisplayObject);
            _root.removeChild(mObj.sprite);
            if(mObj.fun)
            {
               try
               {
                  mObj.fun(mObj.win.returnValue);
               }
               catch(e:Error)
               {
                  trace(e);
               }
            }
            IModalWindow(mObj.win).destroy();
            i--;
         }
         removeBreakEvent();
         _modalWindows = new Array();
      }
      
      public static function getModalWindowByName(param1:String) : DisplayObject
      {
         var _loc2_:Object = null;
         if(param1 == "")
         {
            return null;
         }
         for each(_loc2_ in _modalWindows)
         {
            if(_loc2_.win.name == param1)
            {
               return _loc2_.win;
            }
         }
         return null;
      }
      
      public static function showMessageBox(param1:String, param2:Function = null, param3:String = "", param4:Boolean = false) : MessageBoxModule
      {
         var _loc5_:MessageBoxModule = new MessageBoxModule(param1,param4);
         var _loc6_:MessageBoxModule = getModalWindowByName(param3) as MessageBoxModule;
         closeWindow(_loc6_);
         _loc5_.name = param3;
         WindowManager.showModalWindow(_loc5_,param2,true);
         return _loc5_;
      }
      
      public static function showProgressBox(param1:Array, param2:String = "") : ProgressBoxModule
      {
         var _loc3_:ProgressBoxModule = new ProgressBoxModule(param1);
         _loc3_.name = param2;
         WindowManager.showModalWindow(_loc3_);
         return _loc3_;
      }
      
      public static function showConfirmBox(param1:String, param2:Function, param3:* = null, param4:Array = null) : void
      {
         var _loc6_:DisplayObject = null;
         var _loc5_:ConfirmBoxModule = new ConfirmBoxModule();
         _loc5_.setInfo(param1);
         _loc5_.setAdditionPar(param3);
         for each(_loc6_ in param4)
         {
            if(_loc6_)
            {
               _loc5_.obf_v_p_3986(_loc6_);
            }
         }
         WindowManager.showModalWindow(_loc5_,param2,true);
      }
      
      public static function showConfirmSmallBox(param1:String, param2:Function, param3:* = null, param4:String = "") : void
      {
         var _loc6_:IWindow = null;
         if(GameContext.userConfig.sst.cdcb)
         {
            return;
         }
         var _loc5_:obf_A_J_934 = new obf_A_J_934(param2,param1,param3);
         if(!obf_L_l_4100.isEmpty(param4))
         {
            for each(_loc6_ in _normalWindows)
            {
               if(_loc6_)
               {
                  if((_loc6_ as DisplayObject).name == param4)
                  {
                     closeWindow(_loc6_);
                  }
               }
            }
            _loc5_.name = param4;
         }
         WindowManager.showWindow(_loc5_);
      }
      
      public static function showInputBox(param1:String, param2:Array = null, param3:* = null, param4:int = 0, param5:Boolean = false, param6:Function = null, param7:Boolean = false) : void
      {
         WindowManager.showModalWindow(new InputBoxModule(param1,param2,param3,param4,param5,param7),param6);
      }
      
      public static function showInfoBox(param1:String) : void
      {
         var _loc2_:InfoBox = new InfoBox(param1);
         WindowManager.showWindow(_loc2_);
      }
      
      public static function showDragonWin(param1:String, param2:Function, param3:int = 0) : void
      {
         var _loc4_:obf_j_f_929 = new obf_j_f_929(param3);
         _loc4_.setTxt(param1);
         _loc4_.setDisCheckBox();
         WindowManager.showModalWindow(_loc4_,param2,true);
      }
   }
}

