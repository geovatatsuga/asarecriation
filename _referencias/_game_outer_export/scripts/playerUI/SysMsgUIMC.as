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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4420")]
   public dynamic class SysMsgUIMC extends MovieClip
   {
      
      public var cmdPrv:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txtContent:TextField;
      
      public var scrollContent:UIScrollBar;
      
      public var cmdNext:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdTop:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public function SysMsgUIMC()
      {
         super();
         __setProp_scrollContent_sysmsgUIMC_content_0();
         __setProp_cmdPrv_sysmsgUIMC_content_0();
         __setProp_cmdNext_sysmsgUIMC_content_0();
         __setProp_cmdTop_sysmsgUIMC_content_0();
      }
      
      internal function __setProp_cmdTop_sysmsgUIMC_content_0() : *
      {
         try
         {
            cmdTop["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTop.emphasized = false;
         cmdTop.enabled = true;
         cmdTop.label = "obf___4955";
         cmdTop.labelPlacement = "right";
         cmdTop.selected = false;
         cmdTop.toggle = false;
         cmdTop.visible = true;
         try
         {
            cmdTop["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdPrv_sysmsgUIMC_content_0() : *
      {
         try
         {
            cmdPrv["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrv.emphasized = false;
         cmdPrv.enabled = true;
         cmdPrv.label = "<obf____4858";
         cmdPrv.labelPlacement = "right";
         cmdPrv.selected = false;
         cmdPrv.toggle = false;
         cmdPrv.visible = true;
         try
         {
            cmdPrv["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdNext_sysmsgUIMC_content_0() : *
      {
         try
         {
            cmdNext["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNext.emphasized = false;
         cmdNext.enabled = true;
         cmdNext.label = "obf____4854>";
         cmdNext.labelPlacement = "right";
         cmdNext.selected = false;
         cmdNext.toggle = false;
         cmdNext.visible = true;
         try
         {
            cmdNext["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_scrollContent_sysmsgUIMC_content_0() : *
      {
         try
         {
            scrollContent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollContent.direction = "vertical";
         scrollContent.scrollTargetName = "txtContent";
         scrollContent.visible = true;
         try
         {
            scrollContent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

