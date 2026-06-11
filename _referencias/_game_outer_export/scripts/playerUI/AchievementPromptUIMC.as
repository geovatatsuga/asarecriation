package playerUI
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4800")]
   public dynamic class AchievementPromptUIMC extends MovieClip
   {
      
      public var txtDeyTitle:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtContent:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function AchievementPromptUIMC()
      {
         super();
         addFrameScript(29,frame30);
      }
      
      internal function frame30() : *
      {
         stop();
      }
   }
}

