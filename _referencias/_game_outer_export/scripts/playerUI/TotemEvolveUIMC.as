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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4149")]
   public dynamic class TotemEvolveUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var iconBar1:IconBarMC;
      
      public var txtNextDayAttr:TextField;
      
      public var txtNameAttr:TextField;
      
      public var goldPoint:MovieClip;
      
      public var cmdEvolve:MainButton;
      
      public var iconBar2:IconBarMC;
      
      public var iconBar3:IconBarMC;
      
      public var txtNextAttr:TextField;
      
      public var txtDayAttr:TextField;
      
      public var txtNameNextAttr:TextField;
      
      public function TotemEvolveUIMC()
      {
         super();
         obf_h_w_2487();
      }
      
      internal function obf_h_w_2487() : *
      {
         try
         {
            cmdEvolve["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEvolve.emphasized = false;
         cmdEvolve.enabled = true;
         cmdEvolve.label = "obf___4919";
         cmdEvolve.labelPlacement = "right";
         cmdEvolve.selected = false;
         cmdEvolve.toggle = false;
         cmdEvolve.visible = true;
         try
         {
            cmdEvolve["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

