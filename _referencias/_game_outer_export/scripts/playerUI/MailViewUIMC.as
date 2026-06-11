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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4000")]
   public dynamic class MailViewUIMC extends MovieClip
   {
      
      public var cmdDelete:MainButton;
      
      public var bgBox:MovieClip;
      
      public var cmdReply:MainButton;
      
      public var txtDeyContent:TextField;
      
      public var txtSender:TextField;
      
      public var txtDeyDate:TextField;
      
      public var txtMailTitle:TextField;
      
      public var txtDeySender:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var obf_P_T_3543:UIScrollBar;
      
      public var txtContent:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyMailTitle:TextField;
      
      public var txtDate:TextField;
      
      public function MailViewUIMC()
      {
         super();
         obf_I_d_2620();
         obf_h_d_3094();
         obf_P_k_3265();
      }
      
      internal function obf_P_k_3265() : *
      {
         try
         {
            cmdReply["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReply.emphasized = false;
         cmdReply.enabled = true;
         cmdReply.label = "obf___4913";
         cmdReply.labelPlacement = "right";
         cmdReply.selected = false;
         cmdReply.toggle = false;
         cmdReply.visible = true;
         try
         {
            cmdReply["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_h_d_3094() : *
      {
         try
         {
            cmdDelete["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDelete.emphasized = false;
         cmdDelete.enabled = true;
         cmdDelete.label = "obf___4907";
         cmdDelete.labelPlacement = "right";
         cmdDelete.selected = false;
         cmdDelete.toggle = false;
         cmdDelete.visible = true;
         try
         {
            cmdDelete["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_I_d_2620() : *
      {
         try
         {
            obf_P_T_3543["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_P_T_3543.direction = "vertical";
         obf_P_T_3543.scrollTargetName = "txtContent";
         obf_P_T_3543.visible = true;
         try
         {
            obf_P_T_3543["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

