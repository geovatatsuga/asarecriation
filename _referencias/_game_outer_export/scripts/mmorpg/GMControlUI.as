package mmorpg
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1540")]
   public dynamic class GMControlUI extends MovieClip
   {
      
      public var labelScroll:UIScrollBar;
      
      public var txtLabel:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtInput:MJInput;
      
      public var cmdClose:SimpleButton;
      
      public function GMControlUI()
      {
         super();
         __setProp_labelScroll_GMContorl_txt_0();
      }
      
      internal function __setProp_labelScroll_GMContorl_txt_0() : *
      {
         try
         {
            labelScroll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         labelScroll.direction = "vertical";
         labelScroll.scrollTargetName = "txtLabel";
         labelScroll.visible = true;
         try
         {
            labelScroll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

