package playerUI
{
   import fl.controls.UIScrollBar;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1314")]
   public dynamic class DPSRecorderUIMC extends MovieClip
   {
      
      public var barMyDPS:DPSRecorderBox;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var pointDPS:MovieClip;
      
      public var obf_1_y_4406:UIScrollBar;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyTitle:TextField;
      
      public function DPSRecorderUIMC()
      {
         super();
      }
   }
}

