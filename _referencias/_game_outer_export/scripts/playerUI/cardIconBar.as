package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4404")]
   public dynamic class cardIconBar extends MovieClip
   {
      
      public var keyTip:TextField;
      
      public function cardIconBar()
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

