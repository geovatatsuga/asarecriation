package com.sunweb.game.rpg.map
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.util.obf_3_9_3148;
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import mapCommon.CreatureShadowRing;
   
   public class MapGroundObject extends MapInteractiveObject
   {
      
      protected var _res:String;
      
      protected var _displayObject:DisplayObject;
      
      public function MapGroundObject(param1:String)
      {
         var _loc3_:Rectangle = null;
         super();
         rootX = rootY = 0;
         rootPXYAvailable = true;
         this.x = rootPX = Map.obf_7_7_3297 / 2;
         this.y = rootPY = 0;
         this._res = param1;
         var _loc2_:DisplayObject = new CreatureShadowRing();
         this.addChild(_loc2_);
         this._displayObject = ResourceManager.instance.getDisplayObject(this._res);
         if(this._displayObject != null)
         {
            this.addChild(this._displayObject);
            _loc3_ = this._displayObject.getRect(this._displayObject);
            this._displayObject.x = -(_loc3_.x + _loc3_.width / 2);
            this._displayObject.y = -_loc3_.y;
            _loc2_.x = 0;
            _loc2_.y = _loc3_.height;
         }
      }
      
      override public function getTopmostY() : int
      {
         return 0;
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         obf_D_I_1250 = param1;
         if(this._displayObject == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_ = [1.8,0,0,0,0,0,1.8,0,0,0,0,0,1.8,0,0,0,0,0,1,0];
            this._displayObject.filters = [new ColorMatrixFilter(_loc2_)];
         }
         else
         {
            this._displayObject.filters = null;
         }
      }
      
      override public function destroy() : void
      {
         this._displayObject = null;
         obf_3_9_3148.removeChildren(this);
         super.destroy();
      }
   }
}

