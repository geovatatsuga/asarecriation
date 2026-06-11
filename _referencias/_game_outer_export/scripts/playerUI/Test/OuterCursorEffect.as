package playerUI.Test
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5307")]
   public dynamic class OuterCursorEffect extends MovieClip
   {
      
      public function OuterCursorEffect()
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

