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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3701")]
   public dynamic class DayBonusUIMC extends MovieClip
   {
      
      public var bar1xExp:IconBarMC;
      
      public var bar2xExp:IconBarMC;
      
      public var bar4xExp:IconBarMC;
      
      public var cmdExp4x:MainButton;
      
      public var txtDeyVipLevel:TextField;
      
      public var obf_M_f_995:UIScrollBar;
      
      public var cmdToVIP:MainButton;
      
      public var txtCoin:TextField;
      
      public var vipBgBox:MovieClip;
      
      public var txtDeyCanGetOfflineBonus:TextField;
      
      public var txtDeyOfflineBonus:TextField;
      
      public var txtDeyOnlineCoin:TextField;
      
      public var txtDeyOfflineTime:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var cmdExp1x:MainButton;
      
      public var barVipExp:MovieClip;
      
      public var txtDey2xPrompt:TextField;
      
      public var txtDeyCoin:TextField;
      
      public var txtDey1xPrompt:TextField;
      
      public var txtOfflineTime:TextField;
      
      public var txtVipExpiredTime:TextField;
      
      public var txt1xExp:TextField;
      
      public var txt2xExp:TextField;
      
      public var cmdExp2x:MainButton;
      
      public var bgBox:MovieClip;
      
      public var txt4xExp:TextField;
      
      public var txtVipPrompt:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdInputBonusCode:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtVipExp:TextField;
      
      public var txtDey4xPrompt:TextField;
      
      public var cmdCoin:MainButton;
      
      public var txtDeyVipExp:TextField;
      
      public var txtDeyVip:TextField;
      
      public var txtVipLevel:TextField;
      
      public var txtDeyCoinPrompt:TextField;
      
      public function DayBonusUIMC()
      {
         super();
         obf_0_2_z_458();
         obf_C_4_2757();
         obf_7_N_4090();
         obf_F_G_3514();
         obf_R_f_4236();
         obf_7_Q_1068();
         obf_E_w_2184();
      }
      
      internal function obf_F_G_3514() : *
      {
         try
         {
            cmdExp1x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp1x.emphasized = false;
         cmdExp1x.enabled = true;
         cmdExp1x.label = "obf___4957";
         cmdExp1x.labelPlacement = "right";
         cmdExp1x.selected = false;
         cmdExp1x.toggle = false;
         cmdExp1x.visible = true;
         try
         {
            cmdExp1x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_w_2184() : *
      {
         try
         {
            cmdInputBonusCode["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdInputBonusCode.emphasized = false;
         cmdInputBonusCode.enabled = true;
         cmdInputBonusCode.label = "obf_____4725";
         cmdInputBonusCode.labelPlacement = "right";
         cmdInputBonusCode.selected = false;
         cmdInputBonusCode.toggle = false;
         cmdInputBonusCode.visible = true;
         try
         {
            cmdInputBonusCode["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_C_4_2757() : *
      {
         try
         {
            cmdExp4x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp4x.emphasized = false;
         cmdExp4x.enabled = true;
         cmdExp4x.label = "obf___4957";
         cmdExp4x.labelPlacement = "right";
         cmdExp4x.selected = false;
         cmdExp4x.toggle = false;
         cmdExp4x.visible = true;
         try
         {
            cmdExp4x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_z_458() : *
      {
         try
         {
            cmdCoin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCoin.emphasized = false;
         cmdCoin.enabled = true;
         cmdCoin.label = "obf___4957";
         cmdCoin.labelPlacement = "right";
         cmdCoin.selected = false;
         cmdCoin.toggle = false;
         cmdCoin.visible = true;
         try
         {
            cmdCoin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_7_N_4090() : *
      {
         try
         {
            cmdExp2x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp2x.emphasized = false;
         cmdExp2x.enabled = true;
         cmdExp2x.label = "obf___4957";
         cmdExp2x.labelPlacement = "right";
         cmdExp2x.selected = false;
         cmdExp2x.toggle = false;
         cmdExp2x.visible = true;
         try
         {
            cmdExp2x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_f_4236() : *
      {
         try
         {
            obf_M_f_995["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_M_f_995.direction = "vertical";
         obf_M_f_995.scrollTargetName = "txtVipPrompt";
         obf_M_f_995.visible = true;
         try
         {
            obf_M_f_995["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_7_Q_1068() : *
      {
         try
         {
            cmdToVIP["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdToVIP.emphasized = false;
         cmdToVIP.enabled = true;
         cmdToVIP.label = "obf___V_I_P_4689";
         cmdToVIP.labelPlacement = "right";
         cmdToVIP.selected = false;
         cmdToVIP.toggle = false;
         cmdToVIP.visible = false;
         try
         {
            cmdToVIP["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

