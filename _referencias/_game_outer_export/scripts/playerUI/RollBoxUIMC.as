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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5259")]
   public dynamic class RollBoxUIMC extends MovieClip
   {
      
      public var iconBar:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var cmdQuit:MainButton;
      
      public var barTime:MovieClip;
      
      public var cmdNeed:MainButton;
      
      public function RollBoxUIMC()
      {
         super();
         obf_0_8_i_108();
         obf_Y_k_2897();
      }
      
      internal function obf_Y_k_2897() : *
      {
         try
         {
            cmdQuit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdQuit.emphasized = false;
         cmdQuit.enabled = true;
         cmdQuit.label = "Pass";
         cmdQuit.labelPlacement = "right";
         cmdQuit.selected = false;
         cmdQuit.toggle = false;
         cmdQuit.visible = true;
         try
         {
            cmdQuit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_i_108() : *
      {
         try
         {
            cmdNeed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNeed.emphasized = false;
         cmdNeed.enabled = true;
         cmdNeed.label = "Need";
         cmdNeed.labelPlacement = "right";
         cmdNeed.selected = false;
         cmdNeed.toggle = false;
         cmdNeed.visible = true;
         try
         {
            cmdNeed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

