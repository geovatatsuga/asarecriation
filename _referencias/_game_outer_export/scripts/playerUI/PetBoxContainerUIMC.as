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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol946")]
   public dynamic class PetBoxContainerUIMC extends MovieClip
   {
      
      public var pointChildUI:MovieClip;
      
      public var cmdPet:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdGenie:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdWardrobe:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public function PetBoxContainerUIMC()
      {
         super();
         obf_E_e_3959();
         obf_n_j_1483();
         obf_0_3_J_327();
      }
      
      internal function obf_0_3_J_327() : *
      {
         try
         {
            cmdWardrobe["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdWardrobe.emphasized = false;
         cmdWardrobe.enabled = true;
         cmdWardrobe.label = "obf____4856";
         cmdWardrobe.labelPlacement = "right";
         cmdWardrobe.selected = false;
         cmdWardrobe.toggle = false;
         cmdWardrobe.visible = true;
         try
         {
            cmdWardrobe["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_n_j_1483() : *
      {
         try
         {
            cmdGenie["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGenie.emphasized = false;
         cmdGenie.enabled = true;
         cmdGenie.label = "obf___4953";
         cmdGenie.labelPlacement = "right";
         cmdGenie.selected = false;
         cmdGenie.toggle = false;
         cmdGenie.visible = true;
         try
         {
            cmdGenie["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_e_3959() : *
      {
         try
         {
            cmdPet["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPet.emphasized = false;
         cmdPet.enabled = true;
         cmdPet.label = "obf___4866";
         cmdPet.labelPlacement = "right";
         cmdPet.selected = false;
         cmdPet.toggle = false;
         cmdPet.visible = true;
         try
         {
            cmdPet["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

