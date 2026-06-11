package mapCommon
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol250")]
   public dynamic class TalkBox extends MovieClip
   {
      
      public var fromBox:MovieClip;
      
      public var txtLabel:TextField;
      
      public var bgBox:MovieClip;
      
      public function TalkBox()
      {
         super();
      }
   }
}

