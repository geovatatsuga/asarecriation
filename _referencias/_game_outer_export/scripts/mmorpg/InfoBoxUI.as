package mmorpg
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol193")]
   public dynamic class InfoBoxUI extends MovieClip
   {
      
      public var txtContent:TextField;
      
      public var scrollInfo:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function InfoBoxUI()
      {
         super();
         obf_0_9_G_266();
      }
      
      internal function obf_0_9_G_266() : *
      {
         try
         {
            scrollInfo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollInfo.direction = "vertical";
         scrollInfo.scrollTargetName = "txtContent";
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

