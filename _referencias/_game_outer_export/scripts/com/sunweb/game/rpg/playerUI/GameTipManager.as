package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GameTipManager
   {
      
      private static var _tipSprite:Sprite;
      
      private static var tipObject:Object = new Object();
      
      public function GameTipManager()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         _tipSprite = param1;
         _tipSprite.doubleClickEnabled = true;
         addListener();
      }
      
      private static function addListener() : void
      {
         _tipSprite.addEventListener(MouseEvent.CLICK,obf_3_6_3736);
         _tipSprite.addEventListener(MouseEvent.DOUBLE_CLICK,obf_3_6_3736);
         _tipSprite.addEventListener(MouseEvent.MOUSE_UP,obf_3_6_3736);
         _tipSprite.addEventListener(MouseEvent.MOUSE_DOWN,obf_3_6_3736);
      }
      
      private static function removeListener() : void
      {
         _tipSprite.removeEventListener(MouseEvent.CLICK,obf_3_6_3736);
         _tipSprite.removeEventListener(MouseEvent.DOUBLE_CLICK,obf_3_6_3736);
         _tipSprite.removeEventListener(MouseEvent.MOUSE_UP,obf_3_6_3736);
         _tipSprite.removeEventListener(MouseEvent.MOUSE_DOWN,obf_3_6_3736);
      }
      
      private static function obf_3_6_3736(param1:Event) : void
      {
         IconItemManager.uiSprite.dispatchEvent(param1);
         trace(param1.type);
         if(param1.type == "")
         {
         }
      }
      
      public static function isShowing(param1:String) : Boolean
      {
         return tipObject.hasOwnProperty(param1);
      }
      
      public static function showTip(param1:GameTipUI, param2:Point = null, param3:Array = null) : void
      {
         var _loc7_:GameTipUI = null;
         var _loc8_:Number = NaN;
         var _loc9_:GameTipUI = null;
         if(!_tipSprite.stage)
         {
            return;
         }
         if(tipObject[param1.tipName])
         {
            closeTip(param1.tipName);
         }
         if(!param2)
         {
            param2 = new Point(_tipSprite.mouseX + 1,_tipSprite.mouseY + 1);
         }
         var _loc4_:int = param1.width;
         if(param3)
         {
            for each(_loc7_ in param3)
            {
               if(_loc7_)
               {
                  _loc4_ += _loc7_.width;
               }
            }
         }
         if(param1.width > GameContext.gameStage.stageWidth || param1.height > GameContext.gameStage.stageHeight)
         {
            _loc8_ = 0;
            if(param1.width - GameContext.gameStage.stageWidth > param1.height - GameContext.gameStage.stageHeight)
            {
               _loc8_ = GameContext.gameStage.stageWidth / param1.width;
            }
            else
            {
               _loc8_ = GameContext.gameStage.stageHeight / param1.height;
            }
            param1.scaleX = _loc8_;
            param1.scaleY = _loc8_;
         }
         if(param2.x > _tipSprite.stage.stageWidth - _loc4_)
         {
            param2.x = GameContext.gameStage.stageWidth - _loc4_;
         }
         if(param2.x < 0)
         {
            param2.x = 0;
         }
         if(param2.y > _tipSprite.stage.stageHeight - param1.height)
         {
            param2.y -= param1.height + 1;
         }
         if(param2.y < 0)
         {
            param2.y = 0;
         }
         param1.x = param2.x;
         param1.y = param2.y;
         tipObject[param1.tipName] = param1;
         _tipSprite.addChild(param1);
         var _loc5_:int = 0;
         var _loc6_:int = param1.width;
         if(param3)
         {
            for each(_loc9_ in param3)
            {
               if(_loc9_)
               {
                  _loc9_.y = param1.y;
                  _loc9_.x = param1.x + _loc6_;
                  if(_loc9_.x > _tipSprite.stage.stageWidth - _loc9_.width)
                  {
                     _loc9_.x = param1.x - _loc9_.width - _loc5_;
                     _loc5_ += _loc9_.width;
                  }
                  else
                  {
                     _loc6_ += _loc9_.width;
                  }
                  tipObject[_loc9_.tipName] = _loc9_;
                  _tipSprite.addChild(_loc9_);
               }
            }
         }
      }
      
      public static function closeTip(param1:String) : void
      {
         var _loc2_:GameTipUI = tipObject[param1];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.destroy();
         if(_tipSprite.contains(_loc2_))
         {
            _tipSprite.removeChild(_loc2_);
         }
         delete tipObject[param1];
      }
   }
}

