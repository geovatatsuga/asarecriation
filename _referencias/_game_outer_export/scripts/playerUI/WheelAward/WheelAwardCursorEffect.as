package playerUI.WheelAward
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5310")]
   public dynamic class WheelAwardCursorEffect extends MovieClip
   {
      
      public function WheelAwardCursorEffect()
      {
         super();
         addFrameScript(7,frame8);
      }
      
      internal function frame8() : *
      {
         try
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}

