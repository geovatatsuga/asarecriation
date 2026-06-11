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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4941")]
   public dynamic class PasswordChangeUIMC extends MovieClip
   {
      
      public var inputNewPassword1:MJInput;
      
      public var inputNewPassword2:MJInput;
      
      public var txtDeyNewPassword1:TextField;
      
      public var cmdOK:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var inputOldPassword:MJInput;
      
      public var txtDeyOldPassword:TextField;
      
      public var cmdCancel:MainButton;
      
      public var txtDeyNewPassword2:TextField;
      
      public function PasswordChangeUIMC()
      {
         super();
         obf_1_M_2212();
         obf_c_I_4223();
         obf_G_m_949();
         obf_0_3_S_599();
         obf_0_6_C_587();
      }
      
      internal function obf_G_m_949() : *
      {
         try
         {
            inputNewPassword2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputNewPassword2.displayAsPassword = true;
         inputNewPassword2.editable = true;
         inputNewPassword2.enabled = true;
         inputNewPassword2.maxChars = 0;
         inputNewPassword2.restrict = "";
         inputNewPassword2.text = "";
         inputNewPassword2.visible = true;
         try
         {
            inputNewPassword2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_c_I_4223() : *
      {
         try
         {
            inputNewPassword1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputNewPassword1.displayAsPassword = true;
         inputNewPassword1.editable = true;
         inputNewPassword1.enabled = true;
         inputNewPassword1.maxChars = 0;
         inputNewPassword1.restrict = "";
         inputNewPassword1.text = "";
         inputNewPassword1.visible = true;
         try
         {
            inputNewPassword1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_6_C_587() : *
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
      
      internal function obf_1_M_2212() : *
      {
         try
         {
            inputOldPassword["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputOldPassword.displayAsPassword = true;
         inputOldPassword.editable = true;
         inputOldPassword.enabled = true;
         inputOldPassword.maxChars = 0;
         inputOldPassword.restrict = "";
         inputOldPassword.text = "";
         inputOldPassword.visible = true;
         try
         {
            inputOldPassword["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_3_S_599() : *
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
   }
}

