package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1075")]
   public dynamic class BoothBfmViewUIMC extends MovieClip
   {
      
      public var pointItems:MovieClip;
      
      public var scrollItems:UIScrollBar;
      
      public function BoothBfmViewUIMC()
      {
         super();
         obf_j_J_2610();
      }
      
      internal function obf_j_J_2610() : *
      {
         try
         {
            scrollItems["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollItems.direction = "vertical";
         scrollItems.scrollTargetName = "InstanceName_0";
         scrollItems.visible = true;
         try
         {
            scrollItems["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

