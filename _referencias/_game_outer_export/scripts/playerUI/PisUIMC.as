package playerUI
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2020")]
   public dynamic class PisUIMC extends MovieClip
   {
      
      public var inputIDCard:SimpleButton;
      
      public var txtPisPrompt:TextField;
      
      public function PisUIMC()
      {
         super();
      }
   }
}

