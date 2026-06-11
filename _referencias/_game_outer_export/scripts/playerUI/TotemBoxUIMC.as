package playerUI
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1228")]
   public dynamic class TotemBoxUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var bgBox:MovieClip;
      
      public var tabOffer:TableButton;
      
      public var txtReamark:TextField;
      
      public var point:MovieClip;
      
      public var childrenPoint:MovieClip;
      
      public var txtDayStage:TextField;
      
      public var titleBox:MovieClip;
      
      public var tabTrial:TableButton;
      
      public var txtLv:TextField;
      
      public var txtDayAttr:TextField;
      
      public var list:MJList;
      
      public var cmdClose:SimpleButton;
      
      public var cmdOpen:MainButton;
      
      public var txtStage:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var tabEvolve:TableButton;
      
      public var txtDayLv:TextField;
      
      public var effectPoint:MovieClip;
      
      public function TotemBoxUIMC()
      {
         super();
         obf_w_V_1860();
      }
      
      internal function obf_w_V_1860() : *
      {
         try
         {
            cmdOpen["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOpen.emphasized = false;
         cmdOpen.enabled = true;
         cmdOpen.label = "obf___4875";
         cmdOpen.labelPlacement = "right";
         cmdOpen.selected = false;
         cmdOpen.toggle = false;
         cmdOpen.visible = true;
         try
         {
            cmdOpen["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

