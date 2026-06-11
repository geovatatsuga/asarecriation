package playerUI
{
   import adobe.utils.*;
   import fl.controls.DataGrid;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1355")]
   public dynamic class MailUIMC extends MovieClip
   {
      
      public var cmdPreviousPage:MainButton;
      
      public var bgBox:MovieClip;
      
      public var cmdDelMail:MainButton;
      
      public var cmdViewMail:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var listMail:DataGrid;
      
      public var cmdSendMail:MainButton;
      
      public var cmdNextPage:MainButton;
      
      public function MailUIMC()
      {
         super();
         obf_s_R_3055();
         obf_d_R_1026();
         obf_X_c_2579();
         obf_R_U_1337();
         obf_0_2_g_139();
      }
      
      internal function obf_R_U_1337() : *
      {
         try
         {
            cmdViewMail["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdViewMail.emphasized = false;
         cmdViewMail.enabled = true;
         cmdViewMail.label = "obf_____4755";
         cmdViewMail.labelPlacement = "right";
         cmdViewMail.selected = false;
         cmdViewMail.toggle = false;
         cmdViewMail.visible = true;
         try
         {
            cmdViewMail["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_c_2579() : *
      {
         try
         {
            cmdSendMail["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSendMail.emphasized = false;
         cmdSendMail.enabled = true;
         cmdSendMail.label = "obf_____4707";
         cmdSendMail.labelPlacement = "right";
         cmdSendMail.selected = false;
         cmdSendMail.toggle = false;
         cmdSendMail.visible = true;
         try
         {
            cmdSendMail["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_d_R_1026() : *
      {
         try
         {
            cmdNextPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNextPage.emphasized = false;
         cmdNextPage.enabled = true;
         cmdNextPage.label = "obf____4854>";
         cmdNextPage.labelPlacement = "right";
         cmdNextPage.selected = false;
         cmdNextPage.toggle = false;
         cmdNextPage.visible = true;
         try
         {
            cmdNextPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_g_139() : *
      {
         try
         {
            cmdDelMail["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDelMail.emphasized = false;
         cmdDelMail.enabled = true;
         cmdDelMail.label = "obf_____4712";
         cmdDelMail.labelPlacement = "right";
         cmdDelMail.selected = false;
         cmdDelMail.toggle = false;
         cmdDelMail.visible = true;
         try
         {
            cmdDelMail["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_s_R_3055() : *
      {
         try
         {
            cmdPreviousPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPreviousPage.emphasized = false;
         cmdPreviousPage.enabled = true;
         cmdPreviousPage.label = "<obf____4858";
         cmdPreviousPage.labelPlacement = "right";
         cmdPreviousPage.selected = false;
         cmdPreviousPage.toggle = false;
         cmdPreviousPage.visible = true;
         try
         {
            cmdPreviousPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

