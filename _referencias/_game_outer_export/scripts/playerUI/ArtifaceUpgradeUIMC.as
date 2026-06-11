package playerUI
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2412")]
   public dynamic class ArtifaceUpgradeUIMC extends MovieClip
   {
      
      public var bagUpgrade4:IconBarMC;
      
      public var bagUpgrade5:IconBarMC;
      
      public var bagUpgrade0:IconBarMC;
      
      public var bagUpgrade2:IconBarMC;
      
      public var txtDeyPlayerView:TextField;
      
      public var txtRemark:TextField;
      
      public var pointPlayerView:MovieClip;
      
      public var cmdArtifactUpgrade:MainButton;
      
      public var txtUpgradeChance:TextField;
      
      public var bagArtifactUpgraded:IconBarMC;
      
      public var txtDeyArtifactUpgraded:TextField;
      
      public var bagUpgradeArtifact:IconBarMC;
      
      public var txtNeedRefine:TextField;
      
      public var txtDeyPushUpgrade:TextField;
      
      public var txtDeyUpgrade:TextField;
      
      public var bagUpgrade1:IconBarMC;
      
      public var bagUpgrade3:IconBarMC;
      
      public function ArtifaceUpgradeUIMC()
      {
         super();
         obf_z_m_3683();
      }
      
      internal function obf_z_m_3683() : *
      {
         try
         {
            cmdArtifactUpgrade["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdArtifactUpgrade.emphasized = false;
         cmdArtifactUpgrade.enabled = true;
         cmdArtifactUpgrade.label = "obf_____4819";
         cmdArtifactUpgrade.labelPlacement = "right";
         cmdArtifactUpgrade.selected = false;
         cmdArtifactUpgrade.toggle = false;
         cmdArtifactUpgrade.visible = true;
         try
         {
            cmdArtifactUpgrade["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

