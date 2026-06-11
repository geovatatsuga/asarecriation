package com.sunweb.game.utils
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import fl.controls.UIScrollBar;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class obf_9_V_1635
   {
      
      public static const rotation:Array = [-45,-135,135,45,-90,180,90,0];
      
      public static var uiWaitScrollMap:Dictionary = new Dictionary();
      
      public static var uiScrollBoxMap:Dictionary = new Dictionary();
      
      public static var uiScrollUIMap:Dictionary = new Dictionary();
      
      public static var uiScrollBarMap:Dictionary = new Dictionary();
      
      public function obf_9_V_1635()
      {
         super();
      }
      
      public static function setSimpleButtonTooltip(param1:SimpleButton, param2:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:int = 0;
         if(!param1 || !param2)
         {
            return;
         }
         if(param1.upState is DisplayObjectContainer)
         {
            _loc3_ = param1.upState as DisplayObjectContainer;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               if(_loc3_.getChildAt(_loc4_) is TextField)
               {
                  (_loc3_.getChildAt(_loc4_) as TextField).htmlText = param2;
                  break;
               }
               _loc4_++;
            }
         }
         if(param1.overState is DisplayObjectContainer)
         {
            _loc5_ = param1.overState as DisplayObjectContainer;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.numChildren)
            {
               if(_loc5_.getChildAt(_loc6_) is TextField)
               {
                  (_loc5_.getChildAt(_loc6_) as TextField).htmlText = param2;
                  break;
               }
               _loc6_++;
            }
         }
         if(param1.downState is DisplayObjectContainer)
         {
            _loc7_ = param1.downState as DisplayObjectContainer;
            _loc8_ = 0;
            while(_loc8_ < _loc7_.numChildren)
            {
               if(_loc7_.getChildAt(_loc8_) is TextField)
               {
                  (_loc7_.getChildAt(_loc8_) as TextField).htmlText = param2;
                  break;
               }
               _loc8_++;
            }
         }
      }
      
      public static function getGrayFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0,0,0,1,0]);
      }
      
      public static function getHighLightFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([1.8,0,0,0,0,0,1.8,0,0,0,0,0,1.8,0,0,0,0,0,1,0]);
      }
      
      public static function getDropShadowFilter(param1:int) : DropShadowFilter
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = Number(rotation[param1]);
         var _loc4_:Number = 0.8;
         var _loc5_:Number = 2;
         var _loc6_:Number = 2;
         var _loc7_:Number = 20;
         var _loc8_:Number = 1;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Number = BitmapFilterQuality.HIGH;
         return new DropShadowFilter(_loc7_,_loc3_,_loc2_,_loc4_,_loc5_,_loc6_,_loc8_,_loc11_,_loc9_,_loc10_);
      }
      
      public static function getNewTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.textColor = 16777215;
         _loc1_.selectable = false;
         _loc1_.defaultTextFormat = new TextFormat(DiversityManager.getFontStyleName(),DiversityManager.getFontSize());
         return _loc1_;
      }
      
      public static function setScrollBarWidth(param1:UIScrollBar, param2:int) : UIScrollBar
      {
         var _loc5_:int = 0;
         var _loc3_:ResizableScrollBar = new ResizableScrollBar(param2);
         _loc3_.name = param1.name;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.height = param1.height;
         _loc3_.direction = param1.direction;
         _loc3_.visible = param1.visible;
         _loc3_.scrollTarget = param1.scrollTarget;
         var _loc4_:DisplayObjectContainer = param1.parent;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.getChildIndex(param1);
            _loc4_.removeChild(param1);
            _loc4_.addChildAt(_loc3_,_loc5_);
         }
         return _loc3_;
      }
      
      public static function obf_O_o_1114(param1:Sprite, param2:DisplayObject, param3:int, param4:UIScrollBar, param5:int = 20) : void
      {
         obf_k_q_3763(param2);
         obf_k_q_3763(param4);
         uiWaitScrollMap[param2] = [param1,param3,param4];
         param4.pageSize = param4.height;
         param4.lineScrollSize = param5;
         if(param2.stage == null)
         {
            param2.addEventListener(Event.ADDED_TO_STAGE,obf_N_4_2933);
         }
         else
         {
            obf_0_i_1871(param2);
         }
      }
      
      public static function obf_N_4_2933(param1:Event) : void
      {
         obf_0_i_1871(param1.currentTarget as DisplayObject);
      }
      
      public static function obf_0_i_1871(param1:DisplayObject) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Sprite = null;
         var _loc4_:int = 0;
         var _loc5_:UIScrollBar = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Rectangle = null;
         var _loc9_:Object = null;
         if(uiWaitScrollMap[param1])
         {
            _loc2_ = uiWaitScrollMap[param1];
            _loc3_ = _loc2_[0];
            _loc4_ = int(_loc2_[1]);
            _loc5_ = _loc2_[2];
            delete uiWaitScrollMap[param1];
            param1.removeEventListener(Event.ADDED_TO_STAGE,obf_N_4_2933);
            _loc6_ = _loc3_.globalToLocal(param1.localToGlobal(new Point(0,0)));
            _loc7_ = _loc3_.globalToLocal(_loc5_.localToGlobal(new Point(0,0)));
            _loc8_ = null;
            if(_loc4_ == 0)
            {
               _loc8_ = new Rectangle(_loc6_.x,_loc6_.y,_loc7_.x - _loc6_.x + _loc5_.width,_loc5_.height);
            }
            else
            {
               _loc8_ = new Rectangle(Math.min(_loc6_.x,_loc7_.x),_loc6_.y,_loc4_ + _loc5_.width,_loc5_.height);
            }
            _loc3_.addEventListener(MouseEvent.MOUSE_WHEEL,obf_5_I_2591);
            _loc5_.addEventListener(ScrollEvent.SCROLL,obf_J_0_1608);
            _loc4_ = _loc4_ == 0 ? int(_loc7_.x - _loc6_.x) : _loc4_;
            _loc9_ = new Object();
            _loc9_["ui"] = _loc3_;
            _loc9_["box"] = param1;
            _loc9_["bar"] = _loc5_;
            _loc9_["rect"] = _loc8_;
            _loc9_["width"] = _loc4_;
            if(uiScrollUIMap[_loc3_] == null)
            {
               uiScrollUIMap[_loc3_] = new Array();
            }
            uiScrollUIMap[_loc3_].push(_loc9_);
            uiScrollBoxMap[param1] = _loc9_;
            uiScrollBarMap[_loc5_] = _loc9_;
         }
         delete uiWaitScrollMap[param1];
      }
      
      public static function obf_k_q_3763(param1:DisplayObject) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Sprite = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:UIScrollBar = null;
         var _loc6_:int = 0;
         if(Boolean(uiScrollBoxMap[param1]) || Boolean(uiScrollBarMap[param1]))
         {
            _loc2_ = uiScrollBoxMap[param1] || uiScrollBarMap[param1];
            _loc3_ = _loc2_["ui"];
            _loc4_ = _loc2_["box"];
            _loc5_ = _loc2_["bar"];
            if(uiScrollUIMap[_loc3_] != null)
            {
               _loc6_ = int(uiScrollUIMap[_loc3_].indexOf(_loc2_));
               if(_loc6_ != -1)
               {
                  (uiScrollUIMap[_loc3_] as Array).splice(_loc6_,1);
               }
               if((uiScrollUIMap[_loc3_] as Array).length == 0)
               {
                  _loc3_.removeEventListener(MouseEvent.MOUSE_WHEEL,obf_5_I_2591);
                  delete uiScrollUIMap[_loc3_];
               }
            }
            delete uiScrollBoxMap[_loc4_];
            delete uiScrollBarMap[_loc5_];
            _loc4_.removeEventListener(Event.ADDED_TO_STAGE,obf_N_4_2933);
            _loc5_.removeEventListener(ScrollEvent.SCROLL,obf_J_0_1608);
            if(uiWaitScrollMap[_loc4_])
            {
               _loc4_.removeEventListener(Event.ADDED_TO_STAGE,obf_N_4_2933);
               delete uiWaitScrollMap[_loc4_];
            }
         }
         if(uiWaitScrollMap[param1])
         {
            param1.removeEventListener(Event.ADDED_TO_STAGE,obf_N_4_2933);
            delete uiWaitScrollMap[param1];
         }
      }
      
      public static function obf_J_0_1608(param1:Event) : void
      {
         var _loc2_:UIScrollBar = null;
         var _loc3_:Object = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(uiScrollBarMap[param1.currentTarget])
         {
            _loc2_ = param1.currentTarget as UIScrollBar;
            _loc3_ = uiScrollBarMap[_loc2_];
            _loc4_ = _loc3_["box"];
            _loc5_ = int(_loc3_["width"]);
            _loc4_.scrollRect = new Rectangle(0,_loc2_.scrollPosition,_loc5_,_loc2_.height);
         }
      }
      
      public static function obf_5_I_2591(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Object = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:UIScrollBar = null;
         var _loc6_:Rectangle = null;
         var _loc7_:int = 0;
         var _loc8_:Point = null;
         if(uiScrollUIMap[param1.currentTarget])
         {
            _loc2_ = param1.currentTarget as Sprite;
            for each(_loc3_ in uiScrollUIMap[param1.currentTarget])
            {
               _loc4_ = _loc3_["box"];
               _loc5_ = _loc3_["bar"];
               _loc6_ = _loc3_["rect"];
               if(!(_loc4_.stage == null || !_loc4_.visible || !_loc5_.enabled || !_loc5_.visible))
               {
                  if(param1.delta > 0)
                  {
                     _loc7_ = _loc5_.lineScrollSize;
                  }
                  else
                  {
                     _loc7_ = -_loc5_.lineScrollSize;
                  }
                  _loc8_ = _loc2_.globalToLocal(new Point(param1.stageX,param1.stageY));
                  if(_loc6_.contains(_loc8_.x,_loc8_.y))
                  {
                     _loc5_.scrollPosition -= _loc7_;
                  }
               }
            }
         }
      }
   }
}

