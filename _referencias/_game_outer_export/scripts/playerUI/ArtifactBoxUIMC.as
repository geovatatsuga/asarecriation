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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1357")]
   public dynamic class ArtifactBoxUIMC extends MovieClip
   {
      
      public var pointUI:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdArtifactFusion:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdArtifactUpgrade:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyTitle:TextField;
      
      public function ArtifactBoxUIMC()
      {
         super();
         obf_V_r_1168();
         obf_M_K_2926();
      }
      
      internal function obf_V_r_1168() : *
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
      
      internal function obf_M_K_2926() : *
      {
         try
         {
            cmdArtifactFusion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdArtifactFusion.emphasized = false;
         cmdArtifactFusion.enabled = true;
         cmdArtifactFusion.label = "obf_____4786";
         cmdArtifactFusion.labelPlacement = "right";
         cmdArtifactFusion.selected = false;
         cmdArtifactFusion.toggle = false;
         cmdArtifactFusion.visible = true;
         try
         {
            cmdArtifactFusion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

