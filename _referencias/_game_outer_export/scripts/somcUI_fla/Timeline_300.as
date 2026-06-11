package somcUI_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3952")]
   public dynamic class Timeline_300 extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var cmdHide:SimpleButton;
      
      public var cmdResize:SimpleButton;
      
      public var scrollInfo:UIScrollBar;
      
      public var scopeLayer:MovieClip;
      
      public var txtInfo:TextField;
      
      public function Timeline_300()
      {
         super();
         obf_V_O_1956();
      }
      
      internal function obf_V_O_1956() : *
      {
         try
         {
            scrollInfo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollInfo.direction = "vertical";
         scrollInfo.scrollTargetName = "txtInfo";
         scrollInfo.visible = true;
         try
         {
            scrollInfo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

