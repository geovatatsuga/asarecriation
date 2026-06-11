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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol751")]
   public dynamic class DPSRecorderMinUIMC extends MovieClip
   {
      
      public var cmdButton:MainButton;
      
      public function DPSRecorderMinUIMC()
      {
         super();
         obf_L_3341();
      }
      
      internal function obf_L_3341() : *
      {
         try
         {
            cmdButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdButton.emphasized = false;
         cmdButton.enabled = true;
         cmdButton.label = "obf_____4747";
         cmdButton.labelPlacement = "right";
         cmdButton.selected = false;
         cmdButton.toggle = false;
         cmdButton.visible = true;
         try
         {
            cmdButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

