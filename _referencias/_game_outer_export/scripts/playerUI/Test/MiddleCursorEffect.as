package playerUI.Test
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5308")]
   public dynamic class MiddleCursorEffect extends MovieClip
   {
      
      public function MiddleCursorEffect()
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

