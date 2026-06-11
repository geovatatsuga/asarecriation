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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3350")]
   public dynamic class NpcShopUIMC extends MovieClip
   {
      
      public var scrollItem:UIScrollBar;
      
      public var pointItem:MovieClip;
      
      public var cmdRepair:MainButton;
      
      public var cmdSell:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdRepairAll:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var pointPage:MovieClip;
      
      public function NpcShopUIMC()
      {
         super();
         obf_t_I_2431();
         obf_0_4_r_91();
         obf_Z_M_2817();
      }
      
      internal function obf_0_4_r_91() : *
      {
         try
         {
            cmdRepair["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRepair.emphasized = false;
         cmdRepair.enabled = true;
         cmdRepair.label = "obf___4930";
         cmdRepair.labelPlacement = "right";
         cmdRepair.selected = false;
         cmdRepair.toggle = false;
         cmdRepair.visible = true;
         try
         {
            cmdRepair["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Z_M_2817() : *
      {
         try
         {
            cmdRepairAll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRepairAll.emphasized = false;
         cmdRepairAll.enabled = true;
         cmdRepairAll.label = "obf_____4754";
         cmdRepairAll.labelPlacement = "right";
         cmdRepairAll.selected = false;
         cmdRepairAll.toggle = false;
         cmdRepairAll.visible = true;
         try
         {
            cmdRepairAll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_t_I_2431() : *
      {
         try
         {
            cmdSell["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSell.emphasized = false;
         cmdSell.enabled = true;
         cmdSell.label = "obf___4931";
         cmdSell.labelPlacement = "right";
         cmdSell.selected = false;
         cmdSell.toggle = false;
         cmdSell.visible = true;
         try
         {
            cmdSell["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

