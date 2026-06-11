package com.sunweb.game.rpg.map
{
   import com.sunweb.game.util.obf_3_9_3148;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class obf_o_s_1091 extends Sprite
   {
      
      private var _map:Map;
      
      private var _color:int;
      
      private var obf_0_5_v_530:String;
      
      public function obf_o_s_1091(param1:Map)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._map = param1;
         this._color = this._map.bgcolor;
      }
      
      public function release() : void
      {
      }
      
      public function destroy() : void
      {
         this._map = null;
      }
      
      public function obf_0_9_K_397() : void
      {
         this.cacheAsBitmap = true;
         this.graphics.beginFill(this._color);
         this.graphics.drawRect(0,0,this._map.obf_0_D_2242,this._map.obf_t_h_3758);
         this.graphics.endFill();
      }
      
      public function updateView() : void
      {
         var _loc1_:Rectangle = this._map.obf_0_6_g_261;
         this.x = _loc1_.x;
         this.y = _loc1_.y;
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function removeChildren() : void
      {
         obf_3_9_3148.removeChildren(this);
      }
   }
}

