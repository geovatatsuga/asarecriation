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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2400")]
   public dynamic class ManualUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdAbsorb:MainButton;
      
      public var txtDeyAllAttr:TextField;
      
      public var manualEffectMC:MovieClip;
      
      public var obf_v_b_1158:MovieClip;
      
      public var txtdeyLv:TextField;
      
      public var titleBox:MovieClip;
      
      public var iconBar1:IconBarMC;
      
      public var txtDeyAttr:TextField;
      
      public var txtLv:TextField;
      
      public var txtName:TextField;
      
      public var txtIntro:TextField;
      
      public var iconBar0:IconBarMC;
      
      public var noSeal:MovieClip;
      
      public var cmdCoerceAbsorb:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtAllAttr:TextField;
      
      public var txtRemainTimes:TextField;
      
      public var pointImage:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtAllTimes:TextField;
      
      public function ManualUIMC()
      {
         super();
         obf_a_3_4562();
         obf_H_G_1199();
      }
      
      internal function obf_H_G_1199() : *
      {
         try
         {
            cmdCoerceAbsorb["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCoerceAbsorb.emphasized = false;
         cmdCoerceAbsorb.enabled = true;
         cmdCoerceAbsorb.label = "obf_____4808";
         cmdCoerceAbsorb.labelPlacement = "right";
         cmdCoerceAbsorb.selected = false;
         cmdCoerceAbsorb.toggle = false;
         cmdCoerceAbsorb.visible = true;
         try
         {
            cmdCoerceAbsorb["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_a_3_4562() : *
      {
         try
         {
            cmdAbsorb["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAbsorb.emphasized = false;
         cmdAbsorb.enabled = true;
         cmdAbsorb.label = "obf___4947";
         cmdAbsorb.labelPlacement = "right";
         cmdAbsorb.selected = false;
         cmdAbsorb.toggle = false;
         cmdAbsorb.visible = true;
         try
         {
            cmdAbsorb["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

