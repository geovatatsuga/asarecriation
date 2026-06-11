package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5011")]
   public dynamic class SplitBoxUIMC extends MovieClip
   {
      
      public var cmdLeft:SimpleButton;
      
      public var cmdCancle:MainButton;
      
      public var cmdRight:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var goldPoint:MovieClip;
      
      public var cmdOK:MainButton;
      
      public var txtInput:MJInput;
      
      public function SplitBoxUIMC()
      {
         super();
         __setProp_txtInput_SplitBox_Input_0();
         __setProp_cmdOK_SplitBox_button_0();
         __setProp_cmdCancle_SplitBox_button_0();
      }
      
      internal function __setProp_cmdOK_SplitBox_button_0() : *
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
      
      internal function __setProp_txtInput_SplitBox_Input_0() : *
      {
         try
         {
            txtInput["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtInput.displayAsPassword = false;
         txtInput.editable = true;
         txtInput.enabled = true;
         txtInput.maxChars = 0;
         txtInput.restrict = "0-9";
         txtInput.text = "";
         txtInput.visible = true;
         try
         {
            txtInput["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdCancle_SplitBox_button_0() : *
      {
         try
         {
            cmdCancle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancle.emphasized = false;
         cmdCancle.enabled = true;
         cmdCancle.label = "obf___4932";
         cmdCancle.labelPlacement = "right";
         cmdCancle.selected = false;
         cmdCancle.toggle = false;
         cmdCancle.visible = true;
         try
         {
            cmdCancle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

