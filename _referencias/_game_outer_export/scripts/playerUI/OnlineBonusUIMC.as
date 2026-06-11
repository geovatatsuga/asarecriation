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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3877")]
   public dynamic class OnlineBonusUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var bonusPoint:MovieClip;
      
      public var cmdSubmit:MainButton;
      
      public var txtTime:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function OnlineBonusUIMC()
      {
         super();
         __setProp_cmdSubmit_onlineBonusUIMC_content_0();
      }
      
      internal function __setProp_cmdSubmit_onlineBonusUIMC_content_0() : *
      {
         try
         {
            cmdSubmit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSubmit.emphasized = false;
         cmdSubmit.enabled = true;
         cmdSubmit.label = "obf___4957";
         cmdSubmit.labelPlacement = "right";
         cmdSubmit.selected = false;
         cmdSubmit.toggle = false;
         cmdSubmit.visible = true;
         try
         {
            cmdSubmit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

