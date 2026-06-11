package playerUI
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol750")]
   public dynamic class RewardBGUIMC extends MovieClip
   {
      
      public var pointChildUI:MovieClip;
      
      public var cmdPlayerTask:MovieClip;
      
      public var txtInfo:TextField;
      
      public var txtTitle:TextField;
      
      public var cmdPlayerInfo:MovieClip;
      
      public var cmdAllTask:MovieClip;
      
      public var cmdShop:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdSuccess:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function RewardBGUIMC()
      {
         super();
      }
   }
}

