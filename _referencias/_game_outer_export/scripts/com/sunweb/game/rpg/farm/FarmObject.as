package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.obf_1_q_4613;
   import com.sunweb.game.rpg.role.obf_7_4687;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FarmObject extends MapInteractiveObject
   {
      
      protected var _code:String;
      
      protected var _res:String;
      
      protected var obf_f_a_2617:int;
      
      protected var obf_k_E_3728:int;
      
      protected var obf_1_A_3134:int;
      
      protected var obf_J_a_1283:int;
      
      protected var _unmovableArea:Array;
      
      protected var obf_f_u_n_c_t_i_o_n_22:Array;
      
      protected var _displayObject:DisplayObject;
      
      protected var obf_5_a_4161:Sprite;
      
      protected var obf_C_7_1035:Boolean = false;
      
      protected var obf_0_2_s_579:String;
      
      protected var obf_f_Q_2416:TimeLimiter;
      
      public function FarmObject(param1:Object, param2:String)
      {
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         this.obf_f_Q_2416 = new TimeLimiter(500);
         super();
         obf_F_7_2340 |= obf_7_4687.obf_U_V_1017;
         this._code = param1.code;
         this._res = param1.res;
         this.obf_f_a_2617 = param1.offsetX;
         this.obf_k_E_3728 = param1.offsetY;
         this.obf_1_A_3134 = param1.rootX;
         this.obf_J_a_1283 = param1.rootY;
         if(param1.unmovableArea != null && param1.unmovableArea.length > 0)
         {
            this._unmovableArea = new Array();
            for each(_loc3_ in param1.unmovableArea)
            {
               _loc4_ = new Point(_loc3_.x - this.obf_1_A_3134,_loc3_.y - this.obf_J_a_1283);
               this._unmovableArea.push(_loc4_);
            }
         }
         if(param1.farmArea != null && param1.farmArea.length > 0)
         {
            this.obf_f_u_n_c_t_i_o_n_22 = new Array();
            for each(_loc3_ in param1.farmArea)
            {
               _loc4_ = new Point(_loc3_.x - this.obf_1_A_3134,_loc3_.y - this.obf_J_a_1283);
               this.obf_f_u_n_c_t_i_o_n_22.push(_loc4_);
            }
         }
         this.obf_0_2_s_579 = param2;
         this.obf_C_7_1035 = !this.isResLoaded();
         this.obf_2_Y_3019();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.showTileState = false;
         if(this._displayObject != null)
         {
            if(this._displayObject.parent != null)
            {
               this._displayObject.parent.removeChild(this._displayObject);
            }
            this._displayObject = null;
         }
      }
      
      override public function moveToPixel(param1:int, param2:int) : void
      {
         var _loc3_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(param1,param2));
         this.moveToTile(_loc3_.x,_loc3_.y);
      }
      
      override public function moveToTile(param1:int, param2:int) : void
      {
         super.moveToTile(param1,param2);
         if(this.showTileState)
         {
            this.obf_5_a_4161.x = this.rootPX;
            this.obf_5_a_4161.y = this.rootPY;
         }
      }
      
      override public function getTopmostY() : int
      {
         if(this._displayObject == null || this._displayObject.parent == null)
         {
            return super.getTopmostY();
         }
         var _loc1_:Rectangle = this._displayObject.getRect(this);
         return _loc1_.height > 0 ? int(_loc1_.top) : int(super.getTopmostY());
      }
      
      public function get code() : String
      {
         return this._code;
      }
      
      public function get unmovableArea() : Array
      {
         return this._unmovableArea;
      }
      
      public function get hasUnmovablePoint() : Boolean
      {
         return this._unmovableArea != null && this._unmovableArea.length > 0;
      }
      
      public function get farmArea() : Array
      {
         return this.obf_f_u_n_c_t_i_o_n_22;
      }
      
      public function set showTileState(param1:Boolean) : void
      {
         if(param1 == this.showTileState)
         {
            return;
         }
         if(param1)
         {
            if(_map == null)
            {
               return;
            }
            this.obf_5_a_4161 = new Sprite();
            obf_1_q_4613.drawTiles(this.obf_5_a_4161,this.obf_f_u_n_c_t_i_o_n_22,16711680,0.5,1,Map.obf_7_7_3297 / 2,Map.TILE_HEIGHT_IN_PIXEL / 2);
            this.obf_5_a_4161.x = this.rootPX;
            this.obf_5_a_4161.y = this.rootPY;
            _map.bgObjectLayer.addChild(this.obf_5_a_4161);
            if(this._displayObject != null)
            {
               this._displayObject.alpha = 0.4;
            }
         }
         else
         {
            this.obf_5_a_4161.parent.removeChild(this.obf_5_a_4161);
            this.obf_5_a_4161.graphics.clear();
            this.obf_5_a_4161 = null;
            if(this._displayObject != null)
            {
               this._displayObject.alpha = 1;
            }
         }
      }
      
      public function get showTileState() : Boolean
      {
         return this.obf_5_a_4161 != null && this.obf_5_a_4161.parent != null;
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
      
      protected function isResLoaded() : Boolean
      {
         var _loc1_:String = obf_b_8_4256.getResIdToImport(this._res);
         return _loc1_ == null ? false : ResourceManager.instance.isResourceLoaded(_loc1_);
      }
      
      protected function checkAndUpdateModel() : void
      {
         if(!this.obf_C_7_1035)
         {
            return;
         }
         if(!this.isResLoaded())
         {
            return;
         }
         this.obf_C_7_1035 = false;
         this.obf_2_Y_3019();
         this.onModelUpdated();
      }
      
      protected function onModelUpdated() : void
      {
      }
      
      protected function obf_2_Y_3019() : void
      {
         if(this._displayObject != null)
         {
            if(this._displayObject.parent != null)
            {
               this._displayObject.parent.removeChild(this._displayObject);
            }
            this._displayObject = null;
         }
         this._displayObject = ResourceManager.instance.getDisplayObject(this._res);
         if(this._displayObject != null)
         {
            this._displayObject.x = this.obf_f_a_2617 - this.obf_1_A_3134 * Map.obf_7_7_3297 - Map.obf_7_7_3297 / 2;
            this._displayObject.y = this.obf_k_E_3728 - this.obf_J_a_1283 * Map.TILE_HEIGHT_IN_PIXEL - Map.TILE_HEIGHT_IN_PIXEL / 2;
            this.addChild(this._displayObject);
         }
         else
         {
            this._displayObject = ResourceManager.instance.getDisplayObject(this.obf_0_2_s_579);
            this.addChild(this._displayObject);
         }
         updateLabelPosition();
      }
      
      override public function onUpdate() : void
      {
         super.onUpdate();
         if(this.obf_f_Q_2416.checkTimeout())
         {
            this.checkAndUpdateModel();
         }
      }
   }
}

