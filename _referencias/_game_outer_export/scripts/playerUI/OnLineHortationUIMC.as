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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol416")]
   public dynamic class OnLineHortationUIMC extends MovieClip
   {
      
      public var cmdToVIP:MainButton;
      
      public var txtDeyVipLevel:TextField;
      
      public var InstanceName_0:MovieClip;
      
      public var obf_M_f_995:UIScrollBar;
      
      public var txtVipExp:TextField;
      
      public var txtCoin:TextField;
      
      public var txtVipPrompt:TextField;
      
      public var cmdCoin:MainButton;
      
      public var txtDeyOnlineCoin:TextField;
      
      public var txtDeyVipExp:TextField;
      
      public var barVipExp:MovieClip;
      
      public var txtDeyVip:TextField;
      
      public var txtVipLevel:TextField;
      
      public var txtDeyCoin:TextField;
      
      public var txtDeyCoinPrompt:TextField;
      
      public function OnLineHortationUIMC()
      {
         super();
         obf_0_9_H_586();
         obf_Y_T_1662();
         obf_e_5_2230();
      }
      
      internal function obf_e_5_2230() : *
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
      
      internal function obf_0_9_H_586() : *
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
      
      internal function obf_Y_T_1662() : *
      {
         try
         {
            obf_M_f_995["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_M_f_995.direction = "vertical";
         obf_M_f_995.scrollTargetName = "InstanceName_0";
         obf_M_f_995.visible = true;
         try
         {
            obf_M_f_995["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

