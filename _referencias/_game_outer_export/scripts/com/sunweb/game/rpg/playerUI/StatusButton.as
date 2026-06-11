package com.sunweb.game.rpg.playerUI
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class StatusButton extends Sprite
   {
      
      public static const obf_F_z_2485:int = 1;
      
      public static const STATUS_1:int = 2;
      
      public static const obf_C_r_3935:int = 2;
      
      private var obf_V_j_3761:int;
      
      private var obf_T_K_3021:MovieClip;
      
      private var obf_P_R_2403:Boolean;
      
      public function StatusButton(param1:MovieClip, param2:Boolean = true)
      {
         super();
         this.obf_P_R_2403 = param2;
         this.obf_T_K_3021 = param1;
         this.x = param1.x;
         this.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         if(param1.parent != null)
         {
            param1.parent.addChild(this);
         }
         this.addChild(param1);
         this.obf_f_C_851 = obf_F_z_2485;
         if(this.obf_T_K_3021.tooltip)
         {
            this.obf_T_K_3021.tooltip.mouseEnabled = false;
            if(!this.obf_P_R_2403)
            {
               this.obf_T_K_3021.tooltip.visible = false;
            }
         }
         this.addListener();
      }
      
      public function set obf_f_C_851(param1:uint) : void
      {
         if(param1 <= obf_C_r_3935)
         {
            this.obf_T_K_3021.gotoAndStop(param1);
         }
      }
      
      public function get obf_f_C_851() : uint
      {
         return this.obf_V_j_3761;
      }
      
      public function set obf_S_F_2079(param1:String) : void
      {
         if(Boolean(this.obf_T_K_3021.tooltip) && this.obf_T_K_3021.tooltip is TextField)
         {
            this.obf_T_K_3021.tooltip.text = param1;
         }
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         if(this.obf_T_K_3021.tooltip)
         {
            this.obf_T_K_3021.tooltip.visible = true;
         }
      }
      
      private function onMouseOut(param1:Event) : void
      {
         if(Boolean(this.obf_T_K_3021.tooltip) && !this.obf_P_R_2403)
         {
            this.obf_T_K_3021.tooltip.visible = false;
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

