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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3860")]
   public dynamic class BoothItemUIMC extends MovieClip
   {
      
      public var inputCopper:MJInput;
      
      public var bg:MovieClip;
      
      public var inputGold:MJInput;
      
      public var cmdCancel:MainButton;
      
      public var iconBar:IconBarMC;
      
      public var txtName:TextField;
      
      public var inputNum:MJInput;
      
      public var inputDiamond:MJInput;
      
      public var txtNub:TextField;
      
      public var cmdValidate:MainButton;
      
      public var inputName:MJInput;
      
      public var inputSilver:MJInput;
      
      public var txtPrice:TextField;
      
      public var cmdOk:MainButton;
      
      public function BoothItemUIMC()
      {
         super();
         obf_f_g_4057();
         obf_X_u_3843();
         obf_S_y_1220();
         obf_5_Y_2347();
         obf_j_O_4264();
         obf_9_4_3447();
         obf_s_Z_3045();
         obf_E_K_2882();
      }
      
      internal function obf_s_Z_3045() : *
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
      
      internal function obf_j_O_4264() : *
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
      
      internal function obf_9_4_3447() : *
      {
         try
         {
            cmdOk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOk.emphasized = false;
         cmdOk.enabled = true;
         cmdOk.label = "obf___4891";
         cmdOk.labelPlacement = "right";
         cmdOk.selected = false;
         cmdOk.toggle = false;
         cmdOk.visible = true;
         try
         {
            cmdOk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_K_2882() : *
      {
         try
         {
            cmdValidate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdValidate.emphasized = false;
         cmdValidate.enabled = true;
         cmdValidate.label = "obf___4979";
         cmdValidate.labelPlacement = "right";
         cmdValidate.selected = false;
         cmdValidate.toggle = false;
         cmdValidate.visible = true;
         try
         {
            cmdValidate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_g_4057() : *
      {
         try
         {
            inputNum["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputNum.displayAsPassword = false;
         inputNum.editable = true;
         inputNum.enabled = true;
         inputNum.maxChars = 0;
         inputNum.restrict = "0-9";
         inputNum.text = "1";
         inputNum.visible = true;
         try
         {
            inputNum["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_S_y_1220() : *
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
      
      internal function obf_X_u_3843() : *
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
      
      internal function obf_5_Y_2347() : *
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
   }
}

