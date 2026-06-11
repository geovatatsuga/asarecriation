package playerUI
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1312")]
   public dynamic class DPSRecorderBox extends MovieClip
   {
      
      public var txtPlayer:TextField;
      
      public var barDPS:MovieClip;
      
      public var txtDPS:TextField;
      
      public function DPSRecorderBox()
      {
         super();
      }
   }
}

