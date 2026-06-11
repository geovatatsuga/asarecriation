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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3051")]
   public dynamic class BoothSellUIMC extends MovieClip
   {
      
      public var pointItems:MovieClip;
      
      public var InstanceName_0:MovieClip;
      
      public var scrollItems:UIScrollBar;
      
      public function BoothSellUIMC()
      {
         super();
         obf_h_5_1832();
      }
      
      internal function obf_h_5_1832() : *
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

