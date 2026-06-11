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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2322")]
   public dynamic class RenewListUIMC extends MovieClip
   {
      
      public var scrollItem:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdResult:MainButton;
      
      public var itemPoint:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function RenewListUIMC()
      {
         super();
         obf_r_L_2871();
      }
      
      internal function obf_r_L_2871() : *
      {
         try
         {
            cmdResult["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdResult.emphasized = false;
         cmdResult.enabled = true;
         cmdResult.label = "obf___4893";
         cmdResult.labelPlacement = "right";
         cmdResult.selected = false;
         cmdResult.toggle = false;
         cmdResult.visible = true;
         try
         {
            cmdResult["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

