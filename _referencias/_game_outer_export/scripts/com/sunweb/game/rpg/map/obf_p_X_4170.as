package com.sunweb.game.rpg.map
{
   import com.sunweb.game.util.obf_3_9_3148;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class obf_p_X_4170 extends MapObject
   {
      
      protected var _res:String;
      
      protected var obf_K_G_3302:Array;
      
      protected var _displayObject:DisplayObject;
      
      public function obf_p_X_4170(param1:Object)
      {
         super();
         obf_L_w_3939 = new Rectangle();
         obf_L_w_3939.x = param1.l == null ? Number(param1.px) : Number(param1.l);
         obf_L_w_3939.y = param1.t == null ? Number(param1.py) : Number(param1.t);
         obf_L_w_3939.width = param1.w;
         obf_L_w_3939.height = param1.h;
         this.x = param1.px;
         this.y = param1.py;
         this._res = param1.res;
         this.obf_K_G_3302 = param1.effect;
         if(this.obf_K_G_3302 != null && this.obf_K_G_3302.length == 0)
         {
            this.obf_K_G_3302 = null;
         }
         rootX = param1.x;
         rootY = param1.y;
         rootArea = param1.rootArea;
         if(rootArea != null && rootArea.length == 0)
         {
            rootArea = null;
         }
      }
      
      public function get res() : String
      {
         return this._res;
      }
      
      public function get displayObject() : DisplayObject
      {
         return this._displayObject;
      }
      
      override public function obf_T_Y_4478(param1:obf_2_1_1369) : void
      {
         if(this._displayObject == null)
         {
            this._displayObject = param1.map.resourceBag.manager.getDisplayObject(this._res);
            if(this._displayObject == null)
            {
               param1.loadAndShowObject(this);
               return;
            }
            obf_1_q_4613.showEffect(this._displayObject,this.obf_K_G_3302);
         }
         if(!this.contains(this._displayObject))
         {
            this.addChild(this._displayObject);
         }
         super.obf_T_Y_4478(param1);
      }
      
      override public function release() : void
      {
         this._displayObject = null;
         obf_3_9_3148.removeChildren(this);
      }
   }
}

