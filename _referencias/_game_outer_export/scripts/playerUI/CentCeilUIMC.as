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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5121")]
   public dynamic class CentCeilUIMC extends MovieClip
   {
      
      public var iconBar:IconBarMC;
      
      public var cmdBuy:MainButton;
      
      public var txtCent:TextField;
      
      public function CentCeilUIMC()
      {
         super();
         obf_C_i_1117();
      }
      
      internal function obf_C_i_1117() : *
      {
         try
         {
            cmdBuy["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuy.emphasized = false;
         cmdBuy.enabled = true;
         cmdBuy.label = "obf___4920";
         cmdBuy.labelPlacement = "right";
         cmdBuy.selected = false;
         cmdBuy.toggle = false;
         cmdBuy.visible = true;
         try
         {
            cmdBuy["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

