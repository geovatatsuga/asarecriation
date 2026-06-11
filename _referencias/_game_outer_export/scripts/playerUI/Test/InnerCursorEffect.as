package playerUI.Test
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5306")]
   public dynamic class InnerCursorEffect extends MovieClip
   {
      
      public function InnerCursorEffect()
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

