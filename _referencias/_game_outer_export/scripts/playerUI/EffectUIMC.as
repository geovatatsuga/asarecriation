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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4795")]
   public dynamic class EffectUIMC extends MovieClip
   {
      
      public var txtRusult:TextField;
      
      public var txtGet:TextField;
      
      public var bgbox:MovieClip;
      
      public var cmdOut:MainButton;
      
      public var pointRusult:MovieClip;
      
      public function EffectUIMC()
      {
         super();
         obf_h_R_2993();
      }
      
      internal function obf_h_R_2993() : *
      {
         try
         {
            cmdOut["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOut.emphasized = false;
         cmdOut.enabled = true;
         cmdOut.label = "Confirmar";
         cmdOut.labelPlacement = "right";
         cmdOut.selected = false;
         cmdOut.toggle = false;
         cmdOut.visible = true;
         try
         {
            cmdOut["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

