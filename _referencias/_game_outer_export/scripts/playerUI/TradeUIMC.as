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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1271")]
   public dynamic class TradeUIMC extends MovieClip
   {
      
      public var txtDeyTargetItems:TextField;
      
      public var tBag10:IconBarMC;
      
      public var tBag11:IconBarMC;
      
      public var tBag12:IconBarMC;
      
      public var tBag13:IconBarMC;
      
      public var tBag14:IconBarMC;
      
      public var tBag15:IconBarMC;
      
      public var inputDiamond:MJInput;
      
      public var cmdClear:MainButton;
      
      public var obf_8_s_2454:MovieClip;
      
      public var mBag0:IconBarMC;
      
      public var mBag1:IconBarMC;
      
      public var mBag2:IconBarMC;
      
      public var mBag3:IconBarMC;
      
      public var mBag4:IconBarMC;
      
      public var mBag5:IconBarMC;
      
      public var mBag6:IconBarMC;
      
      public var mBag7:IconBarMC;
      
      public var mBag9:IconBarMC;
      
      public var pointTargetGold:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var inputGold:MJInput;
      
      public var mBag8:IconBarMC;
      
      public var inputSilver:MJInput;
      
      public var inputCopper:MJInput;
      
      public var cmdReady:MainButton;
      
      public var cmdOK:MainButton;
      
      public var txtPlayerName:TextField;
      
      public var mBag10:IconBarMC;
      
      public var mBag11:IconBarMC;
      
      public var tBag1:IconBarMC;
      
      public var mBag14:IconBarMC;
      
      public var mBag15:IconBarMC;
      
      public var tBag4:IconBarMC;
      
      public var tBag5:IconBarMC;
      
      public var tBag6:IconBarMC;
      
      public var tBag8:IconBarMC;
      
      public var tBag9:IconBarMC;
      
      public var tBag3:IconBarMC;
      
      public var tBag7:IconBarMC;
      
      public var tBag0:IconBarMC;
      
      public var txtDeyMyItems:TextField;
      
      public var tBag2:IconBarMC;
      
      public var obf_k_Q_2459:MovieClip;
      
      public var mBag12:IconBarMC;
      
      public var mBag13:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public function TradeUIMC()
      {
         super();
         obf_0_3_T_457();
         obf_f_i_3359();
         obf_u_n_2409();
         obf_o_U_1436();
         obf_v_M_3996();
         obf_5_x_1592();
         obf_S_r_3074();
      }
      
      internal function obf_v_M_3996() : *
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
      
      internal function obf_0_3_T_457() : *
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
      
      internal function obf_S_r_3074() : *
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
      
      internal function obf_f_i_3359() : *
      {
         try
         {
            cmdReady["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReady.emphasized = false;
         cmdReady.enabled = true;
         cmdReady.label = "obf___4863";
         cmdReady.labelPlacement = "right";
         cmdReady.selected = false;
         cmdReady.toggle = false;
         cmdReady.visible = true;
         try
         {
            cmdReady["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_5_x_1592() : *
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
      
      internal function obf_u_n_2409() : *
      {
         try
         {
            cmdClear["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdClear.emphasized = false;
         cmdClear.enabled = true;
         cmdClear.label = "obf___4902";
         cmdClear.labelPlacement = "right";
         cmdClear.selected = false;
         cmdClear.toggle = false;
         cmdClear.visible = true;
         try
         {
            cmdClear["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_o_U_1436() : *
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
         inputDiamond.maxChars = 3;
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
   }
}

