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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5049")]
   public dynamic class ItemManualCeilUIMC extends MovieClip
   {
      
      public var txtValue:TextField;
      
      public var txtCond:TextField;
      
      public var bar:MovieClip;
      
      public var iconBar1:ItemManualIcon;
      
      public var iconBar:IconBarMC;
      
      public var txtName:TextField;
      
      public var cmdGet:MainButton;
      
      public var itemPoint:MovieClip;
      
      public function ItemManualCeilUIMC()
      {
         super();
         obf_l_G_790();
      }
      
      internal function obf_l_G_790() : *
      {
         try
         {
            cmdGet["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGet.emphasized = false;
         cmdGet.enabled = true;
         cmdGet.label = "obf___4957";
         cmdGet.labelPlacement = "right";
         cmdGet.selected = false;
         cmdGet.toggle = false;
         cmdGet.visible = true;
         try
         {
            cmdGet["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

