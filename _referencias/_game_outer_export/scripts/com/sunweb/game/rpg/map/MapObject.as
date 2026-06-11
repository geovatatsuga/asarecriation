package com.sunweb.game.rpg.map
{
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MapObject extends Sprite implements obf_A_1_2543
   {
      
      public var zLevel:int = 0;
      
      public var rootX:int;
      
      public var rootY:int;
      
      public var rootArea:Array = null;
      
      public var rootPXYAvailable:Boolean = false;
      
      public var rootPX:int;
      
      public var rootPY:int;
      
      protected var obf_L_w_3939:Rectangle;
      
      protected var _map:Map;
      
      protected var obf_0_3_6_241:Boolean = false;
      
      protected var obf_0_1_o_95:Boolean = false;
      
      public function MapObject()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.obf_0_1_I_384);
      }
      
      public function getMap() : Map
      {
         return this._map;
      }
      
      public function setMap(param1:Map) : void
      {
         this._map = param1;
      }
      
      public function obf_9_C_1574(param1:Map) : void
      {
         this.obf_T_Y_4478(param1.obf_Y_1_2831);
      }
      
      public function onUpdate() : void
      {
      }
      
      public function getNearestPassableTile() : Point
      {
         if(this._map == null)
         {
            return null;
         }
         return this._map.getNearestPassableTile(this.rootX,this.rootY);
      }
      
      protected function obf_N_O_3481() : void
      {
      }
      
      private function obf_0_1_I_384(param1:Event) : void
      {
         var e:Event = param1;
         if(!this.obf_0_3_6_241)
         {
            this.obf_0_3_6_241 = true;
            this.obf_N_O_3481();
         }
         try
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.obf_0_1_I_384);
         }
         catch(e:Error)
         {
         }
      }
      
      public function get area() : Rectangle
      {
         if(!this.isInStage)
         {
            return this.obf_L_w_3939;
         }
         return this.getBounds(this.parent);
      }
      
      public function obf_T_Y_4478(param1:obf_2_1_1369) : void
      {
         param1.addChildAt(this,this.obf_E_0_2748(param1));
      }
      
      public function removeMe() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get isInStage() : Boolean
      {
         return this.stage != null;
      }
      
      public function get obf_0_5_S_544() : DisplayObject
      {
         return this;
      }
      
      public function release() : void
      {
         this._map = null;
      }
      
      public function destroy() : void
      {
         this.release();
         this.obf_0_1_o_95 = true;
         try
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.obf_0_1_I_384);
         }
         catch(e:Error)
         {
         }
      }
      
      public function isDestroyed() : Boolean
      {
         return this.obf_0_1_o_95;
      }
      
      public function obf_9_0_4119() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:DisplayObjectContainer = this.parent;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = _loc1_.getChildIndex(this);
         if(_loc2_ > 0)
         {
            _loc4_ = _loc2_ - 1;
            if(obf_1_q_4613.obf_Y_u_3116(this,_loc1_.getChildAt(_loc4_) as MapObject))
            {
               _loc3_ = 1;
            }
            else
            {
               _loc1_.swapChildrenAt(_loc2_,_loc4_);
               _loc2_ = _loc4_;
               _loc3_ = -1;
            }
         }
         else
         {
            _loc3_ = 1;
         }
         while(true)
         {
            _loc4_ = _loc2_ + _loc3_;
            if(_loc4_ < 0 || _loc4_ > _loc1_.numChildren - 1)
            {
               break;
            }
            _loc5_ = obf_1_q_4613.obf_Y_u_3116(this,_loc1_.getChildAt(_loc4_) as MapObject) ? 1 : -1;
            if(_loc5_ * _loc3_ == -1)
            {
               break;
            }
            _loc1_.swapChildrenAt(_loc2_,_loc4_);
            _loc2_ = _loc4_;
         }
      }
      
      public function obf_E_0_2748(param1:obf_2_1_1369) : int
      {
         if(!param1.isRoleLayer)
         {
            throw new Error("findIndexToInsertObject can be only used for role layer!");
         }
         if(param1.numChildren == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         while(_loc2_ <= param1.numChildren - 1)
         {
            if(param1.getChildAt(_loc2_) === this)
            {
               break;
            }
            if(!obf_1_q_4613.obf_Y_u_3116(this,param1.getChildAt(_loc2_) as MapObject))
            {
               break;
            }
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function moveToTile(param1:int, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc3_:int = param1 - this.rootX;
         var _loc4_:int = param2 - this.rootY;
         var _loc5_:int = _loc3_ * Map.obf_7_7_3297;
         var _loc6_:int = _loc4_ * Map.TILE_HEIGHT_IN_PIXEL;
         this.rootX = param1;
         this.rootY = param2;
         if(this.rootPXYAvailable)
         {
            this.rootPX += _loc5_;
            this.rootPY += _loc6_;
         }
         if(this.obf_L_w_3939 != null)
         {
            this.obf_L_w_3939.x += _loc5_;
            this.obf_L_w_3939.y += _loc6_;
         }
         if(this.rootArea != null)
         {
            for each(_loc7_ in this.rootArea)
            {
               _loc7_.x += _loc3_;
               _loc7_.y += _loc4_;
            }
         }
         this.x += _loc5_;
         this.y += _loc6_;
      }
      
      public function moveToPixel(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         if(!this.rootPXYAvailable)
         {
            return;
         }
         var _loc3_:int = param1 - this.rootPX;
         var _loc4_:int = param2 - this.rootPY;
         this.rootPX = param1;
         this.rootPY = param2;
         if(this.obf_L_w_3939 != null)
         {
            this.obf_L_w_3939.x += _loc3_;
            this.obf_L_w_3939.y += _loc4_;
         }
         var _loc5_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(this.rootPX,this.rootPY));
         if(this.rootArea != null)
         {
            _loc6_ = _loc5_.x - this.rootX;
            _loc7_ = _loc5_.y - this.rootY;
            for each(_loc8_ in this.rootArea)
            {
               _loc8_.x += _loc6_;
               _loc8_.y += _loc7_;
            }
         }
         this.rootX = _loc5_.x;
         this.rootY = _loc5_.y;
         this.x += _loc3_;
         this.y += _loc4_;
      }
      
      public function getFarm() : obf_0_1_N_478
      {
         if(this is obf_0_1_N_478)
         {
            return this as obf_0_1_N_478;
         }
         if(this._map == null)
         {
            return null;
         }
         return this._map.getFarmUnderObject(this);
      }
   }
}

