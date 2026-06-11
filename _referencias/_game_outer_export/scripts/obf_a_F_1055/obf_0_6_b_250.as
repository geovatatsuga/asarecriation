package obf_a_F_1055
{
   import obf_0___l_113.obf_o_z_3061;
   import obf_E_d_1594.NpcTalkBoxUI;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import playerUI.NPCTalkMenuMC;
   
   public class obf_0_6_b_250 extends Sprite implements obf_b_f_2719
   {
      
      public var obf_i_7_4475:NpcTalkBoxUI;
      
      public var obf_V_V_990:obf_o_z_3061;
      
      public var disableMouse:Boolean;
      
      public var _troughMC:MovieClip;
      
      public var isPont:Boolean = false;
      
      private var _isLocked:Boolean;
      
      public function obf_0_6_b_250()
      {
         super();
         this._troughMC = new NPCTalkMenuMC();
         this.x = this._troughMC.x;
         this.y = this._troughMC.y;
         this._troughMC.x = 0;
         this._troughMC.y = 0;
         if(this._troughMC.parent != null)
         {
            this._troughMC.parent.addChild(this);
         }
         this.addChild(this._troughMC);
         this._troughMC.gotoAndStop(1);
         this.addListener();
      }
      
      public function obf_0___j_672(param1:MovieClip) : void
      {
         if(this.contains(this._troughMC))
         {
            this.removeChild(this._troughMC);
         }
         this._troughMC = null;
         this._troughMC = param1;
         this.isPont = true;
         this.x = this._troughMC.x;
         this.y = this._troughMC.y;
         this._troughMC.x = 0;
         this._troughMC.y = 0;
         if(this._troughMC.parent != null)
         {
            this._troughMC.parent.addChild(this);
         }
         this.addChild(this._troughMC);
         this._troughMC.gotoAndStop(1);
      }
      
      public function get txtLabel() : TextField
      {
         if(this._troughMC.txtLabel)
         {
            return this._troughMC.txtLabel;
         }
         return new TextField();
      }
      
      public function get point() : MovieClip
      {
         if(!this._troughMC.showPoint)
         {
            return new MovieClip();
         }
         return this._troughMC.showPoint;
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
         if(this.disableMouse || this._isLocked)
         {
            return;
         }
         this._troughMC.gotoAndStop(2);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         if(this.disableMouse || this._isLocked)
         {
            return;
         }
         this._troughMC.gotoAndStop(1);
      }
      
      public function get bagMC() : DisplayObject
      {
         return this._troughMC;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         this._isLocked = param1;
         if(!param1)
         {
            this._troughMC.gotoAndStop(1);
            this._troughMC.filters = [];
         }
         else
         {
            this._troughMC.gotoAndStop(3);
            this._troughMC.filters = [obf_9_V_1635.getGrayFilter()];
         }
         if(Boolean(this.obf_V_V_990.obf_0_5_3970) && Boolean(this.obf_V_V_990.obf_0_5_3970._troughMC == this._troughMC) && !param1)
         {
            this._troughMC.gotoAndStop(2);
         }
      }
      
      public function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function obf_5_y_948() : void
      {
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

