package playerUI.roulette
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5328")]
   public dynamic class StartEffect extends MovieClip
   {
      
      public function StartEffect()
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

