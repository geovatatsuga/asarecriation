package com.sunweb.game.rpg.role.action
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class obf_W_E_4480 extends Sprite
   {
      
      public var frameRate:int = 30;
      
      public var obf_e_k_2190:int = 30;
      
      public var isMirrored:Boolean = false;
      
      public var allowRepeat:Boolean = true;
      
      public var autoRemove:Boolean = false;
      
      protected var obf_J_V_3383:int;
      
      protected var obf_0_F_4536:int;
      
      protected var obf_p_z_3583:int;
      
      protected var obf_G_v_797:int;
      
      protected var obf_N_d_976:Boolean;
      
      protected var _lastRefreshTimer:int;
      
      protected var _completeEventFired:Boolean = false;
      
      protected var obf_n_B_3255:int = 0;
      
      protected var obf_r_N_1506:int = 0;
      
      protected var obf_x_E_2089:int = 0;
      
      protected var _lastStopTimer:int;
      
      protected var obf_0_1_5_279:Boolean = false;
      
      protected var _lastFreezeTimer:int;
      
      protected var obf_e_C_3028:int;
      
      public function obf_W_E_4480()
      {
         super();
         this.obf_N_d_976 = false;
         this.addEventListener(Event.ADDED,this.obf_R_B_2331);
         this.addEventListener(Event.REMOVED,this.obf_0_9_2407);
      }
      
      public function clone() : obf_W_E_4480
      {
         throw new Error("no call this fun!");
      }
      
      public function get totalFrames() : int
      {
         return this.obf_J_V_3383;
      }
      
      public function get obf_Q_o_1855() : int
      {
         return this.obf_0_F_4536;
      }
      
      public function get currentFrame() : int
      {
         return this.obf_p_z_3583;
      }
      
      public function get currentTime() : int
      {
         return this.obf_G_v_797;
      }
      
      public function get isStopped() : Boolean
      {
         return this.obf_N_d_976;
      }
      
      public function get maxPlayTime() : int
      {
         return this.obf_n_B_3255;
      }
      
      public function set maxPlayTime(param1:int) : void
      {
         this.obf_n_B_3255 = param1;
      }
      
      public function get obf_F_H_2614() : int
      {
         return this.obf_r_N_1506;
      }
      
      public function set obf_F_H_2614(param1:int) : void
      {
         this.obf_r_N_1506 = param1;
      }
      
      public function get obf_J_1_2804() : int
      {
         return this.obf_x_E_2089;
      }
      
      public function get stopTime() : int
      {
         return this._lastStopTimer <= 0 ? 0 : int(getTimer() - this._lastStopTimer);
      }
      
      public function get isFreezed() : Boolean
      {
         return this.obf_0_1_5_279;
      }
      
      public function obf_J_f_4443(param1:Number) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:int = this.obf_e_k_2190 * param1;
         this.obf_U_R_2741(_loc2_);
      }
      
      public function obf_U_R_2741(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         this.frameRate = param1;
         this.obf_0_F_4536 = this.obf_J_V_3383 * 1000 / this.frameRate;
      }
      
      public function obf_N_B_1760(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:int = this.obf_J_V_3383 * 1000 / param1;
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         this.obf_U_R_2741(_loc2_);
      }
      
      public function play() : void
      {
         if(!this.obf_N_d_976)
         {
            return;
         }
         this.obf_N_d_976 = false;
         this._lastStopTimer = 0;
         if(this.parent != null)
         {
            this._lastRefreshTimer = getTimer();
         }
      }
      
      public function stop() : void
      {
         if(this.obf_N_d_976)
         {
            return;
         }
         this.obf_N_d_976 = true;
         this._lastStopTimer = getTimer();
      }
      
      public function removeMe() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function freeze(param1:int, param2:Boolean = false) : void
      {
         if(this.obf_N_d_976)
         {
            return;
         }
         if(this.obf_0_1_5_279 && !param2)
         {
            return;
         }
         this.obf_0_1_5_279 = true;
         this._lastFreezeTimer = getTimer();
         this.obf_e_C_3028 = param1;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - this._lastRefreshTimer;
         this._lastRefreshTimer = _loc1_;
         if(this.obf_0_1_5_279 && _loc1_ >= this._lastFreezeTimer + this.obf_e_C_3028)
         {
            this.obf_0_1_5_279 = false;
         }
         if(!this.obf_0_1_5_279)
         {
            this.obf_G_v_797 += _loc2_;
         }
         this.obf_x_E_2089 += _loc2_;
         var _loc3_:Boolean = false;
         if(this.obf_n_B_3255 > 0 && this.obf_x_E_2089 >= this.obf_n_B_3255)
         {
            this.obf_x_E_2089 = this.obf_n_B_3255;
            _loc3_ = true;
         }
         else if(this.obf_G_v_797 > this.obf_0_F_4536)
         {
            if(this.allowRepeat)
            {
               this.obf_G_v_797 %= this.obf_0_F_4536;
            }
            else
            {
               this.obf_G_v_797 = this.obf_Q_o_1855;
               if(this.obf_x_E_2089 >= this.obf_r_N_1506)
               {
                  _loc3_ = true;
               }
            }
         }
         this.obf_p_z_3583 = this.timeToFrame(this.obf_G_v_797);
         this.showFrame(this.obf_p_z_3583);
         if(_loc3_)
         {
            if(!this._completeEventFired)
            {
               this._completeEventFired = true;
               if(this.autoRemove)
               {
                  this.stop();
                  this.removeMe();
               }
               dispatchEvent(new Event(Event.COMPLETE));
            }
         }
      }
      
      public function obf_z_R_4519(param1:int) : void
      {
         this.obf_G_v_797 = param1;
         this.obf_p_z_3583 = this.timeToFrame(this.obf_G_v_797);
         this._lastRefreshTimer = getTimer();
         this.showFrame(this.obf_p_z_3583);
         this._completeEventFired = false;
      }
      
      public function obf_U_D_3091(param1:int) : void
      {
         this.obf_p_z_3583 = param1;
         this.obf_G_v_797 = this.frameToTime(this.obf_p_z_3583);
         this._lastRefreshTimer = getTimer();
         this.showFrame(this.obf_p_z_3583);
         this._completeEventFired = false;
      }
      
      public function rewind() : void
      {
         this.obf_U_D_3091(1);
      }
      
      public function timeToFrame(param1:int) : int
      {
         if(param1 > this.obf_0_F_4536)
         {
            param1 %= this.obf_0_F_4536;
         }
         var _loc2_:int = Math.round(param1 / this.obf_0_F_4536 * this.obf_J_V_3383);
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function frameToTime(param1:int) : int
      {
         if(param1 > this.obf_J_V_3383)
         {
            param1 %= this.obf_J_V_3383;
         }
         return int(Math.round(param1 / this.obf_J_V_3383 * this.obf_0_F_4536));
      }
      
      protected function showFrame(param1:int) : void
      {
      }
      
      protected function obf_R_B_2331(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         this.rewind();
         this.obf_x_E_2089 = 0;
         this.addEventListeners();
         this._lastRefreshTimer = getTimer();
         if(this.obf_N_d_976)
         {
            this._lastStopTimer = getTimer();
         }
         this.obf_0_1_5_279 = false;
         this._completeEventFired = false;
      }
      
      protected function obf_0_9_2407(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         this.removeEventListeners();
      }
      
      protected function addEventListeners() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      protected function removeEventListeners() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         if(this.obf_N_d_976)
         {
            return;
         }
         this.refresh();
      }
   }
}

