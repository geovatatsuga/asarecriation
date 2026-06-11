package somcUI_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1688")]
   public dynamic class addSpNumber_462 extends MovieClip
   {
      
      public var txtSp:TextField;
      
      public function addSpNumber_462()
      {
         super();
         addFrameScript(0,frame1,39,frame40);
      }
      
      internal function frame40() : *
      {
         txtSp.text = "";
         stop();
      }
      
      internal function frame1() : *
      {
         txtSp.mouseEnabled = false;
      }
   }
}

