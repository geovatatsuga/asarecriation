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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol839")]
   public dynamic class DepotBagUIMC extends MovieClip
   {
      
      public var bagPage2:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var closeButton:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var cmdBagPage2:TableButton;
      
      public var cmdBagPage3:TableButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdSort:MainButton;
      
      public var bagPage1:MovieClip;
      
      public var cmdBagPage1:TableButton;
      
      public var bagPage3:MovieClip;
      
      public function DepotBagUIMC()
      {
         super();
         obf_i_f_3403();
      }
      
      internal function obf_i_f_3403() : *
      {
         try
         {
            cmdSort["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSort.emphasized = false;
         cmdSort.enabled = true;
         cmdSort.label = "obf___4939";
         cmdSort.labelPlacement = "right";
         cmdSort.selected = false;
         cmdSort.toggle = false;
         cmdSort.visible = true;
         try
         {
            cmdSort["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

