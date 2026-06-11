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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2285")]
   public dynamic class TradeCheckUIMC extends MovieClip
   {
      
      public var txtInputNum:MJInput;
      
      public var txtDeyTitle:TextField;
      
      public var txTradeString:TextField;
      
      public var cmdVerify:MainButton;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function TradeCheckUIMC()
      {
         super();
         obf_2_D_1619();
         obf_2_A_3846();
      }
      
      internal function obf_2_D_1619() : *
      {
         try
         {
            cmdVerify["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdVerify.emphasized = false;
         cmdVerify.enabled = true;
         cmdVerify.label = "obf_____4772";
         cmdVerify.labelPlacement = "right";
         cmdVerify.selected = false;
         cmdVerify.toggle = false;
         cmdVerify.visible = true;
         try
         {
            cmdVerify["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_2_A_3846() : *
      {
         try
         {
            txtInputNum["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtInputNum.displayAsPassword = false;
         txtInputNum.editable = true;
         txtInputNum.enabled = true;
         txtInputNum.maxChars = 6;
         txtInputNum.restrict = "0-9";
         txtInputNum.text = "";
         txtInputNum.visible = true;
         try
         {
            txtInputNum["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

