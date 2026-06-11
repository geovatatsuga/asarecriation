package mmorpg
{
   import ControlClass.MJCheckBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol86")]
   public dynamic class LoginUI extends MovieClip
   {
      
      public var txtDeyLogin:TextField;
      
      public var cmdLogin:SimpleButton;
      
      public var txtPassword:MJInput;
      
      public var chkRemember:MJCheckBox;
      
      public var txtUser:MJInput;
      
      public function LoginUI()
      {
         super();
         obf_t_3876();
         obf_7_A_1467();
      }
      
      internal function obf_7_A_1467() : *
      {
         try
         {
            chkRemember["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkRemember.enabled = true;
         chkRemember.label = "obf_____4733";
         chkRemember.labelPlacement = "right";
         chkRemember.selected = false;
         chkRemember.visible = true;
         try
         {
            chkRemember["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_t_3876() : *
      {
         try
         {
            txtPassword["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtPassword.displayAsPassword = true;
         txtPassword.editable = true;
         txtPassword.enabled = true;
         txtPassword.maxChars = 0;
         txtPassword.restrict = "";
         txtPassword.text = "";
         txtPassword.visible = true;
         try
         {
            txtPassword["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

