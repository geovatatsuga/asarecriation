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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol672")]
   public dynamic class ArtifactFusionUIMC extends MovieClip
   {
      
      public var txtDeyPushWash:TextField;
      
      public var txtWashProgress:TextField;
      
      public var txtAddFusionAttr:TextField;
      
      public var txtDeyPushWashMaterial:TextField;
      
      public var txtDeyWashProgress:TextField;
      
      public var cmdFusionArtifact:MainButton;
      
      public var bagFusionArtifact:IconBarMC;
      
      public var barWashProgress:MovieClip;
      
      public var bagWashMaterial0:IconBarMC;
      
      public var bagWashMaterial1:IconBarMC;
      
      public var txtDeyWashRemark:TextField;
      
      public var cmdWashArtifact:MainButton;
      
      public var txtDeyAddFusionAttr:TextField;
      
      public var bagFusionWeapon:IconBarMC;
      
      public var txtDeyFusionMaterial:TextField;
      
      public var txtFusionRemark:TextField;
      
      public var txtDeyPushFusion:TextField;
      
      public var bagWashArtifact:IconBarMC;
      
      public var bagFusionMaterial:IconBarMC;
      
      public var txtDeyPushWeapon:TextField;
      
      public function ArtifactFusionUIMC()
      {
         super();
         obf_Y_p_2733();
         obf_b_e_1160();
      }
      
      internal function obf_b_e_1160() : *
      {
         try
         {
            cmdWashArtifact["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdWashArtifact.emphasized = false;
         cmdWashArtifact.enabled = true;
         cmdWashArtifact.label = "obf_____4797";
         cmdWashArtifact.labelPlacement = "right";
         cmdWashArtifact.selected = false;
         cmdWashArtifact.toggle = false;
         cmdWashArtifact.visible = true;
         try
         {
            cmdWashArtifact["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Y_p_2733() : *
      {
         try
         {
            cmdFusionArtifact["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFusionArtifact.emphasized = false;
         cmdFusionArtifact.enabled = true;
         cmdFusionArtifact.label = "obf_____4786";
         cmdFusionArtifact.labelPlacement = "right";
         cmdFusionArtifact.selected = false;
         cmdFusionArtifact.toggle = false;
         cmdFusionArtifact.visible = true;
         try
         {
            cmdFusionArtifact["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

