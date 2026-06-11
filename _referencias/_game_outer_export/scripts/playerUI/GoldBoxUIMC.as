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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5188")]
   public dynamic class GoldBoxUIMC extends MovieClip
   {
      
      public var inputCopper:MJInput;
      
      public var txtTitle:TextField;
      
      public var inputDiamond:MJInput;
      
      public var bgBox:MovieClip;
      
      public var inputGold:MJInput;
      
      public var cmdOK:MainButton;
      
      public var inputSilver:MJInput;
      
      public var cmdClose:SimpleButton;
      
      public function GoldBoxUIMC()
      {
         super();
         obf_s_O_1433();
         obf_B_G_2988();
         obf_H_3_1750();
         obf_h_V_4557();
         obf_0_4_3177();
      }
      
      internal function obf_h_V_4557() : *
      {
         try
         {
            inputDiamond["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputDiamond.displayAsPassword = false;
         inputDiamond.editable = true;
         inputDiamond.enabled = true;
         inputDiamond.maxChars = 2;
         inputDiamond.restrict = "0-9";
         inputDiamond.text = "";
         inputDiamond.visible = true;
         try
         {
            inputDiamond["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_3_1750() : *
      {
         try
         {
            inputGold["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputGold.displayAsPassword = false;
         inputGold.editable = true;
         inputGold.enabled = true;
         inputGold.maxChars = 2;
         inputGold.restrict = "0-9";
         inputGold.text = "";
         inputGold.visible = true;
         try
         {
            inputGold["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_O_1433() : *
      {
         try
         {
            inputCopper["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputCopper.displayAsPassword = false;
         inputCopper.editable = true;
         inputCopper.enabled = true;
         inputCopper.maxChars = 2;
         inputCopper.restrict = "0-9";
         inputCopper.text = "";
         inputCopper.visible = true;
         try
         {
            inputCopper["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_3177() : *
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
      
      internal function obf_B_G_2988() : *
      {
         try
         {
            inputSilver["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputSilver.displayAsPassword = false;
         inputSilver.editable = true;
         inputSilver.enabled = true;
         inputSilver.maxChars = 2;
         inputSilver.restrict = "0-9";
         inputSilver.text = "";
         inputSilver.visible = true;
         try
         {
            inputSilver["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

