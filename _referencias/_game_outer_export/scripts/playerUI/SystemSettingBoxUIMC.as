package playerUI
{
   import ControlClass.MJCheckBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3080")]
   public dynamic class SystemSettingBoxUIMC extends MovieClip
   {
      
      public var txtDeyShowPlayersCount:TextField;
      
      public var txtDeyGameEffectSound:TextField;
      
      public var bgBox:MovieClip;
      
      public var static:UIScrollBar;
      
      public var obf_t_n_1765:UIScrollBar;
      
      public var txtMusic:TextField;
      
      public var txtDeyGameMuisc:TextField;
      
      public var obf_n_C_3824:UIScrollBar;
      
      public var chkDisConfirmBox:MJCheckBox;
      
      public var scrollMaxPlayers:UIScrollBar;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeySound:TextField;
      
      public var titleBox:MovieClip;
      
      public var effectMC:MovieClip;
      
      public var chkClickAttack:MJCheckBox;
      
      public var chkAutoPressRide:MJCheckBox;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyEffect:TextField;
      
      public var txtDeyControl:TextField;
      
      public var txtMaxPlayers:TextField;
      
      public var txtSound:TextField;
      
      public function SystemSettingBoxUIMC()
      {
         super();
         __setProp_chkAutoPressRide_SystemSettingBoxUIMC_content_0();
         obf_4_7_1371();
         obf_k_5_3708();
         __setProp_scrollMaxPlayers_SystemSettingBoxUIMC_txt_0();
         obf_D_y_2433();
      }
      
      internal function __setProp_scrollMaxPlayers_SystemSettingBoxUIMC_txt_0() : *
      {
         try
         {
            scrollMaxPlayers["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollMaxPlayers.direction = "horizontal";
         scrollMaxPlayers.scrollTargetName = "";
         scrollMaxPlayers.visible = true;
         try
         {
            scrollMaxPlayers["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_k_5_3708() : *
      {
         try
         {
            chkDisConfirmBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkDisConfirmBox.enabled = true;
         chkDisConfirmBox.label = "obf______4661";
         chkDisConfirmBox.labelPlacement = "right";
         chkDisConfirmBox.selected = false;
         chkDisConfirmBox.visible = true;
         try
         {
            chkDisConfirmBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_y_2433() : *
      {
         try
         {
            obf_t_n_1765["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_t_n_1765.direction = "vertical";
         obf_t_n_1765.scrollTargetName = "bgBox";
         obf_t_n_1765.visible = true;
         try
         {
            obf_t_n_1765["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_7_1371() : *
      {
         try
         {
            chkClickAttack["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkClickAttack.enabled = true;
         chkClickAttack.label = "obf_______1058";
         chkClickAttack.labelPlacement = "right";
         chkClickAttack.selected = false;
         chkClickAttack.visible = true;
         try
         {
            chkClickAttack["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_chkAutoPressRide_SystemSettingBoxUIMC_content_0() : *
      {
         try
         {
            chkAutoPressRide["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoPressRide.enabled = true;
         chkAutoPressRide.label = "obf_________40";
         chkAutoPressRide.labelPlacement = "right";
         chkAutoPressRide.selected = false;
         chkAutoPressRide.visible = true;
         try
         {
            chkAutoPressRide["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

