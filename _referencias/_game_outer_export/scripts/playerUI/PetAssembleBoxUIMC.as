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
   import mcRes.AssembleLuckBox;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3455")]
   public dynamic class PetAssembleBoxUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var targetPetBagMC:IconBarMC;
      
      public var closeButton:SimpleButton;
      
      public var txtPetImage:TextField;
      
      public var txtDeyMaterial:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyPrompt:TextField;
      
      public var obf_Q_0_1896:AssembleLuckBox;
      
      public var pointTargetPetImage:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var pointPetImage:MovieClip;
      
      public var materialBagMC:IconBarMC;
      
      public var cmdAssPet:MainButton;
      
      public var txtChanse:TextField;
      
      public var txtTargetPetImage:TextField;
      
      public var petBagMC:IconBarMC;
      
      public function PetAssembleBoxUIMC()
      {
         super();
         obf_f_o_4039();
      }
      
      internal function obf_f_o_4039() : *
      {
         try
         {
            cmdAssPet["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAssPet.emphasized = false;
         cmdAssPet.enabled = true;
         cmdAssPet.label = "obf_____4727";
         cmdAssPet.labelPlacement = "right";
         cmdAssPet.selected = false;
         cmdAssPet.toggle = false;
         cmdAssPet.visible = true;
         try
         {
            cmdAssPet["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

