package playerUI
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3145")]
   public dynamic class SoulWeaponBoxUIMC extends MovieClip
   {
      
      public var cmdUpgrade:TableButton;
      
      public var cmdLevelUp:TableButton;
      
      public var cmdEmbed:TableButton;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var pointSoulWeapon:MovieClip;
      
      public function SoulWeaponBoxUIMC()
      {
         super();
      }
   }
}

