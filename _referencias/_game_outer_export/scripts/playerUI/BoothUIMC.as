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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1106")]
   public dynamic class BoothUIMC extends MovieClip
   {
      
      public var pointUI:MovieClip;
      
      public var inputBoothTitle:TextField;
      
      public var bgBox:MovieClip;
      
      public var saleTab:TableButton;
      
      public var cmdAction:MainButton;
      
      public var titleBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var bfmTab:TableButton;
      
      public var cmdClose:SimpleButton;
      
      public function BoothUIMC()
      {
         super();
         obf_Z_N_3597();
      }
      
      internal function obf_Z_N_3597() : *
      {
         try
         {
            cmdAction["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAction.emphasized = false;
         cmdAction.enabled = true;
         cmdAction.label = "obf___4911";
         cmdAction.labelPlacement = "right";
         cmdAction.selected = false;
         cmdAction.toggle = false;
         cmdAction.visible = true;
         try
         {
            cmdAction["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

