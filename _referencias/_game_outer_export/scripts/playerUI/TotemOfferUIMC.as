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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3448")]
   public dynamic class TotemOfferUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var cmdOffer:MainButton;
      
      public var iconBar1:IconBarMC;
      
      public var txtNextDayAttr:TextField;
      
      public var txtNameAttr:TextField;
      
      public var goldPoint:MovieClip;
      
      public var txtNextAttr:TextField;
      
      public var iconBar2:IconBarMC;
      
      public var iconBar3:IconBarMC;
      
      public var txtDayAttr:TextField;
      
      public var txtNameNextAttr:TextField;
      
      public function TotemOfferUIMC()
      {
         super();
         obf_F_Y_4133();
      }
      
      internal function obf_F_Y_4133() : *
      {
         try
         {
            cmdOffer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOffer.emphasized = false;
         cmdOffer.enabled = true;
         cmdOffer.label = "obf___4936";
         cmdOffer.labelPlacement = "right";
         cmdOffer.selected = false;
         cmdOffer.toggle = false;
         cmdOffer.visible = true;
         try
         {
            cmdOffer["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

