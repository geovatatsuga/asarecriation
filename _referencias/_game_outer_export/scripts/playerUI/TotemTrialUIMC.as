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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4092")]
   public dynamic class TotemTrialUIMC extends MovieClip
   {
      
      public var cmdEnter:MainButton;
      
      public function TotemTrialUIMC()
      {
         super();
         obf_O_t_3533();
      }
      
      internal function obf_O_t_3533() : *
      {
         try
         {
            cmdEnter["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEnter.emphasized = false;
         cmdEnter.enabled = true;
         cmdEnter.label = "obf______4629";
         cmdEnter.labelPlacement = "right";
         cmdEnter.selected = false;
         cmdEnter.toggle = false;
         cmdEnter.visible = true;
         try
         {
            cmdEnter["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

