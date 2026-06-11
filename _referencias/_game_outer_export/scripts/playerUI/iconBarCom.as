package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4284")]
   public dynamic class iconBarCom extends MovieClip
   {
      
      public var keyTip:TextField;
      
      public function iconBarCom()
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

