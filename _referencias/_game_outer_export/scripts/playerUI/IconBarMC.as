package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol319")]
   public dynamic class IconBarMC extends MovieClip
   {
      
      public var keyTip:TextField;
      
      public function IconBarMC()
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

