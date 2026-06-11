package mmorpg
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5186")]
   public dynamic class InputAreaUIMC extends MovieClip
   {
      
      public var obf_0_1_i_305:UIScrollBar;
      
      public var cmdCancel:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var cmdOK:MainButton;
      
      public var txtInput:TextField;
      
      public var txtPrompt:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function InputAreaUIMC()
      {
         super();
         obf_2_m_2051();
         obf_Q_C_2315();
         obf_V_D_4560();
      }
      
      internal function obf_2_m_2051() : *
      {
         try
         {
            cmdOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOK.emphasized = false;
         cmdOK.enabled = true;
         cmdOK.label = "obf___4891";
         cmdOK.labelPlacement = "right";
         cmdOK.selected = false;
         cmdOK.toggle = false;
         cmdOK.visible = true;
         try
         {
            cmdOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Q_C_2315() : *
      {
         try
         {
            cmdCancel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancel.emphasized = false;
         cmdCancel.enabled = true;
         cmdCancel.label = "obf___4932";
         cmdCancel.labelPlacement = "right";
         cmdCancel.selected = false;
         cmdCancel.toggle = false;
         cmdCancel.visible = true;
         try
         {
            cmdCancel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_D_4560() : *
      {
         try
         {
            obf_0_1_i_305["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_0_1_i_305.direction = "vertical";
         obf_0_1_i_305.scrollTargetName = "txtInput";
         obf_0_1_i_305.visible = true;
         try
         {
            obf_0_1_i_305["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

