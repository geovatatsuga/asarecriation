package com.sunweb.game.rpg.role.action
{
   import com.sunweb.game.rpg.EngineConfig;
   import com.sunweb.game.util.obf_3_9_3148;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class obf_L_S_1960 extends obf_W_E_4480
   {
      
      protected var obf_u_j_2363:Array;
      
      protected var obf_x_7_2216:Boolean = false;
      
      protected var _rawFrameArray:Array;
      
      protected var obf_s_t_2541:Array;
      
      protected var _bitmap:Bitmap = new Bitmap();
      
      protected var _sprite:Sprite = new Sprite();
      
      public function obf_L_S_1960(param1:Array = null, param2:Boolean = false, param3:* = null, param4:int = 30)
      {
         super();
         this.obf_u_j_2363 = param1;
         isMirrored = param2;
         if(param3 == null)
         {
            param3 = EngineConfig.isBitmapModePlayerFrame;
         }
         this.obf_x_7_2216 = param3;
         obf_e_k_2190 = frameRate = param4;
         this.obf_K_c_4232();
      }
      
      public function obf_K_c_4232() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         var _loc3_:obf_0_2_514 = null;
         if(this.obf_u_j_2363 != null && this.obf_u_j_2363.length > 0)
         {
            _loc1_ = new Array();
            for each(_loc2_ in this.obf_u_j_2363)
            {
               _loc3_ = new obf_0_2_514(_loc2_,this.obf_x_7_2216);
               _loc1_.push(_loc3_);
            }
            this.obf_7_8_2732 = _loc1_;
         }
      }
      
      public function set frameArray(param1:Array) : void
      {
         this.obf_s_t_2541 = param1;
         obf_J_V_3383 = this.obf_s_t_2541.length;
         obf_0_F_4536 = obf_J_V_3383 * 1000 / frameRate;
         obf_p_z_3583 = 1;
         obf_G_v_797 = 0;
      }
      
      public function get frameArray() : Array
      {
         return this.obf_s_t_2541;
      }
      
      public function set obf_7_8_2732(param1:Array) : void
      {
         var _loc3_:obf_0_2_514 = null;
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.frames)
            {
               _loc2_.push(_loc3_);
               _loc4_++;
            }
         }
         this._rawFrameArray = param1;
         this.frameArray = _loc2_;
      }
      
      public function get obf_7_8_2732() : Array
      {
         return this._rawFrameArray;
      }
      
      public function get isBitmapMode() : Boolean
      {
         return this.obf_x_7_2216;
      }
      
      override protected function showFrame(param1:int) : void
      {
         var _loc3_:Sprite = null;
         var _loc2_:obf_0_2_514 = this.obf_s_t_2541[param1 - 1] as obf_0_2_514;
         if(_loc2_.obf_G_l_4306)
         {
            _loc2_.redraw();
         }
         if(this.obf_x_7_2216)
         {
            this._bitmap.bitmapData = _loc2_.imageData;
            if(isMirrored)
            {
               this._bitmap.x = _loc2_.rootPX;
               this._bitmap.y = -_loc2_.rootPY;
            }
            else
            {
               this._bitmap.x = -_loc2_.rootPX;
               this._bitmap.y = -_loc2_.rootPY;
            }
         }
         else
         {
            if(this._sprite.numChildren > 0 && this._sprite.getChildAt(0) == _loc2_.imageSprite)
            {
               return;
            }
            obf_3_9_3148.removeChildren(this._sprite);
            _loc3_ = _loc2_.imageSprite;
            if(_loc3_ != null)
            {
               this._sprite.addChild(_loc3_);
               if(isMirrored)
               {
                  this._sprite.x = _loc2_.rootPX;
                  this._sprite.y = -_loc2_.rootPY;
               }
               else
               {
                  this._sprite.x = -_loc2_.rootPX;
                  this._sprite.y = -_loc2_.rootPY;
               }
            }
         }
      }
      
      override protected function obf_R_B_2331(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         if(this.obf_x_7_2216)
         {
            if(isMirrored)
            {
               this._bitmap.scaleX = -this._bitmap.scaleX;
            }
            this.addChild(this._bitmap);
         }
         else
         {
            if(isMirrored)
            {
               this._sprite.scaleX = -this._sprite.scaleX;
            }
            this.addChild(this._sprite);
         }
         super.obf_R_B_2331(param1);
      }
      
      override protected function obf_0_9_2407(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         super.obf_0_9_2407(param1);
         if(this.obf_x_7_2216)
         {
            this.removeChild(this._bitmap);
            if(isMirrored)
            {
               this._bitmap.scaleX = -this._bitmap.scaleX;
            }
         }
         else
         {
            this.removeChild(this._sprite);
            if(isMirrored)
            {
               this._sprite.scaleX = -this._sprite.scaleX;
            }
         }
      }
   }
}

