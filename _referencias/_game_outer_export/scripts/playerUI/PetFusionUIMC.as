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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4251")]
   public dynamic class PetFusionUIMC extends MovieClip
   {
      
      public var bagFusionItem:IconBarMC;
      
      public var bagFusionProtect:IconBarMC;
      
      public var bagMainPet:IconBarMC;
      
      public var txtDeyConvert:TextField;
      
      public var txtDeyPrompt:TextField;
      
      public var txtDeyMainPet:TextField;
      
      public var txtDeySubPetGrowth:TextField;
      
      public var txtSubPetDApt:TextField;
      
      public var txtDeySubPetAApt:TextField;
      
      public var txtFusion:TextField;
      
      public var txtSubPetWApt:TextField;
      
      public var txtSubPetSApt:TextField;
      
      public var txtDeyMainPetAApt:TextField;
      
      public var txtConvert:TextField;
      
      public var txtDeyFusion:TextField;
      
      public var txtDeySubPetDApt:TextField;
      
      public var txtDeyFusionPrompt:TextField;
      
      public var cmdDownFusionValue:SimpleButton;
      
      public var txtDeySubPetWApt:TextField;
      
      public var txtDeyProtect:TextField;
      
      public var txtDeySubPetSApt:TextField;
      
      public var cmdDbUpFusionValue:SimpleButton;
      
      public var txtDeyMainPetDApt:TextField;
      
      public var txtDeyGeneration:TextField;
      
      public var cmdUpFusionValue:SimpleButton;
      
      public var txtMainPetAApt:TextField;
      
      public var closeButton:SimpleButton;
      
      public var txtChance:TextField;
      
      public var txtDeyMainPetWApt:TextField;
      
      public var txtDeyMainPetSApt:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var cmdDbDownFusionValue:SimpleButton;
      
      public var txtMainPetDApt:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDeyChance:TextField;
      
      public var cmdFusion:MainButton;
      
      public var txtGeneration:TextField;
      
      public var barFusionValue:MovieClip;
      
      public var txtMainPetWApt:TextField;
      
      public var txtDeyMainPetGrowth:TextField;
      
      public var txtDeySubPet:TextField;
      
      public var txtMainPetSApt:TextField;
      
      public var txtDeyProtectPrompt:TextField;
      
      public var bagSubPet:IconBarMC;
      
      public var txtSubPetAApt:TextField;
      
      public var txtSubPetGrowth:TextField;
      
      public var txtDeyFusionItem:TextField;
      
      public var txtMainPetGrowth:TextField;
      
      public var bgBox:MovieClip;
      
      public function PetFusionUIMC()
      {
         super();
         obf_S_6_1423();
      }
      
      internal function obf_S_6_1423() : *
      {
         try
         {
            cmdFusion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFusion.emphasized = false;
         cmdFusion.enabled = true;
         cmdFusion.label = "obf_____4710";
         cmdFusion.labelPlacement = "right";
         cmdFusion.selected = false;
         cmdFusion.toggle = false;
         cmdFusion.visible = true;
         try
         {
            cmdFusion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

