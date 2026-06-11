package com.sunweb.game.rpg.map
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class obf_P_4660 implements obf_A_1_2543
   {
      
      private var obf_L_w_3939:Rectangle;
      
      private var obf_0_8_f_117:int;
      
      private var obf_V_2_2346:int;
      
      private var _res:String;
      
      private var obf_K_G_3302:Array;
      
      private var _displayObject:DisplayObject;
      
      private var _isTempDisplayObject:Boolean = false;
      
      public function obf_P_4660(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.obf_L_w_3939 = new Rectangle();
         this.obf_L_w_3939.x = param1.l == null ? Number(param1.px) : Number(param1.l);
         this.obf_L_w_3939.y = param1.t == null ? Number(param1.py) : Number(param1.t);
         this.obf_L_w_3939.width = param1.w;
         this.obf_L_w_3939.height = param1.h;
         this.obf_0_8_f_117 = param1.px;
         this.obf_V_2_2346 = param1.py;
         this._res = param1.res;
         this.obf_K_G_3302 = param1.effect;
         if(this.obf_K_G_3302 != null && this.obf_K_G_3302.length == 0)
         {
            this.obf_K_G_3302 = null;
         }
      }
      
      public function obf_Q_R_3368(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.obf_L_w_3939 = new Rectangle();
         this.obf_L_w_3939.x = param1;
         this.obf_L_w_3939.y = param2;
         this.obf_L_w_3939.width = param3;
         this.obf_L_w_3939.height = param4;
         this.obf_0_8_f_117 = param1;
         this.obf_V_2_2346 = param2;
         this._res = null;
         this.obf_K_G_3302 = null;
      }
      
      public function get isDynamicBitmap() : Boolean
      {
         return this._res == null || this._res == "";
      }
      
      public function get res() : String
      {
         return this._res;
      }
      
      public function get displayObject() : DisplayObject
      {
         return this._displayObject;
      }
      
      private function getPlaceholderFromMinimap(param1:Map) : Bitmap
      {
         var x:int = 0;
         var y:int = 0;
         var w:int = 0;
         var h:int = 0;
         var bmd:BitmapData = null;
         var map:Map = param1;
         try
         {
            x = this.obf_L_w_3939.x / map.mapWidthInPixel * map.minimap.width;
            y = this.obf_L_w_3939.y / map.mapHeightInPixel * map.minimap.height;
            w = this.obf_L_w_3939.width / map.mapWidthInPixel * map.minimap.width;
            h = this.obf_L_w_3939.height / map.mapHeightInPixel * map.minimap.height;
            bmd = new BitmapData(w,h,false,0);
            bmd.copyPixels(map.minimap,new Rectangle(x,y,w,h),new Point(0,0));
            return new Bitmap(bmd);
         }
         catch(e:Error)
         {
         }
         return new Bitmap();
      }
      
      public function get area() : Rectangle
      {
         if(!this.isInStage)
         {
            return this.obf_L_w_3939;
         }
         return this._displayObject == null ? this.obf_L_w_3939 : this._displayObject.getBounds(this._displayObject.parent);
      }
      
      public function obf_T_Y_4478(param1:obf_2_1_1369) : void
      {
         var bmd:BitmapData = null;
         var obj:DisplayObject = null;
         var layer:obf_2_1_1369 = param1;
         if(this._displayObject == null || this._isTempDisplayObject)
         {
            if(this.isDynamicBitmap)
            {
               bmd = new BitmapData(this.obf_L_w_3939.width,this.obf_L_w_3939.height,false,0);
               try
               {
                  layer.map.obf_N_1848.moveTo(this.area.x,this.area.y);
                  bmd.draw(layer.map.fastBGRawLayer,new Matrix(1,0,0,1,-this.obf_L_w_3939.x,-this.obf_L_w_3939.y));
               }
               catch(e:Error)
               {
               }
               this._displayObject = new Bitmap(bmd);
               this._displayObject.x = this.obf_0_8_f_117;
               this._displayObject.y = this.obf_V_2_2346;
               this._isTempDisplayObject = false;
            }
            else
            {
               obj = layer.map.resourceBag.manager.getDisplayObject(this._res);
               if(obj == null)
               {
                  layer.loadAndShowObject(this);
                  if(!(!this._isTempDisplayObject && layer.id == obf_2_1_1369.obf_5_Q_881 && layer.map.isLazyLoadBackground && layer.map.minimap != null))
                  {
                     if(this._displayObject != null && this._displayObject.parent != layer)
                     {
                        layer.addChild(this._displayObject);
                     }
                     return;
                  }
                  this._displayObject = this.getPlaceholderFromMinimap(layer.map);
                  this._isTempDisplayObject = true;
               }
               else
               {
                  if(this._displayObject != null && this._isTempDisplayObject)
                  {
                     try
                     {
                        if(this._displayObject.parent != null)
                        {
                           this._displayObject.parent.removeChild(this._displayObject);
                        }
                        (this._displayObject as Bitmap).bitmapData.dispose();
                     }
                     catch(e:Error)
                     {
                     }
                  }
                  this._displayObject = obj;
                  this._isTempDisplayObject = false;
               }
               try
               {
                  if(this._displayObject is InteractiveObject)
                  {
                     (this._displayObject as InteractiveObject).mouseEnabled = false;
                  }
                  if(this._displayObject is DisplayObjectContainer)
                  {
                     (this._displayObject as DisplayObjectContainer).mouseChildren = false;
                  }
               }
               catch(e:Error)
               {
               }
               this._displayObject.x = this.obf_0_8_f_117;
               this._displayObject.y = this.obf_V_2_2346;
               this._displayObject.width = this.area.width;
               this._displayObject.height = this.area.height;
               if(!this._isTempDisplayObject)
               {
                  obf_1_q_4613.showEffect(this._displayObject,this.obf_K_G_3302);
               }
            }
         }
         if(this._displayObject.parent != layer)
         {
            layer.addChild(this._displayObject);
         }
      }
      
      public function removeMe() : void
      {
         if(this.isInStage)
         {
            this._displayObject.parent.removeChild(this._displayObject);
         }
      }
      
      public function get isInStage() : Boolean
      {
         return this._displayObject != null && this._displayObject.stage != null;
      }
      
      public function get obf_0_5_S_544() : DisplayObject
      {
         return this._displayObject;
      }
      
      public function release() : void
      {
         if(this.isDynamicBitmap)
         {
            if(this._displayObject != null && this._displayObject is Bitmap)
            {
               (this._displayObject as Bitmap).bitmapData.dispose();
            }
         }
         this._displayObject = null;
      }
      
      public function destroy() : void
      {
         this.release();
      }
   }
}

