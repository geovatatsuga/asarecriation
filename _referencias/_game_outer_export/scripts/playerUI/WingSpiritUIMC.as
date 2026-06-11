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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol526")]
   public dynamic class WingSpiritUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var attrMC1:MovieClip;
      
      public var attrMC2:MovieClip;
      
      public var attrMC3:MovieClip;
      
      public var attrMC4:MovieClip;
      
      public var attrMC5:MovieClip;
      
      public var attrMC6:MovieClip;
      
      public var attrMC7:MovieClip;
      
      public var attrMC8:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtPushWing:TextField;
      
      public var icon0:IconBarMC;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var icon3:IconBarMC;
      
      public var wingIcon:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var txtExplain:TextField;
      
      public var cmdClever:MainButton;
      
      public var cmdReset:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdSeparate:MainButton;
      
      public function WingSpiritUIMC()
      {
         super();
         obf_b_c_3497();
         obf_i_9_1945();
         obf_6_I_1038();
      }
      
      internal function obf_6_I_1038() : *
      {
         try
         {
            cmdSeparate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSeparate.emphasized = false;
         cmdSeparate.enabled = true;
         cmdSeparate.label = "obf___4887";
         cmdSeparate.labelPlacement = "right";
         cmdSeparate.selected = false;
         cmdSeparate.toggle = false;
         cmdSeparate.visible = true;
         try
         {
            cmdSeparate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_i_9_1945() : *
      {
         try
         {
            cmdReset["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReset.emphasized = false;
         cmdReset.enabled = true;
         cmdReset.label = "obf___4894";
         cmdReset.labelPlacement = "right";
         cmdReset.selected = false;
         cmdReset.toggle = false;
         cmdReset.visible = true;
         try
         {
            cmdReset["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_c_3497() : *
      {
         try
         {
            cmdClever["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdClever.emphasized = false;
         cmdClever.enabled = true;
         cmdClever.label = "obf___4951";
         cmdClever.labelPlacement = "right";
         cmdClever.selected = false;
         cmdClever.toggle = false;
         cmdClever.visible = true;
         try
         {
            cmdClever["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

