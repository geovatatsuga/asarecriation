package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4278")]
   public dynamic class iconBarNen extends MovieClip
   {
      
      public var keyTip:TextField;
      
      public function iconBarNen()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

