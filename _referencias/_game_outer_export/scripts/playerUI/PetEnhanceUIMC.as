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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol686")]
   public dynamic class PetEnhanceUIMC extends MovieClip
   {
      
      public var txtDeyStrengthApt:TextField;
      
      public var txtDeyBeforeEnhance:TextField;
      
      public var txtVitalityAptAfter:TextField;
      
      public var barWisdomAptAfter:MovieClip;
      
      public var barPet:IconBarMC;
      
      public var barStrengthApt:MovieClip;
      
      public var txtVitalityApt:TextField;
      
      public var barVitalityApt:MovieClip;
      
      public var barAgilityApt:MovieClip;
      
      public var txtWisdomApt:TextField;
      
      public var txtPetEnhance:TextField;
      
      public var txtDeyVitalityAptAfter:TextField;
      
      public var cmdEnhance:MainButton;
      
      public var txtAgilityAptAfter:TextField;
      
      public var txtDeyCostItem:TextField;
      
      public var barAgilityAptAfter:MovieClip;
      
      public var txtStrengthApt:TextField;
      
      public var txtAgilityApt:TextField;
      
      public var barVitalityAptAfter:MovieClip;
      
      public var barCostItem:IconBarMC;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyWisdomAptAfter:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDeyStrengthAptAfter:TextField;
      
      public var txtDeyAgilityApt:TextField;
      
      public var closeButton:SimpleButton;
      
      public var barStrengthAptAfter:MovieClip;
      
      public var barWisdomApt:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtDeyAfterEnhance:TextField;
      
      public var txtDeyChance:TextField;
      
      public var txtWisdomAptAfter:TextField;
      
      public var txtStrengthAptAfter:TextField;
      
      public var txtEnhanceChance:TextField;
      
      public var txtDeyAgilityAptAfter:TextField;
      
      public var txtDeyPet:TextField;
      
      public var txtDeyVitalityApt:TextField;
      
      public var txtDeyWisdomApt:TextField;
      
      public var pointCostGold:MovieClip;
      
      public function PetEnhanceUIMC()
      {
         super();
         obf_k_j_2039();
      }
      
      internal function obf_k_j_2039() : *
      {
         try
         {
            cmdEnhance["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEnhance.emphasized = false;
         cmdEnhance.enabled = true;
         cmdEnhance.label = "obf_____4723";
         cmdEnhance.labelPlacement = "right";
         cmdEnhance.selected = false;
         cmdEnhance.toggle = false;
         cmdEnhance.visible = true;
         try
         {
            cmdEnhance["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

