package com.sunweb.game.rpg.skill
{
   import com.sunweb.game.rpg.GameContext;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.AreaCircleShape;
   import playerUI.AreaLineShape;
   import playerUI.AreaPointShape;
   import playerUI.AreaRectShape;
   
   public class SkillAreaAimManager
   {
      
      private static var _sprite:Sprite;
      
      private static var _cursor:DisplayObject;
      
      private static var _cursorMask:Shape;
      
      private static var currentSkillCode:String;
      
      private static var _isPresent:Boolean;
      
      private static var _areaShape:int;
      
      private static var _para:Object;
      
      private static var _skillPara:Array;
      
      private static var circleShapeRadius:int = 200;
      
      private static var lineLength:int = 200;
      
      public function SkillAreaAimManager()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         if(_sprite)
         {
            removeListener();
         }
         _sprite = param1;
         addListener();
      }
      
      public static function get isPresent() : Boolean
      {
         return _isPresent;
      }
      
      private static function addListener() : void
      {
         _sprite.parent.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         _sprite.parent.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
      }
      
      private static function removeListener() : void
      {
         _sprite.parent.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         _sprite.parent.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
      }
      
      private static function onMouseMove(param1:MouseEvent) : void
      {
         if(currentSkillCode != "" && Boolean(_cursor))
         {
            _cursor.x = param1.stageX;
            _cursor.y = param1.stageY;
            doAreaShape();
         }
      }
      
      private static function onMouseDown(param1:MouseEvent) : void
      {
         if(Boolean(_isPresent && currentSkillCode) && Boolean(currentSkillCode != "") && Boolean(GameContext.localPlayer))
         {
            GameContext.localPlayer.sendSkill.apply(null,[currentSkillCode,GameContext.localPlayer.obf_0_6_a_430,GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY))].concat(_skillPara));
            hideAreaAim();
         }
      }
      
      private static function doAreaShape() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(_areaShape == SkillAreaShape.LINE)
         {
            _loc1_ = GameContext.localPlayer.localToGlobal(new Point());
            _loc2_ = new Point(_sprite.mouseX,_sprite.mouseY).subtract(_loc1_);
            _loc3_ = Math.atan2(_loc2_.y,_loc2_.x) * 180 / Math.PI;
            if(Boolean(_para) && _para.hasOwnProperty("length"))
            {
               if(_para.length == 0 || _loc2_.length < -_para.length)
               {
                  _cursor.scaleX = -(_loc2_.length / lineLength);
               }
            }
            _cursor.rotation = _loc3_;
         }
      }
      
      public static function showAreaAim(param1:String, param2:int, param3:Object, param4:Array) : void
      {
         if(Boolean(_cursor) && _sprite.contains(_cursor))
         {
            _sprite.removeChild(_cursor);
         }
         var _loc5_:int = 0;
         _skillPara = param4;
         if(param2 == SkillAreaShape.CIRCLE)
         {
            _cursor = new AreaCircleShape();
            if(param3 != null && Boolean(param3.radius))
            {
               _loc5_ = int(param3.radius);
            }
            _cursor.scaleX = _loc5_ / circleShapeRadius;
            _cursor.scaleY = _loc5_ / circleShapeRadius;
         }
         else if(param2 == SkillAreaShape.SINGLE)
         {
            _cursor = new AreaPointShape();
         }
         else if(param2 == SkillAreaShape.SECTOR)
         {
            _cursor = new AreaCircleShape();
            if(param3 != null && Boolean(param3.radius))
            {
               _loc5_ = int(param3.radius);
            }
            _cursor.scaleX = _loc5_ / 100;
            _cursor.scaleY = _loc5_ / 100;
         }
         else if(param2 == SkillAreaShape.RECTANGLE)
         {
            _cursor = new AreaRectShape();
         }
         else
         {
            if(param2 != SkillAreaShape.LINE)
            {
               return;
            }
            _cursor = new AreaLineShape();
            if(param3 != null && Boolean(param3.length))
            {
               _loc5_ = int(param3.length);
            }
            _cursor.scaleX = _loc5_ / lineLength;
         }
         _isPresent = true;
         _areaShape = param2;
         _para = param3;
         _cursor.x = _sprite.mouseX;
         _cursor.y = _sprite.mouseY;
         _sprite.addChild(_cursor);
         doAreaShape();
         currentSkillCode = param1;
      }
      
      public static function hideAreaAim() : void
      {
         _isPresent = false;
         if(Boolean(_cursor) && _sprite.contains(_cursor))
         {
            _sprite.removeChild(_cursor);
         }
         currentSkillCode = "";
      }
   }
}

