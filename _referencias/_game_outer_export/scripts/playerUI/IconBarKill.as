package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4281")]
   public dynamic class IconBarKill extends MovieClip
   {
      
      public var keyTip:TextField;
      
      public function IconBarKill()
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

