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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol944")]
   public dynamic class IncubatorUIMC extends MovieClip
   {
      
      public var txtDifValue:TextField;
      
      public var txtTimeValue:TextField;
      
      public var txtRankValue:TextField;
      
      public var txtAllAttrValue0:TextField;
      
      public var txtThisTemp:TextField;
      
      public var txtAllAttrValue2:TextField;
      
      public var txtAllAttrValue3:TextField;
      
      public var txtAllAttrValue4:TextField;
      
      public var txtAllAttrValue5:TextField;
      
      public var txtAllAttrValue6:TextField;
      
      public var txtAllAttrValue8:TextField;
      
      public var txtAllAttrValue9:TextField;
      
      public var txtAttrNameValue:TextField;
      
      public var cmdTemp:MainButton;
      
      public var txtAllAttrValue7:TextField;
      
      public var txtAllAttrValue1:TextField;
      
      public var txtAllAttr10:TextField;
      
      public var txtAllAttr11:TextField;
      
      public var txtAllAttrValue10:TextField;
      
      public var txtAllAttrValue11:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtCountdownValue:TextField;
      
      public var txtTemp:TextField;
      
      public var txtThisTempValue:TextField;
      
      public var txtPower:TextField;
      
      public var txtThisPower:TextField;
      
      public var txtAttr:TextField;
      
      public var cmdNo:MainButton;
      
      public var txtAttrName:TextField;
      
      public var txtNeedGold:TextField;
      
      public var txtResult:TextField;
      
      public var txtRank:TextField;
      
      public var powerBar:MovieClip;
      
      public var txtPressure:TextField;
      
      public var icon0:IconBarMC;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var icon3:IconBarMC;
      
      public var icon4:IconBarMC;
      
      public var icon5:IconBarMC;
      
      public var icon6:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var icon8:IconBarMC;
      
      public var cmdTake:MainButton;
      
      public var icon9:IconBarMC;
      
      public var icon7:IconBarMC;
      
      public var cmdPre:MainButton;
      
      public var txtPage:TextField;
      
      public var cmdOver:MainButton;
      
      public var txtNeedMoney:TextField;
      
      public var txtInfo:TextField;
      
      public var txtThisPowerValue:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdNext:MainButton;
      
      public var txtTime:TextField;
      
      public var cmdDo:MainButton;
      
      public var txtTitle1:TextField;
      
      public var txtTitle2:TextField;
      
      public var txtTitle3:TextField;
      
      public var txtTempValue:TextField;
      
      public var txtAttrValue:TextField;
      
      public var txtSuccess:TextField;
      
      public var pressureBar:MovieClip;
      
      public var txtThisPressure:TextField;
      
      public var txtThisPressureValue:TextField;
      
      public var cmdPressure:MainButton;
      
      public var txtCountdown:TextField;
      
      public var txtPressureValue:TextField;
      
      public var tempBar:MovieClip;
      
      public var txtTypeValue:TextField;
      
      public var txtTitle:TextField;
      
      public var txtType:TextField;
      
      public var txtSuccessValue:TextField;
      
      public var txtAllAttr0:TextField;
      
      public var txtAllAttr2:TextField;
      
      public var txtAllAttr4:TextField;
      
      public var txtAllAttr5:TextField;
      
      public var txtAllAttr3:TextField;
      
      public var txtAllAttr6:TextField;
      
      public var txtMax0:TextField;
      
      public var txtAllAttr8:TextField;
      
      public var txtAllAttr9:TextField;
      
      public var txtMax3:TextField;
      
      public var txtMax4:TextField;
      
      public var txtMax5:TextField;
      
      public var txtMax6:TextField;
      
      public var txtMax7:TextField;
      
      public var txtAllAttr7:TextField;
      
      public var txtMax9:TextField;
      
      public var cmdSave:MainButton;
      
      public var txtAllAttr1:TextField;
      
      public var txtMax8:TextField;
      
      public var txtMax1:TextField;
      
      public var txtMax2:TextField;
      
      public var txtDif:TextField;
      
      public var cmdPower:MainButton;
      
      public var iconResult:IconBarMC;
      
      public var txtPowerValue:TextField;
      
      public function IncubatorUIMC()
      {
         super();
         obf_0_5_i_519();
         obf_O_b_1230();
         obf_4_W_2595();
         obf_k_J_3462();
         obf_W_z_2696();
         obf_N_y_833();
         obf_9_k_3954();
         obf_v_h_2793();
         obf_z_C_3971();
         obf_I_T_2647();
      }
      
      internal function obf_I_T_2647() : *
      {
         try
         {
            cmdTake["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTake.emphasized = false;
         cmdTake.enabled = true;
         cmdTake.label = "obf___4865";
         cmdTake.labelPlacement = "right";
         cmdTake.selected = false;
         cmdTake.toggle = false;
         cmdTake.visible = true;
         try
         {
            cmdTake["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_z_C_3971() : *
      {
         try
         {
            cmdPower["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPower.emphasized = false;
         cmdPower.enabled = true;
         cmdPower.label = "obf___4924";
         cmdPower.labelPlacement = "right";
         cmdPower.selected = false;
         cmdPower.toggle = false;
         cmdPower.visible = true;
         try
         {
            cmdPower["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_v_h_2793() : *
      {
         try
         {
            cmdTemp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTemp.emphasized = false;
         cmdTemp.enabled = true;
         cmdTemp.label = "obf___4962";
         cmdTemp.labelPlacement = "right";
         cmdTemp.selected = false;
         cmdTemp.toggle = false;
         cmdTemp.visible = true;
         try
         {
            cmdTemp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_k_J_3462() : *
      {
         try
         {
            cmdNext["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNext.emphasized = false;
         cmdNext.enabled = true;
         cmdNext.label = "obf____4854";
         cmdNext.labelPlacement = "right";
         cmdNext.selected = false;
         cmdNext.toggle = false;
         cmdNext.visible = true;
         try
         {
            cmdNext["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_O_b_1230() : *
      {
         try
         {
            cmdSave["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSave.emphasized = false;
         cmdSave.enabled = true;
         cmdSave.label = "obf___4910";
         cmdSave.labelPlacement = "right";
         cmdSave.selected = false;
         cmdSave.toggle = false;
         cmdSave.visible = true;
         try
         {
            cmdSave["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_9_k_3954() : *
      {
         try
         {
            cmdPressure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPressure.emphasized = false;
         cmdPressure.enabled = true;
         cmdPressure.label = "obf___4886";
         cmdPressure.labelPlacement = "right";
         cmdPressure.selected = false;
         cmdPressure.toggle = false;
         cmdPressure.visible = true;
         try
         {
            cmdPressure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_W_2595() : *
      {
         try
         {
            cmdPre["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPre.emphasized = false;
         cmdPre.enabled = true;
         cmdPre.label = "obf____4858";
         cmdPre.labelPlacement = "right";
         cmdPre.selected = false;
         cmdPre.toggle = false;
         cmdPre.visible = true;
         try
         {
            cmdPre["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_i_519() : *
      {
         try
         {
            cmdOver["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOver.emphasized = false;
         cmdOver.enabled = true;
         cmdOver.label = "obf___4921";
         cmdOver.labelPlacement = "right";
         cmdOver.selected = false;
         cmdOver.toggle = false;
         cmdOver.visible = true;
         try
         {
            cmdOver["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_W_z_2696() : *
      {
         try
         {
            cmdDo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDo.emphasized = false;
         cmdDo.enabled = true;
         cmdDo.label = "obf___4966";
         cmdDo.labelPlacement = "right";
         cmdDo.selected = false;
         cmdDo.toggle = false;
         cmdDo.visible = true;
         try
         {
            cmdDo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_N_y_833() : *
      {
         try
         {
            cmdNo["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNo.emphasized = false;
         cmdNo.enabled = true;
         cmdNo.label = "obf___4945";
         cmdNo.labelPlacement = "right";
         cmdNo.selected = false;
         cmdNo.toggle = false;
         cmdNo.visible = true;
         try
         {
            cmdNo["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

