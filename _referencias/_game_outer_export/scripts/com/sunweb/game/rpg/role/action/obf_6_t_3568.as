package com.sunweb.game.rpg.role.action
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class obf_6_t_3568 extends obf_W_E_4480
   {
      
      protected var _mc:MovieClip;
      
      public function obf_6_t_3568(param1:MovieClip = null, param2:Boolean = false, param3:int = 30)
      {
         super();
         obf_e_k_2190 = frameRate = param3;
         if(param1 != null)
         {
            this.obf_N_k_3254 = param1;
         }
         isMirrored = param2;
      }
      
      public function set obf_N_k_3254(param1:MovieClip) : void
      {
         this._mc = param1;
         this._mc.stop();
         obf_J_V_3383 = this._mc.totalFrames;
         obf_0_F_4536 = obf_J_V_3383 * 1000 / frameRate;
         obf_p_z_3583 = 1;
         obf_G_v_797 = 0;
      }
      
      public function get obf_N_k_3254() : MovieClip
      {
         return this._mc;
      }
      
      override protected function showFrame(param1:int) : void
      {
         this._mc.gotoAndStop(param1);
      }
      
      override protected function obf_R_B_2331(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         if(isMirrored)
         {
            this._mc.scaleX = -this._mc.scaleX;
         }
         this.addChild(this._mc);
         super.obf_R_B_2331(param1);
      }
      
      override protected function obf_0_9_2407(param1:Event) : void
      {
         if(param1.target != this)
         {
            return;
         }
         super.obf_0_9_2407(param1);
         this.removeChild(this._mc);
         if(isMirrored)
         {
            this._mc.scaleX = -this._mc.scaleX;
         }
      }
   }
}

