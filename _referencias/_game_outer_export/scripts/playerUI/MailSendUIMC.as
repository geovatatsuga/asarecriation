package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1553")]
   public dynamic class MailSendUIMC extends MovieClip
   {
      
      public var txtDeyMailTitle:TextField;
      
      public var obf_4_X_1414:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var txtCost:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdSend:MainButton;
      
      public var txtContent:TextField;
      
      public var inputTitle:MJInput;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyTarget:TextField;
      
      public var inputTarget:MJInput;
      
      public function MailSendUIMC()
      {
         super();
         obf_2_H_2233();
         obf_Y_Q_2991();
         obf_b_v_4614();
         obf_U_W_3563();
      }
      
      internal function obf_2_H_2233() : *
      {
         try
         {
            inputTitle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTitle.displayAsPassword = false;
         inputTitle.editable = true;
         inputTitle.enabled = true;
         inputTitle.maxChars = 12;
         inputTitle.restrict = "";
         inputTitle.text = "";
         inputTitle.visible = true;
         try
         {
            inputTitle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_v_4614() : *
      {
         try
         {
            obf_4_X_1414["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_4_X_1414.direction = "vertical";
         obf_4_X_1414.scrollTargetName = "txtContent";
         obf_4_X_1414.visible = true;
         try
         {
            obf_4_X_1414["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Y_Q_2991() : *
      {
         try
         {
            inputTarget["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTarget.displayAsPassword = false;
         inputTarget.editable = true;
         inputTarget.enabled = true;
         inputTarget.maxChars = 6;
         inputTarget.restrict = "";
         inputTarget.text = "";
         inputTarget.visible = true;
         try
         {
            inputTarget["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_U_W_3563() : *
      {
         try
         {
            cmdSend["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSend.emphasized = false;
         cmdSend.enabled = true;
         cmdSend.label = "obf___4869";
         cmdSend.labelPlacement = "right";
         cmdSend.selected = false;
         cmdSend.toggle = false;
         cmdSend.visible = true;
         try
         {
            cmdSend["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

