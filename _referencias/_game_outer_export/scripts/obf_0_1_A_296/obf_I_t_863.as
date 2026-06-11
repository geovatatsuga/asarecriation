package obf_0_1_A_296
{
   import obf_0_1_8_610.IRecycle;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.superkaka.kakalib.struct.BitmapFrameInfo;
   
   public class obf_I_t_863 extends Sprite implements IRecycle
   {
      
      public var autoRemove:Boolean = false;
      
      public var obf_N_m_1997:Object = {};
      
      protected var bitmap:Bitmap;
      
      protected var v_frame:Vector.<BitmapFrameInfo>;
      
      protected var curIndex:int;
      
      protected var maxIndex:int;
      
      protected var _completeEventFired:Boolean = false;
      
      protected var obf_Z_i_2943:Boolean;
      
      protected var obf_n_B_3255:int = 0;
      
      public function obf_I_t_863(param1:Vector.<BitmapFrameInfo> = null)
      {
         super();
         this.bitmap = new Bitmap();
         this.init();
         this.frameInfo = param1;
         addEventListener(Event.ADDED_TO_STAGE,this.updatePlayStatus);
         addEventListener(Event.REMOVED_FROM_STAGE,this.updatePlayStatus);
      }
      
      protected function init() : void
      {
         this.x = 0;
         this.y = 0;
         this.alpha = 1;
         this.rotation = 0;
         this.visible = true;
         this.scaleX = 1;
         this.scaleY = 1;
         addChild(this.bitmap);
         this.curIndex = 0;
         this.maxIndex = 0;
         this.play();
      }
      
      public function rewind() : void
      {
         this.obf_U_D_3091(1);
      }
      
      public function play() : void
      {
         this.obf_Z_i_2943 = true;
         this.updatePlayStatus();
      }
      
      public function stop() : void
      {
         this.obf_Z_i_2943 = false;
         this.updatePlayStatus();
      }
      
      protected function updatePlayStatus(param1:Event = null) : void
      {
         if(this.obf_Z_i_2943 && this.maxIndex != 0 && stage != null)
         {
            addEventListener(Event.ENTER_FRAME,this.obf_5_c_3508);
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.obf_5_c_3508);
         }
      }
      
      public function nextFrame() : void
      {
         if(this.curIndex == this.maxIndex)
         {
            if(this.autoRemove)
            {
               this.recycle();
               this.removeMe();
            }
            else
            {
               this.obf_U_D_3091(0);
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.obf_U_D_3091(this.curIndex + 1);
         }
         if(this.autoRemove && this.totalFrames >= 30 && this.currentFrame >= 30)
         {
            dispatchEvent(new Event("COMPLETE35"));
         }
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         this.obf_c_n_3898(param1);
         this.play();
      }
      
      public function gotoAndStop(param1:int) : void
      {
         this.obf_c_n_3898(param1);
         this.stop();
      }
      
      public function obf_c_n_3898(param1:int) : void
      {
         this.obf_U_D_3091(param1 - 1);
      }
      
      private function obf_5_c_3508(param1:Event) : void
      {
         this.nextFrame();
      }
      
      public function get frameInfo() : Vector.<BitmapFrameInfo>
      {
         return this.v_frame;
      }
      
      public function set frameInfo(param1:Vector.<BitmapFrameInfo>) : void
      {
         this.v_frame = param1;
         this.bitmap.bitmapData = null;
         if(this.v_frame == null)
         {
            this.curIndex = 0;
            this.maxIndex = 0;
            this.updatePlayStatus();
         }
         else
         {
            this.maxIndex = this.v_frame.length - 1;
            this.obf_U_D_3091(this.curIndex);
            this.updatePlayStatus();
         }
      }
      
      protected function obf_U_D_3091(param1:int) : void
      {
         this.curIndex = param1;
         if(this.curIndex > this.maxIndex)
         {
            this.curIndex = this.maxIndex;
         }
         else if(this.curIndex < 0)
         {
            this.curIndex = 0;
         }
         var _loc2_:BitmapFrameInfo = this.v_frame[this.curIndex];
         if(!_loc2_)
         {
            return;
         }
         this.bitmap.bitmapData = _loc2_.bitmapData;
         this.bitmap.x = _loc2_.x;
         this.bitmap.y = _loc2_.y;
      }
      
      public function get currentFrame() : int
      {
         return this.curIndex + 1;
      }
      
      public function get totalFrames() : int
      {
         return this.v_frame == null ? 0 : int(this.maxIndex + 1);
      }
      
      public function get smoothing() : Boolean
      {
         return this.bitmap.smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         this.bitmap.smoothing = param1;
      }
      
      public function get isPlaying() : Boolean
      {
         return this.obf_Z_i_2943;
      }
      
      public function getCurrentBitmapFrameInfo() : BitmapFrameInfo
      {
         return this.v_frame[this.curIndex];
      }
      
      public function getBitmapFrameInfoByIndex(param1:int) : BitmapFrameInfo
      {
         return this.v_frame[param1 - 1];
      }
      
      public function recycle() : void
      {
         this.dispose();
         this.init();
      }
      
      protected function dispose() : void
      {
         this.stop();
         this.frameInfo = null;
         if(contains(this.bitmap))
         {
            removeChild(this.bitmap);
         }
      }
      
      public function removeMe() : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

